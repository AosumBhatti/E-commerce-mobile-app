import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/constant.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) pressTabPage;
  BottomTabs({this.selectedTab, this.pressTabPage});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 1;
  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 30.0,
              spreadRadius: 1.0,
              color: Colors.black.withOpacity(0.05),
            )
          ]),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabsBtn(
                buttonName: "home",
                selected: _selectedTab == 0 ? true : false,
                onPressed: () {
                  widget.pressTabPage(0);
                }),
            BottomTabsBtn(
              buttonName: "search",
              selected: _selectedTab == 1 ? true : false,
              onPressed: () {
                widget.pressTabPage(1);
              },
            ),
            BottomTabsBtn(
              buttonName: "saved",
              selected: _selectedTab == 2 ? true : false,
              onPressed: () {
                widget.pressTabPage(2);
              },
            ),
            BottomTabsBtn(
              buttonName: "logout",
              selected: _selectedTab == 3 ? true : false,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomTabsBtn extends StatelessWidget {
  final String buttonName;
  final bool selected;
  final Function onPressed;
  BottomTabsBtn({this.buttonName, this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        child: Image(
          image: AssetImage("assets/images/tab_${buttonName}@2x.png"),
          color: _selected ? Theme.of(context).accentColor : Colors.black,
          width: 26.0,
          height: 26.0,
        ),
      ),
    );
  }
}
