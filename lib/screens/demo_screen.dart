import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context, {'name': 'kirill'});
              },
              child: Text('Click me'))
        ],
      )
    );
  }

}