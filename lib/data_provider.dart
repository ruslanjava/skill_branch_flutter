import 'dart:convert';

import 'models/auth/model.dart';
import 'models/photo.dart';
import 'package:http/http.dart' as http;

/*
 async {
  const url = "$baseUrl/api/v1/login";

  var response = await http.post(url, body: {
    'user': '$username',
    'password': '$pwd',
  });

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return Login.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
*/

class DataProvider {

  static const String _appId = "157965"; //not used, just for info
  static String authToken = ""; // "UmL3rmxWT8NtRFbxKE6CYIJktLR2rtuBEI4CfevUXxs";
  static const String _accessKey =
      'cvTw7V6jONGqOHhHwiF4HJl5Gpgxq0DYf2hJYiDM3Cs'; //app access key from console

  static const String _secretKey =
      'BOJo1xNTYmL-Z8LyBrlGfg1b9azUqQYh2jL9z4jWRc4'; //app secrey key from console

  static const String authUrl =
      'https://unsplash.com/oauth/authorize?client_id=$_accessKey&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=public+write_likes'; //authorize url from https://unsplash.com/oauth/applications/{your_app_id}

  static Future<Auth> doLogin({String oneTimeCode}) async {
    var response = await http.post('https://unsplash.com/oauth/token',
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            '{"client_id":"$_accessKey","client_secret":"$_secretKey","redirect_uri":"urn:ietf:wg:oauth:2.0:oob","code":"$oneTimeCode","grant_type":"authorization_code"}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Auth.fromJson(json.decode(response.body));
    }
    throw Exception('Error: ${response.reasonPhrase}');
  }

  static Future<Photos> getPhotos(int page, int perPage) async {
    var response = await http.get(
        'https://api.unsplash.com/photos?page=$page&per_page=$perPage',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photos.fromJson(json.decode(response.body));
    }
    throw Exception('Error: ${response.reasonPhrase}');
  }

  static Future<Photo> getPhoto(String photoId) async {
    var response = await http.get(
        'https://api.unsplash.com/photos$photoId',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photo.fromJson(json.decode(response.body));
    }
    throw Exception('Error: ${response.reasonPhrase}');
  }

  static Future<Photos> searchPhotos(String keyword, int page, int pageSize) async {
    var response = await http.get(
        'https://api.unsplash.com/search/photos?query=$keyword&page=$page&per_page=$pageSize',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photos.fromJson(json.decode(response.body));
    }
    throw Exception('Error: ${response.reasonPhrase}');
  }

  static Future<Photo> getRandomPhoto() async {
    var response = await http.get('https://api.unsplash.com/photos/random',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photo.fromJson(json.decode(response.body));
    }
    throw Exception('Error: ${response.reasonPhrase}');
  }

  static Future<bool> likePhoto(String photoId) async {
    var response = await http.post('https://api.unsplash.com/photos/$photoId/like',
        headers: { 'Authorization': 'Bearer $authToken'});

    print(response.body);
    print(response.reasonPhrase);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true; //returns 201 - Created
    }
    throw Exception('Error: ${response.reasonPhrase}');
  }

  static Future<bool> unlikePhoto(String photoId) async {
    var response = await http
        .delete('https://api.unsplash.com/photos/$photoId/like', headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true; //returns 201 - Created
    }
    throw Exception('Error: ${response.reasonPhrase}');
  }

}
