import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:phistrap/Utils/constants.dart';

class SMSPage extends StatefulWidget {
  const SMSPage({super.key});
  @override
  State<SMSPage> createState() => _SMSPageState();
}

class _SMSPageState extends State<SMSPage> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  final Map<int, String> _translatedMessages = {};

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [
          SmsQueryKind.inbox,
          SmsQueryKind.sent,
        ],
        count: 10,
      );
      debugPrint('SMS inbox messages: ${messages.length}');

      setState(() => _messages = messages);
      fetchTranslatedMessages(); // Fetch translated message for each SMS
    } else {
      await Permission.sms.request();
    }
  }

  Future<void> fetchTranslatedMessages() async {
    try {
      for (var message in _messages) {
        final response = await http.post(
          Uri.parse('$baseURl/spam-detection'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'message': message.body!}),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          final translatedMessage =
              data['translated_message']; // Store as String
          setState(() {
            _translatedMessages[message.id!] = translatedMessage;
          });
        } else {
          throw Exception('Failed to fetch translated message');
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching translated message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: _messages.isNotEmpty
            ? _MessagesListView(
                messages: _messages,
                translatedMessages: _translatedMessages,
              )
            : const Center(
                child: Text(
                  'No messages to show.\n Tap refresh button...',
                  textAlign: TextAlign.center,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchMessages,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _MessagesListView extends StatelessWidget {
  const _MessagesListView({
    Key? key,
    required this.messages,
    required this.translatedMessages,
  }) : super(key: key);

  final List<SmsMessage> messages;
  final Map<int, String> translatedMessages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int i) {
        var message = messages[i];
        var translatedMessage = translatedMessages[message.id] ?? '';
        var isTranslatedToOne = translatedMessage == '1';
        var cardColor =
            isTranslatedToOne ? red : white;

        return Card(
          elevation: 4,
          color: cardColor,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${message.sender}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  '${message.date},',
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
            subtitle: Text('${message.body}'),
            // Text('Translated Message: $translatedMessage'),
          ),
        );
      },
    );
  }
}
