

import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {

  final List<String> items = [ "adult", "harm", "bully", "spam", "copyright", "hate"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return new Material(
          color: AppColors.manatee,
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: new Text(
                items[index],
              ),
            ),
        );
      },
    );
  }

}