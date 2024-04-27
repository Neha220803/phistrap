import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailData {
  final String sender;
  final String subject;
  final String body;

  EmailData({required this.sender, required this.subject, required this.body});

  factory EmailData.fromJson(Map<String, dynamic> json) {
    return EmailData(
      sender: json['sender'],
      subject: json['subject'],
      body: json['body'],
    );
  }
}

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  late Future<List<EmailData>> futureEmailData;
  late ScrollController _scrollController;
  List<EmailData> emails = [];
  int offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    futureEmailData = fetchEmailData();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Load the next set of emails when the user reaches the end of the list
      offset += 20;
      fetchEmailData();
    }
  }
  

  Future<List<EmailData>> fetchEmailData() async {
    final response =
        await http.get(Uri.parse('http://172.31.99.232:80/?offset=$offset'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        emails.addAll(jsonData.map((item) => EmailData.fromJson(item)));
      });
      return emails;
    } else {
      throw Exception('Failed to load email data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EmailData>>(
      future: futureEmailData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No emails available.'),
          );
        } else {
          return ListView.builder(
            controller: _scrollController,
            itemCount: 30,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                elevation: 4,
                child: ListTile(
                  title: Text(snapshot.data![index].sender),
                  subtitle: Text(snapshot.data![index].subject),
                  onTap: () {},
                ),
              );
            },
          );
        }
      },
    );
  }
}
