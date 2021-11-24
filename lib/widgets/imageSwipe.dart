import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imagesList;
  ImageSwipe({this.imagesList});
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _pageNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _pageNumber = num;
              });
            },
            children: [
              for (var i = 0; i < widget.imagesList.length; i++)
                Container(
                  child: Image.network(
                    widget.imagesList[i],
                    fit: BoxFit.fill,
                  ),
                )
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imagesList.length; i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCubic,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: _pageNumber == i ? 35.0 : 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12.0)),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  void newMethod(int _pageNumber) => print(_pageNumber);
}
