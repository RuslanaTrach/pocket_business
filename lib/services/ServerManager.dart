import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pocket_business/models/Warehouse.dart';

import '../models/Product.dart';
import '../models/User.dart';

class ServerManager {
  BuildContext context;
  ServerManager(this.context);

  String serverURL = "parseapi.back4app.com";

  final storage = new FlutterSecureStorage();


  late String token = storage.read(key: "access_token") as String;//

  Future<String> getUserId() async {
    String userId = await storage.read(key: "user_id") as String;
    return userId;
  }

  Future<String> getToken() async {
    // Read value
    String tok = await storage.read(key: "access_token") as String;
    return tok;
  }

  getProductsRequest(String objectid, void Function(List<Product> body) onSuccess, void Function(String errorCode) onError) async {
    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak',
      'where':'{\"ware\": \"{__type: Pointer, className: Wahehouse, objectId: $objectid}\"}'
    };
    var response = await http.get(Uri.parse('https://parseapi.back4app.com/classes/Product'), headers: headers);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(body['results'][0]);
    List<Product> data = [];
    List<Product> mylist = [];
    if (response.statusCode == 200) {
      for(var i in body['results']){
        mylist.add(Product.fromMap(i));
      }
      for(Product i in mylist){
        print(i.location!.objectId);
        print(objectid);
        if(i.location!.objectId! == objectid){
          data.add(i);
        }
      }
      print(response.body);

      // print("user info = ${response.body}");
      // var userInfo = body['data'][0];

      // ProfileSettings info = ProfileSettings.fromJson(userInfo);
      onSuccess(data);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getUserRequest(String email, void Function(User? body) onSuccess, void Function(String errorCode) onError) async {
    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak',
      //'where':'{\"email\": \"$email}\"}'
    };
    var response = await http.get(Uri.parse('https://parseapi.back4app.com/classes/Users'), headers: headers);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    //print(body['results'][0]);
    User? data;
    List<User> mylist = [];
    if (response.statusCode == 200) {
      for(var i in body['results']){
        mylist.add(User.fromMap(i));
      }
      for(User i in mylist){
        print(email);
        if(i.email! == email){
          data = i;
        }
      }
      print(data);
      print(response.body);

      // print("user info = ${response.body}");
      // var userInfo = body['data'][0];

      // ProfileSettings info = ProfileSettings.fromJson(userInfo);
      onSuccess(data);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getUsersRequest(void Function(List<User> body) onSuccess, void Function(String errorCode) onError) async {
    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak',
      //'where':'{\"email\": \"$email}\"}'
    };
    var response = await http.get(Uri.parse('https://parseapi.back4app.com/classes/Users'), headers: headers);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(body['results'][0]);
    User? data;
    List<User> mylist = [];
    if (response.statusCode == 200) {
      for(var i in body['results']){
        mylist.add(User.fromMap(i));
      }

      // print("user info = ${response.body}");
      // var userInfo = body['data'][0];

      // ProfileSettings info = ProfileSettings.fromJson(userInfo);
      onSuccess(mylist);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  getItemsRequest(void Function(List<Warehouse> body) onSuccess, void Function(String errorCode) onError) async {

    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak'
    };
    var response = await http.get(Uri.parse('https://parseapi.back4app.com/classes/Wahehouse'), headers: headers);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(body['results'][0]);
    List<Warehouse> mylist = [];
    if (response.statusCode == 200) {
      for(var i in body['results']){
        mylist.add(Warehouse.fromMap(i));
      }
      print(response.body);

     // print("user info = ${response.body}");
     // var userInfo = body['data'][0];

      // ProfileSettings info = ProfileSettings.fromJson(userInfo);
      onSuccess(mylist);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  postItemsRequest(String bodys,void Function(String body) onSuccess, void Function(String errorCode) onError) async {

    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak'
    };
    var response = await http.post(Uri.parse('https://parseapi.back4app.com/classes/Wahehouse'), headers: headers, body: bodys);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {

      print(response.body);

      // print("user info = ${response.body}");
      // var userInfo = body['data'][0];

      // ProfileSettings info = ProfileSettings.fromJson(userInfo);
      onSuccess(response.body);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  postItemRequest(String data,void Function(List<Product> body) onSuccess, void Function(String errorCode) onError) async {

    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak'
    };
    var response = await http.post(Uri.parse('https://parseapi.back4app.com/classes/Product'), headers: headers, body: data);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(body);
    List<Product> mylist = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      onSuccess(mylist);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  patchItemRequest(String id,String data,void Function(List<Product> body) onSuccess, void Function(String errorCode) onError) async {
    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak'
    };
    var response = await http.put(Uri.parse('https://parseapi.back4app.com/classes/Product/$id'), headers: headers, body: data);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(body);
    List<Product> mylist = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      onSuccess(mylist);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  patchUserRequest(String id, String data,void Function(User? body) onSuccess, void Function(String errorCode) onError) async {
    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak',
      //'where':'{\"email\": \"$email}\"}'
    };
    var response = await http.put(Uri.parse('https://parseapi.back4app.com/classes/Users/$id'), headers: headers, body: data);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(body['results'][0]);
    if (response.statusCode == 200 || response.statusCode == 201) {
      onSuccess(body);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  postUserRequest( String data,void Function(String? body) onSuccess, void Function(String errorCode) onError) async {
    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak',
      //'where':'{\"email\": \"$email}\"}'
    };
    var response = await http.post(Uri.parse('https://parseapi.back4app.com/classes/Users'), headers: headers, body: data);

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      onSuccess(body.toString());

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  deleteItemRequest(String data,void Function(List<Product> body) onSuccess, void Function(String errorCode) onError) async {
    var headers = {
      'Accept': 'application/json',
      'X-Parse-Application-Id': 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X',
      'X-Parse-REST-API-Key': 'EzhBnwHfNOKp16HGXK4PLuhNxZztvwrGxnpP12ak'
    };
    var response = await http.delete(Uri.parse('https://parseapi.back4app.com/classes/Product/$data'), headers: headers, );

    var body =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(body);
    List<Product> mylist = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      onSuccess(mylist);

    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}