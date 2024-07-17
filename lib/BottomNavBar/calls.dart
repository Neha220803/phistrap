import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class CallLogScreen extends StatefulWidget {
  const CallLogScreen({super.key});

  @override
  CallLogScreenState createState() => CallLogScreenState();
}

class CallLogScreenState extends State<CallLogScreen> {
  List<CallLogEntry> callLogs = [];
  List<CallLogEntry> filteredLogs = [];
  bool isFilterApplied = false;
  CallType? selectedCallType;
  bool isDarkThemeEnabled = false; // Variable to track the state of the theme

  @override
  void initState() {
    super.initState();
    _checkPermissionAndLoadCallLogs();
  }

  Future<void> _checkPermissionAndLoadCallLogs() async {
    if (await Permission.phone.request().isGranted) {
      _loadCallLogs();
    } else {
      showToast("Please provide phone permission");
      openAppSettings();
    }
  }

  Future<void> _loadCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    setState(() {
      callLogs = entries.toList();
    });
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: isFilterApplied ? filteredLogs.length : callLogs.length,
        itemBuilder: (context, index) {
          final CallLogEntry log =
              isFilterApplied ? filteredLogs[index] : callLogs[index];
          Color iconColor;
          IconData leadingIcon;

          if (log.callType == CallType.incoming) {
            iconColor = Colors.blue;
            leadingIcon = Icons.call_received;
          } else if (log.callType == CallType.outgoing) {
            iconColor = Colors.green;
            leadingIcon = Icons.call_made;
          } else if (log.callType == CallType.missed) {
            iconColor = Colors.red;
            leadingIcon = Icons.call_missed;
          } else {
            iconColor =
                const Color(0xFF000000); // Default color for unknown types
            leadingIcon = Icons.call; // Default icon for unknown types
          }

          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0x00000000), width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              tileColor: const Color.fromARGB(255, 255, 255, 255),
              leading: Icon(
                leadingIcon,
                color: iconColor,
              ),
              // trailing:
              //     ElevatedButton(onPressed: () {}, child: Text("Report Spam")),
              title:
                  Text('${log.name ?? 'Unknown'} : ${log.number ?? 'Unknown'}'),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duration: ${_formatDuration(log.duration)} | Time: ${_formatTime(log.timestamp)}',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Report Submitted"),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor:
                          Colors.white, // Set the text color to black
                      side: const BorderSide(
                          color: Colors.red), // Set the border color to red
                      minimumSize: const Size(0,
                          30), // Set the minimum size to make it as small as possible
                    ),
                    child: const Text("Report Spam"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _refreshData() async {
    await _loadCallLogs(); // Reload call logs
  }


  String _formatDuration(int? seconds) {
    if (seconds == null) return 'Unknown';
    final Duration duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.padLeft(8, "0");
  }

  String _formatTime(int? timestamp) {
    if (timestamp == null) return 'Unknown';
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }
}
