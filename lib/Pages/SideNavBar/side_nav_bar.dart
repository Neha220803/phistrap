import 'package:flutter/material.dart';
import 'package:phistrap/Pages/SideNavBar/help_line.dart';
import 'package:phistrap/Pages/SideNavBar/reports.dart';
import 'package:phistrap/Pages/login_page.dart';
import 'package:phistrap/Utils/constants.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  // final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 341,
            height: 250,
            decoration: const BoxDecoration(color: primaryColor),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 109,
                    height: 109,
                    child: CircleAvatar(
                      backgroundColor: opaquePrimaryColor,
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    // decoration: ShapeDecoration(
                    //   // image: DecorationImage(
                    //   //   image: AssetImage("images/u0.png"),
                    //   //   fit: BoxFit.cover,
                    //   // ),
                    //   // shape: RoundedRectangleBorder(
                    //   //   side: BorderSide(width: 3, color: Color(0xFFFF6A6A)),
                    //   //   borderRadius: BorderRadius.circular(79),
                    //   // ),
                    // ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 143,
                    height: 26.60,
                    child: Text(
                      "Neha",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontSize: 23,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 58,
                    height: 12.81,
                    child: Text(
                      'View Profile',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: white,
                        fontSize: 11,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  )
                ]),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text("Spam Analytics"),
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => searComm()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Helpline Forum'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpLine()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text("Report"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Report()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Invitations()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => PaymentPage()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.arrow_back),
            title: const Text("Log Out"),
            onTap: () async {
              // FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LogIn()),
              );
            },
          ),
          const Divider(),
        ],
      ),
    ));
  }
}
