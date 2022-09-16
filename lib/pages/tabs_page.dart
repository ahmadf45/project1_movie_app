import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project1_movie_app/config/variables.dart';
import 'package:project1_movie_app/pages/error_page.dart';
import 'package:project1_movie_app/pages/home_page.dart';
import 'package:project1_movie_app/pages/profile_page.dart';

class TabsPage extends StatefulWidget {
  final int i;
  const TabsPage({Key? key, required this.i}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _page = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ProfilePage()
  ];
  final iconList = <IconData>[Icons.home, Icons.notifications, Icons.person];

  @override
  void initState() {
    super.initState();
    _page = widget.i;
  }

  @override
  Widget build(BuildContext context) {
    DateTime pre_backpress = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= const Duration(seconds: 1);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            EasyLoading.showToast("Press Back button again to Exit",
                toastPosition: EasyLoadingToastPosition.bottom,
                duration: const Duration(seconds: 1));
            return false; // false will do nothing when back press
          } else {
            return true; // true will exit the app
          }
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _page,
          children: _widgetOptions,
        ),
        // bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        //   backgroundColor: Colors.transparent,
        //   // color: Colors.amber,
        //   height: 60,
        //   //gapLocation: GapLocation.center,
        //   tabBuilder: (int index, bool isActive) {
        //     final color = isActive ? primaryColor : Colors.white;
        //     return Center(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(
        //             iconList[index],
        //             size: 24,
        //             color: color,
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        //   // icons: const [Icons.home, Icons.notifications, Icons.person],
        //   onTap: (index) {
        //     setState(() {
        //       _page = index;
        //     });
        //   },
        //   activeIndex: _page, itemCount: 3,
        // ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _page = 0;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.home,
                    size: 30,
                    color: _page == 0 ? activeColor : Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _page = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: _page == 1 ? activeColor : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
