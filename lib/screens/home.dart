import 'dart:async';

import 'package:FlutterGalleryApp/app.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feed_screen.dart';

class Home extends StatefulWidget {
  Home(this.onConnectivityChanged);

  final Stream<ConnectivityResult> onConnectivityChanged;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  StreamSubscription subscription;

  List<Widget> pages = [
    FeedScreen(key: PageStorageKey('FeedPage')),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    subscription =
        widget.onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
          ConnectivityOverlay().removeOverlay(context);
          break;
        case ConnectivityResult.mobile:
          ConnectivityOverlay().removeOverlay(context);
          break;
        case ConnectivityResult.none:
          Widget widget = new Positioned(
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
                      child: Text('No internet connection'),
                    )
                ),
              )
          );
          ConnectivityOverlay().showOverlay(context, widget);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
          itemCornerRadius: 8,
          curve: Curves.ease,
          onItemSelected: (int index) async {
            if (index == 1) {
              var value = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FeedScreen()));
              print(value);
            } else {
              setState(() {
                currentTab = index;
              });
            }
          },
          currentTab: currentTab,
          items: [
            BottomNavyBarItem(
              asset: AppIcons.home,
              title: Text('Feed'),
              activeColor: AppColors.dodgerBlue,
              inactiveColor: AppColors.manatee,
            ),
            BottomNavyBarItem(
                asset: AppIcons.home,
                title: Text('Search'),
                activeColor: AppColors.dodgerBlue,
                inactiveColor: AppColors.manatee),
            BottomNavyBarItem(
                asset: AppIcons.home,
                title: Text('User'),
                activeColor: AppColors.dodgerBlue,
                inactiveColor: AppColors.manatee),
          ]),
      body: pages[currentTab],
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key key,
    this.backgroundColor = Colors.white,
    this.showElevation = true,
    this.containerHeight = 56,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.items,
    this.onItemSelected,
    this.currentTab,
    this.animationDuration = const Duration(milliseconds: 270),
    this.itemCornerRadius = 24,
    this.curve,
  }) : super(key: key);

  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;
  final MainAxisAlignment mainAxisAlignment;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentTab;
  final Duration animationDuration;
  final double itemCornerRadius;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(color: Colors.black12, blurRadius: 2),
        ],
      ),
      child: SafeArea(
        child: Container(
            width: double.infinity,
            height: containerHeight,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: items.map((item) {
                var index = items.indexOf(item);

                return GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: _ItemWidget(
                    curve: curve,
                    animationDuration: animationDuration,
                    backgroundColor: backgroundColor,
                    isSelected: currentTab == index,
                    item: item,
                    itemCornerRadius: itemCornerRadius,
                  ),
                );
              }).toList(),
            )),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  _ItemWidget({
    @required this.isSelected,
    @required this.item,
    @required this.backgroundColor,
    @required this.animationDuration,
    this.curve = Curves.linear,
    @required this.itemCornerRadius,
  })  : assert(animationDuration != null, 'animationDuration is null'),
        assert(curve != null, 'curve is null'),
        assert(isSelected != null, 'isSelected is null'),
        assert(item != null, 'item is null'),
        assert(backgroundColor != null, 'backgroundColor is null'),
        assert(itemCornerRadius != null, 'itemCornerRadius is null');

  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double itemCornerRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isSelected
          ? 150
          : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      height: double.maxFinite,
      curve: curve,
      duration: animationDuration,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.circular(itemCornerRadius),
      ),
      child: Row(
        children: <Widget>[
          Icon(item.asset,
              size: 20,
              color: isSelected ? item.activeColor : item.inactiveColor),
          SizedBox(width: 4),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: DefaultTextStyle.merge(
                child: item.title,
                textAlign: item.textAlign,
                maxLines: 1,
                style: TextStyle(
                  color: isSelected ? item.activeColor : item.inactiveColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem(
      {this.asset,
      this.title,
      this.activeColor,
      this.inactiveColor,
      this.textAlign}) {
    assert(asset != null, 'Asset is null');
    assert(title != null, 'Title is null');
  }

  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;

  final TextAlign textAlign;
}
