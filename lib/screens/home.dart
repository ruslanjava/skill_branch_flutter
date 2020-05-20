import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(backgroundColor: Colors.white, showElevation: true, containerHeight: 40,),
    );
  }
}

class BottomNavyBar extends StatelessWidget {

  BottomNavyBar({
    Key key,
    this.backgroundColor,
    this.showElevation,
    this.containerHeight
  }) : super(key: key);

  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (showElevation) const BoxShadow(color: Colors.black12, blurRadius: 2),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        ),
      ),
    );
  }

}
