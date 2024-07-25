// import 'dart:convert';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
// import 'package:phistrap/Utils/constants.dart';
// import 'package:http/http.dart' as http;

// final Map<int, String> _translatedMessages = {};

// List<SmsMessage> _messages = [];

// Future<void> fetchTranslatedMessages() async {
//   try {
//     for (var message in _messages) {
//       final response = await http.post(
//         Uri.parse('$baseURl/spam-detection'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{'message': message.body!}),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         final translatedMessage = data['translated_message']; // Store as String
//         setState(() {
//           _translatedMessages[message.id!] = translatedMessage;
//         });
//       } else {
//         throw Exception('Failed to fetch translated message');
//       }
//     }
//   } catch (e) {
//     // ignore: avoid_print
//     print('Error fetching translated message: $e');
//   }
// }
