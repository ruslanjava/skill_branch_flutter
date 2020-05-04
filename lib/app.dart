import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FullScreenImage(
        altDescription: 'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest',
        name: 'Dianne Miles',
        userName: '@Dianne Miles',
      ),
    );
  }
}

