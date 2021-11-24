import 'package:flutter/material.dart';
import 'package:firstapp/constant.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outline;
  final bool isLoading;
  CustomBtn({this.text, this.onPressed, this.outline, this.isLoading});
  @override
  Widget build(BuildContext context) {
    bool _outlinebtn = outline ?? false;
    bool _isLoading = isLoading ?? false;
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: _outlinebtn ? Colors.transparent : Colors.black,
              border: Border.all(
                color: _outlinebtn ? Colors.black : Colors.transparent,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(
                12.0,
              ),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            child: Stack(
              children: [
                Visibility(
                  visible: _isLoading ? false : true,
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: _outlinebtn ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _isLoading,
                  child: Center(
                    child: SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            )));
  }
}
