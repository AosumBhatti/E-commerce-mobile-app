import 'package:flutter/material.dart';
import 'package:firstapp/widgets/customActionBar.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Center(
            child: Text('saved Tab'),
          ),
        ),
        CustomActionBar(
          title: "Saved Products",
          hasTitle: true,
          hasBackArrow: false,
        ),
      ],
    );
  }
}
