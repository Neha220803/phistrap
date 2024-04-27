import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class CallLogScreen extends StatefulWidget {
  @override
  _CallLogScreenState createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
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
            iconColor = Color(0xFF000000); // Default color for unknown types
            leadingIcon = Icons.call; // Default icon for unknown types
          }

          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(00000), width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              tileColor: Color.fromARGB(255, 255, 255, 255),
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
                          return AlertDialog(
                            title: Text("Report Submitted"),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .white, // Set the background color to transparent
                      onPrimary: Colors.black, // Set the text color to black
                      side: BorderSide(
                          color: Colors.red), // Set the border color to red
                      minimumSize: Size(0,
                          30), // Set the minimum size to make it as small as possible
                    ),
                    child: Text("Report Spam"),
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
    _clearFilter(); // Clear any applied filter
    await _loadCallLogs(); // Reload call logs
  }

  void _showFilterDialog() async {
    final selectedValue = await showDialog<CallType>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Call Type'),
          content: DropdownButtonFormField<CallType>(
            value: selectedCallType,
            items: [
              DropdownMenuItem(
                value: CallType.incoming,
                child: Text('Incoming Calls'),
              ),
              DropdownMenuItem(
                value: CallType.outgoing,
                child: Text('Outgoing Calls'),
              ),
              DropdownMenuItem(
                value: CallType.missed,
                child: Text('Missed Calls'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedCallType = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _applyFilter();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _applyFilter() {
    if (selectedCallType != null) {
      setState(() {
        filteredLogs =
            callLogs.where((log) => log.callType == selectedCallType).toList();
        isFilterApplied = true;
      });
    }
  }

  void _clearFilter() {
    setState(() {
      isFilterApplied = false;
      selectedCallType = null; // Clear selected call type
      filteredLogs.clear(); // Clear filtered logs
    });
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
