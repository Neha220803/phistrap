import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phistrap/Utils/constants.dart';
import 'package:phistrap/Widgets/custom_button.dart';
import 'package:phistrap/Widgets/custom_text.dart';
import 'package:phistrap/Widgets/custom_text_field.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        children: [
          const CustomText(
            value: "Check Any URL's Content",
            size: 20,
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: CustomTextField(
              labelText: "Enter a link",
              errorText: "Please Enter a link",
              controller: _linkController,
            ),
          ),
          const SizedBox(height: 40),
          Center(
              child: CustomButton(
                  text: "Submit",
                  color: primaryColor,
                  fixedSize: const Size(350, 55),
                  callback: () {
                    _sendRequest(_linkController.text);
                    _passUrl(_linkController.text);
                  }))
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
          title: const Text("Result"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Results for the URL is listed down below:"),
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
