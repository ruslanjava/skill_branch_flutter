import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {

  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }

}

class _FeedState extends State<Feed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Column(children: <Widget>[
          _buildItem(),
          Divider(
            thickness: 2,
            color: AppColors.mercury
          ),
        ]);
      })
    );
  }

  Widget _buildItem() {
    return Column(
      children: <Widget>[
        Photo(),
        _buildPhotoMeta(),
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
            ],
          )
        ],
      ),
    );
  }

}