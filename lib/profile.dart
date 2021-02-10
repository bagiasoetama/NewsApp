import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Profile extends StatefulWidget {
  var id;
  Profile({Key key, this.id}) : super(key: key);
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  List data;
  var _isLoading = false;
  String name = "name";
  String email = "email";
  String password = "passwordd";

  Future<String> get
}