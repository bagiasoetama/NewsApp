import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Update extends StatefulWidget {
  var id;
  Update({Key key, this.id}) : super(key: key);
  @override
  _UpdateState createState() => new _UpdateState();
}

class _UpdateState extends State<Update> {
  var _isLoading = false;
  var data;

  var _name = "";
  var _email = "";
  var _password = "";
  var _gender = "";

  var _genderController = new TextEditingController();
  var _nameController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();


  Future<String> _ShowDialog(String msg) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Rewind and remember'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editData() async {
    var url =
        "https://flutterprojectcrudamelia.000webhostapp.com/edit_profile.php";

    var response = await http.post(url, body: {
      "id": widget.id,
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "gender": _genderController.text,

    });
    if (response.statusCode == 200) {
      _ShowDialog("Updated Successfully");
    } else {
      _ShowDialog("Updated Failer");
    }

    //onEditedAccount();
    //print(_adresseController.text);
  }

  _fetchData() async {
    final url =
        "https://flutterprojectcrudamelia.000webhostapp.com/consultProfile.php?ID=${widget.id}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videosMap = map["result"];

      setState(() {
        _isLoading = true;
        this.data = videosMap;
        _name = data[0]['name'];
        _email = data[0]['email'];
        _password = data[0]['password'];
        _gender = data[0]['gender'];
        print(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Update Profile"),
        ),
        body: new Center(
          child: data == null
              ? new CircularProgressIndicator()
              : new ListView(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    new Padding(
                      padding:
                      const EdgeInsets.only(top: 4.0, bottom: 25.0),
                      child: Center(
                        child: Text(
                          "Update your Profile",
                          textScaleFactor: 3.0,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: ("User Name : "),
                          filled: true,
                          hintText: _name),
                      controller: _nameController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: ("First Name : "),
                          filled: true,
                          hintText: _email),
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: ("Last Name : "),
                          filled: true,
                          hintText: _password),
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: ("Gender : "),
                          filled: true,
                          hintText: _gender),
                      controller: _genderController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    new ButtonTheme.bar(
                      // make buttons use the appropriate styles for cards
                      child: new ButtonBar(
                        children: <Widget>[
                          new RaisedButton(
                            child: const Text(
                              'Update',
                              textScaleFactor: 2.0,
                            ),
                            onPressed: () {
                              _editData();
                            },
                          ),
                          new RaisedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.backup),
                            label: Text("Back"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
