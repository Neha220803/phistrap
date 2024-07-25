// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phistrap/Utils/constants.dart';

class LinkPage extends StatefulWidget {
  const LinkPage({super.key});

  @override
  State<LinkPage> createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  final _formKey = GlobalKey<FormState>();
  final _linkController = TextEditingController();
  String _responseMessage = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        children: [
          Text(
            "Check Any URL's Content",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _linkController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 2.5,
                    color: primaryColor,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                hintText: "Enter any Link",
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                backgroundColor: primaryColor,
                foregroundColor: white,
                fixedSize: const Size(350, 50),
              ),
              onPressed: () {
                _sendRequest(_linkController.text);
                _passUrl(_linkController.text);
              },
              child: Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontSize: 19.32,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _sendRequest(String url) async {
    try {
      var response = await http.post(
        Uri.parse('https://phising-url-api.onrender.com/'),
        body: json.encode({'url': url}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          _responseMessage = '';
          responseData.forEach((key, value) {
            _responseMessage += '$key: $value\n';
          });
        });
      } else {
        setState(() {
          _responseMessage = 'Failed to get response: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseMessage = 'Error: $e';
      });
    }
  }

  void _passUrl(String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Result"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Results for the URL is listed down below:"),
                // SizedBox(height: 10),
                Text(_responseMessage),
              ],
            ),
          ),
        );
      },
    );
  }
}
