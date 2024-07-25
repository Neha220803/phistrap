import 'package:flutter/material.dart';
import 'package:phistrap/Utils/constants.dart';

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
        title: const Text(
          'Reports',
          style: TextStyle(color: white),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: white), // Set the icon color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Suspecious URLs"),
            GestureDetector(
              child: const Card(
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
            const SizedBox(
              height: 10,
            ),
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text("	http://jhvjhkbv.ubpages.com/xjhch/"),
                trailing: Icon(Icons.forward),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text("	https://dcgfrmz029.wixsite.com/my-site"),
                trailing: Icon(Icons.forward),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text("https://mrbw50660.wixsite.com/my-site"),
                trailing: Icon(Icons.forward),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text("	https://mailzim.webflow.io/"),
                trailing: Icon(Icons.forward),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Card(
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
            title: const Text('Trace Back Route'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Hop')),
                      DataColumn(label: Text('IP Address')),
                      DataColumn(label: Text('Domain Name')),
                    ],
                    rows: const [
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
                child: const Text('OK'),
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
