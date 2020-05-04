import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {

  FullScreenImage({Key key, this.altDescription, this.name, this.userName})
      : super(key: key);

  final String altDescription;
  final String userName;
  final String name;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }

}

class _FullScreenImageState extends State<FullScreenImage> {

  String name;
  String userName;
  String altDescription;

  @override
  void initState() {
    super.initState();
    name = widget.name != null ? widget.name : '';
    userName = widget.userName != null ? '@' + widget.userName : '';
    altDescription = widget.altDescription != null ? widget.altDescription : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Photo',
          style: AppStyles.h2Black.copyWith(fontWeight: FontWeight.bold)
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
          onPressed: () => Navigator.of(context).pop(true),
        )
      ),
      body: Column(children: <Widget>[
        _buildItem(),
      ]),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Photo(photoLink: kFlutterDash),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(altDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.grayChateau)),
        ),
        _buildPhotoMeta(),
        _buildButtons(),
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name, style: AppStyles.h2Black),
                  Text(userName,
                      style:
                      AppStyles.h5Black.copyWith(color: AppColors.manatee)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        LikeButton(likeCount: 10, isLiked: true),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.dodgerBlue,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
              child: Text(
                'Save',
                style: AppStyles.h3.copyWith(color: AppColors.white),
              ),
            ),
          ),
          onTap: () {
            setState(() {});
          },
        ),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.dodgerBlue,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
              child: Text(
                'Visit',
                style: AppStyles.h3.copyWith(color: AppColors.white),
              ),
            ),
          ),
          onTap: () {
            setState(() {});
          },
        ),
      ],
    );
  }

}