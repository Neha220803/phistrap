// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:phistrap/Pages/BottomNavBar/calls_page.dart';
import 'package:phistrap/Pages/BottomNavBar/email_page.dart';
import 'package:phistrap/Pages/BottomNavBar/link_page.dart';
import 'package:phistrap/Pages/BottomNavBar/mssg_page.dart';
import 'package:phistrap/Pages/SideNavBar/side_nav_bar.dart';
import 'package:phistrap/Utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  static final List<Widget> _widgetOptions = <Widget>[
    const CallLogScreen(),
    const SMSPage(),
    const EmailScreen(),
    const LinkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text(
          "Phis-Trap",
          style: TextStyle(color: white),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: white),
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
        backgroundColor: primaryColor,
        items: <TabItem>[
          const TabItem(
            icon: Icons.call,
            title: 'Calls',
          ),
          const TabItem(icon: Icons.message, title: 'SMS'),
          const TabItem(icon: Icons.email, title: 'email'),
          const TabItem(icon: Icons.link, title: 'Link'),
        ],
        onTap: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 700),
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
