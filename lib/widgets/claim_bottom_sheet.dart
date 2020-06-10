

import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {

  List<String> items = [ "adult", "harm", "bully", "spam", "copyright", "hate"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: new Text(items[index]),
        );
      },
    );
  }

}