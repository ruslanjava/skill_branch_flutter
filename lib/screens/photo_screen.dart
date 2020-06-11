import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.photo,
    this.altDescription,
    this.userName,
    this.userPhoto,
    this.name,
    this.heroTag,
    this.key,
    this.routeSettings,
  });

  final String photo;
  final String altDescription;
  final String userName;
  final String userPhoto;
  final String name;
  final String heroTag;
  final Key key;
  final RouteSettings routeSettings;
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage({Key key,
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
    userPhoto = widget.userPhoto != null
        ? widget.userPhoto
        : 'https://skill-branch.ru/img/speakers/Adechenko.jpg';
    altDescription = widget.altDescription != null ? widget.altDescription : '';
    heroTag = widget.heroTag;

    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    userOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.5, curve: Curves.ease)));

    columnOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.5, 1.0, curve: Curves.ease)));

    _playAnimation();
  }

  Future<void> _playAnimation() async {
    try {
      await controller
          .forward()
          .orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(children: <Widget>[
        _buildItem(),
      ]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.grayChateau,
            ),
            onPressed: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  context: context,
                  builder: (context) => ClaimBottomSheet(),
              );
            }),
      ],
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.grayChateau,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text('Photo', style: Theme.of(context).textTheme.headline2),
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
              style: Theme.of(context).textTheme.headline3.copyWith(color: AppColors.grayChateau)),
        ),
        _buildPhotoMeta(),
        _buildActionButtons(),
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
                builder: (context, child) =>
                    FadeTransition(opacity: userOpacity, child: child),
              ),
              SizedBox(width: 6),
              AnimatedBuilder(
                  animation: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(name, style: Theme.of(context).textTheme.headline2),
                      Text(
                          userName,
                          style: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.manatee)
                      ),
                    ],
                  ),
                  builder: (context, child) =>
                      FadeTransition(opacity: columnOpacity, child: child))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LikeButton(likeCount: 10, isLiked: true),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context, builder: (context) => AlertDialog(
                  title: Text('Downloading photos'),
                  content: Text('Are you sure you want to upload a photo?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        GallerySaver.saveImage(photo).then((bool success) {
                          setState(() {
                            print('Image is saved');
                          });
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Download'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                ));
              },
              child: Container(
                alignment: Alignment.center,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.dodgerBlue,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.headline4.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildButton('Visit', () async {
              OverlayState overlayState = Overlay.of(context);

              OverlayEntry overlayEntry = OverlayEntry(builder: (BuildContext context) {
                return Positioned(
                  top: MediaQuery.of(context).viewInsets.top + 50,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                        decoration: BoxDecoration(color: AppColors.mercury, borderRadius: BorderRadius.circular(12)),
                        child: Text('SkillBranch'),
                      )
                    ),
                  )
                );
              });

              overlayState.insert(overlayEntry);
              await Future.delayed(Duration(seconds: 1));
              overlayEntry.remove();
            }),
          )
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline4.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

}
