import 'package:flutter/material.dart';
import 'package:phistrap/Utils/constants.dart';

class HelpLine extends StatefulWidget {
  const HelpLine({super.key});

  @override
  State<HelpLine> createState() => _HelpLineState();
}

class _HelpLineState extends State<HelpLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help Line',
          style: TextStyle(color: white),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: white), // Set the icon color
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHelpLineCard(
                title: "Police Help Line",
                subtitle: "100",
              ),
              _buildHelpLineCard(
                title: "Women Help Line",
                subtitle: "181",
              ),
              _buildHelpLineCard(
                title: "Child Help Line",
                subtitle: "1098",
              ),
              _buildHelpLineCard(
                title: "Cyber Crime Help Line",
                subtitle: "1930",
              ),
              _buildHelpLineCard(
                title: "Anti Ragging Helpline",
                subtitle: "1800-180-5522",
              ),
              _buildHelpLineCard(
                title: "Accident Help Line",
                subtitle: "108",
              ),
              _buildHelpLineCard(
                title: "Fire Control Room",
                subtitle: "101",
              ),
              _buildHelpLineCard(
                title: "Railway Help Line",
                subtitle: "138",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpLineCard({
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: const Icon(Icons.phone),
      ),
    );
  }
}
