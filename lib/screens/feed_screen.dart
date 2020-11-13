import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_provider.dart';
import 'photo_screen.dart';

class FeedScreen extends StatefulWidget {

  FeedScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedScreenState();
  }

}

class _FeedScreenState extends State<FeedScreen> {

  ScrollController _scrollController = ScrollController();
  int page = 1;
  bool isLoading = false;
  List<Photo> loadedPhotos = List<Photo>();


  Future<List<Photo>> _callAPI() async {
    isLoading = true;
    Photos photos = await DataProvider.getPhotos(page, 10);
    loadedPhotos.addAll(photos.photos);
    page++;
    isLoading = false;
    return loadedPhotos;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _callAPI().then((data){
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: loadedPhotos == null ? 0 : loadedPhotos.length,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: <Widget>[
                _buildItem(index),
                Divider(thickness: 2, color: AppColors.mercury),
              ]);
            }
        )
    );
  }

  _scrollListener() {
    if (_scrollController.position.extentAfter <= 0 && !isLoading) {
      _callAPI().then((data){
        setState(() {
        });
      });
    }
  }

  Widget _buildItem(int index) {
    Photo photo = loadedPhotos[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context,
                '/fullScreenImage',
                arguments: FullScreenImageArguments(
                  routeSettings: RouteSettings(
                    arguments: 'Some title',
                  ),
                  photo: photo.urls.regular,
                  altDescription: photo.altDescription,
                  userName: photo.user.username,
                  name: photo.user.name,
                  userPhoto: photo.user.profileImage.medium,
                  heroTag: photo.urls.regular,
              ),
            );
          },
          child: Hero(tag: photo.urls.regular, child: PhotoWidget(photoLink: photo.urls.full))
        ),
        _buildPhotoMeta(photo),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('This is Flutter dash. I love him :)',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline3.copyWith(color: AppColors.grayChateau)),
        ),
      ],
    );
  }

  Widget _buildPhotoMeta(Photo photo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(photo.user.profileImage.medium),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      photo.user.name,
                      style: Theme.of(context).textTheme.headline2
                  ),
                  Text(
                    photo.user.username,
                    style: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.manatee),
                  ),
                ],
              )
            ],
          ),
          LikeButton(likeCount: photo.likes, isLiked: photo.likedByUser),
        ],
      ),
    );
  }

}