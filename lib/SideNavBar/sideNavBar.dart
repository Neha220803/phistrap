// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:phistrap/SideNavBar/helpLine.dart';
import 'package:phistrap/SideNavBar/reports.dart';
import 'package:phistrap/login_page.dart';

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
            decoration: BoxDecoration(color: Color(0xFF002D56)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 109,
                    height: 109,
                    child: CircleAvatar(backgroundColor: Colors.blueGrey),
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
                      "skdhv",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
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
                        color: Colors.white,
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text("Spam Analytics"),
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => searComm()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Helpline Forum'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HelpLine()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.report),
            title: Text("Report"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Report()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Invitations()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => PaymentPage()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Log Out"),
            onTap: () async {
              // FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
              );
            },
          ),
          Divider(),
        ],
      ),
    ));
  }
}
