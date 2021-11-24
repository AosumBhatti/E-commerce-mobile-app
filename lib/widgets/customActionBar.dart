import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/constant.dart';
import 'package:firstapp/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final bool hasBackArrow;
  final bool hasTitle;
  final String title;
  final bool hasBackground;
  CustomActionBar(
      {this.hasBackArrow, this.hasTitle, this.title, this.hasBackground});
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? false;
    bool _hasBackground = hasBackground ?? true;
    int _totalItem = 0;
    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1))
              : null),
      padding: EdgeInsets.only(
        top: 82.0,
        right: 24.0,
        left: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image(
                  image: AssetImage("assets/images/back_arrow.png"),
                  height: 16.0,
                  width: 16.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action Bar',
              style: Constant.boldRegularHeadings,
            ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _totalItem != 0
                  ? Theme.of(context).accentColorBrightness
                  : Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: _firebaseServices
                  .getUserRef()
                  .doc(_firebaseServices.getUserId())
                  .collection('Cart')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  List _documents = snapshot.data.docs;
                  _totalItem = _documents.length;
                }
                return Text(
                  "$_totalItem" ?? 0,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
