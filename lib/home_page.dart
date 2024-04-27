// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:phistrap/BottomNavBar/calls.dart';
import 'package:phistrap/BottomNavBar/emal_page.dart';
import 'package:phistrap/BottomNavBar/link_page.dart';
import 'package:phistrap/BottomNavBar/mssg_page.dart';
import 'package:phistrap/SideNavBar/sideNavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  static final List<Widget> _widgetOptions = <Widget>[
    CallLogScreen(),
    SMSPage(),
    EmailScreen(),
    LinkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text(
          "Phis-Trap",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF002D56),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _widgetOptions.length,
              itemBuilder: (context, index) {
                return _widgetOptions[index];
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xFF002D56),
        items: <TabItem>[
          TabItem(
            icon: Icons.call,
            title: 'Calls',
          ),
          TabItem(icon: Icons.message, title: 'SMS'),
          TabItem(icon: Icons.email, title: 'email'),
          TabItem(icon: Icons.link, title: 'Link'),
        ],
        onTap: (int index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
          setState(() {
            _currentPage = index;
          });
        },
        initialActiveIndex: _currentPage,
        style: TabStyle.reactCircle,
        height: 60,
      ),
    );
  }
}
