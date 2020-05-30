import 'dart:io';

import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args = settings.arguments as FullScreenImageArguments;
          final route = FullScreenImage(
            photo: args.photo,
            userName: args.photo,
            altDescription: args.altDescription,
            name: args.name,
            userPhoto: args.photo,
            heroTag: args.heroTag,
            key: args.key
          );

          if (Platform.isAndroid) {
            return MaterialPageRoute(builder: (context) => route, settings: args.routeSettings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(builder: (context) => route, settings: args.routeSettings);
          }

          return MaterialPageRoute(builder: (context) => route);
        }
      },
      home: Home(),
    );
  }
}

