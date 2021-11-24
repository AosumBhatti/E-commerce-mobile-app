import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/tabs/home_tab.dart';
import 'package:firstapp/tabs/saved_tab.dart';
import 'package:firstapp/tabs/search_tab.dart';
import 'package:firstapp/widgets/bottomtabs.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/constant.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  PageController _pageController;
  int _selectedTab = 0;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (pageIndex) {
              setState(() {
                _selectedTab = pageIndex;
              });
            },
            children: [
              HomeTab(),
              SearchTab(),
              SavedTab(),
            ],
          ),
        ),
        BottomTabs(
          selectedTab: _selectedTab,
          pressTabPage: (selectedPageTab) {
            _pageController.animateToPage(selectedPageTab,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutCubic);
          },
        ),
      ],
    ));
  }
}
