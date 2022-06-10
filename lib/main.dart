// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unnecessary_brace_in_string_interps

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

bool isNumeric(String s) {
  // ignore: unnecessary_null_comparison
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const String countryCode = '+91';

void _launchUrl(url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String mobileNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whtsapp Msg without Save'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Mobile Number',
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (String val) {
                        setState(() {
                          mobileNumber = val;
                        });
                      },
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            !isNumeric(value) ||
                            value.length < 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 29),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(10))),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          final Uri whatsappUrl = Uri.parse(
                              'https://wa.me/$countryCode$mobileNumber');
                          print('going to launch $whatsappUrl');
                          _launchUrl(whatsappUrl);
                        },
                        icon: Icon(Icons.message),
                        label: Text('Open Whatsapp chat')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
