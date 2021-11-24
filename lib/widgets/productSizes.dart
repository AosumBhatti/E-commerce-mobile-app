import 'package:flutter/material.dart';

class ProducSizes extends StatefulWidget {
  final List sizeList;
  final Function(String) onSelected;
  ProducSizes({this.sizeList, this.onSelected});
  @override
  _ProducSizesState createState() => _ProducSizesState();
}

class _ProducSizesState extends State<ProducSizes> {
  int _selectedSize = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
      child: Row(
        children: [
          for (var i = 0; i < widget.sizeList.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.onSelected("${widget.sizeList[i]}");
                  _selectedSize = i;
                });
              },
              child: Container(
                height: 40.0,
                width: 40.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: _selectedSize == i
                        ? Color(0xFFFF1E00)
                        : Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(3.0)),
                child: Center(
                  child: Text(
                    widget.sizeList[i],
                    style: TextStyle(
                        color: _selectedSize == i
                            ? Colors.white
                            : Color(0xFF696969),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
