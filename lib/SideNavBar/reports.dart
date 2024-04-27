// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF002D56),
        iconTheme: IconThemeData(color: Colors.white), // Set the icon color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Suspecious URLs"),
            GestureDetector(
              child: Card(
                elevation: 4,
                child: ListTile(
                  title: Text("https://smbc-card.myfamilypharmacy.net"),
                  trailing: Icon(Icons.forward),
                ),
              ),
              onTap: () {
                // Call the function to show the pop-up when tapped
                _showPopup(context);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text("	http://jhvjhkbv.ubpages.com/xjhch/"),
                trailing: Icon(Icons.forward),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text("	https://dcgfrmz029.wixsite.com/my-site"),
                trailing: Icon(Icons.forward),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text("https://mrbw50660.wixsite.com/my-site"),
                trailing: Icon(Icons.forward),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text("	https://mailzim.webflow.io/"),
                trailing: Icon(Icons.forward),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text("	https://youhavetoupgarde.weeblysite.com/"),
                trailing: Icon(Icons.forward),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AlertDialog(
            title: Text('Trace Back Route'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Hop')),
                      DataColumn(label: Text('IP Address')),
                      DataColumn(label: Text('Domain Name')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('1')),
                        DataCell(Text('169.254.158.58')),
                        DataCell(Text('')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2')),
                        DataCell(Text('169.48.118.158')),
                        DataCell(Text('ae103.ppr02.dal13.networklayer.com')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3')),
                        DataCell(Text('169.48.118.130')),
                        DataCell(Text('82.76.30a9.ip4.static.sl-reverse.com')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('4')),
                        DataCell(Text('*')),
                        DataCell(Text('*')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('5')),
                        DataCell(Text('169.45.18.7')),
                        DataCell(Text('ae2.cbs01.cs01.lax01.networklayer.com')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('6')),
                        DataCell(Text('*')),
                        DataCell(Text('*')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('7')),
                        DataCell(Text('50.97.17.87')),
                        DataCell(Text('ae0.cbs02.eq01.sjc02.networklayer.com')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('8')),
                        DataCell(Text('50.97.17.77')),
                        DataCell(
                            Text('ae24.bbr01.eq01.sjc02.networklayer.com')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('9')),
                        DataCell(Text('50.97.16.126')),
                        DataCell(Text('7e.10.6132.ip4.static.sl-reverse.com')),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
