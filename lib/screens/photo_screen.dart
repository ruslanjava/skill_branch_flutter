import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {

  FullScreenImage(
      {Key key,
      this.photo,
      this.altDescription,
      this.name,
      this.userName,
      this.userPhoto,
      this.heroTag})
      : super(key: key);

  final String photo;
  final String altDescription;
  final String userName;
  final String userPhoto;
  final String name;
  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }

}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {

  String photo;
  String name;
  String userName;
  String userPhoto;
  String altDescription;
  String heroTag;

  AnimationController controller;

  Animation<double> userOpacity;
  Animation<double> columnOpacity;

  @override
  void initState() {
    super.initState();
    photo = widget.photo != null ? widget.photo : kFlutterDash;
    name = widget.name != null ? widget.name : '';
    userName = widget.userName != null ? '@' + widget.userName : '';
    userPhoto = widget.userPhoto != null ? widget.userPhoto : 'https://skill-branch.ru/img/speakers/Adechenko.jpg';
    altDescription = widget.altDescription != null ? widget.altDescription : '';
    heroTag = widget.heroTag;

    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    userOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.5, curve: Curves.ease))
    );

    columnOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.5, 1.0, curve: Curves.ease))
    );

    controller.forward().orCancel;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Photo',
              style: AppStyles.h2Black.copyWith(fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
            onPressed: () => Navigator.of(context).pop(true),
          )),
      body: Column(children: <Widget>[
        _buildItem(),
      ]),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(tag: "$heroTag", child: Photo(photoLink: photo)),
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
                AnimatedBuilder(
                  animation: controller,
                  child: UserAvatar(userPhoto),
                  builder: (context, child) => FadeTransition(
                    opacity: userOpacity,
                    child: child
                  ),
                ),
                SizedBox(width: 6),
                AnimatedBuilder(
                  animation: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(name, style: AppStyles.h2Black),
                      Text(userName,
                          style: AppStyles.h5Black
                              .copyWith(color: AppColors.manatee)),
                    ],
                  ),
                  builder: (context, child) => FadeTransition(
                    opacity: columnOpacity,
                    child: child
                  )
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
