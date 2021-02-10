import 'package:flutter/material.dart';
import 'package:newsapp/updateprofile.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<String> getLogin(String id) async {
    var response = await http.get(
        Uri.encodeFull(
            "https://flutterprojectcrudamelia.000webhostapp.com/consultProfile.php?ID=" +
                id +
                ""),
        headers: {"Accept": "application/json"});

    setState(() {
      _isLoading = true;
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['result'];
      if (data != null) {
        name = data[0]['username'];
        email = data[0]['first_name'];
        password = data[0]['last_name'];
      }
    });
    print(data);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLogin(widget.id);
    });
  }

  _launchURL() async {
    const url = 'tel:27181132';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not make Call';
    }
  }

  @override
  Widget build(BuildContext context) {
    {
      return new Scaffold(
        appBar: AppBar(
          title: Text(" Menu"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.call),
                onPressed: () {
                  _launchURL();
                }),

            // action button
            new IconButton(
              icon: new Icon(Icons.map),
              onPressed: () {},
            ),
          ],
        ),
        body: !_isLoading
            ? new CircularProgressIndicator()
            : new Container(
          child: new Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Container(
                        width: 60.0,
                        height: 60.0,
                        child: new CircleAvatar(
                          minRadius: 50.0,
                          backgroundColor: Colors.blue.shade50,
                          child: new Text(name),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 20.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "User Name : ",
                              style: TextStyle(fontSize: 24.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              name,
                              style: TextStyle(fontSize: 20.0),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Email : ",
                              style: TextStyle(fontSize: 24.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              email,
                              style: TextStyle(fontSize: 20.0),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "First Name : ",
                              style: TextStyle(fontSize: 24.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              password,
                              style: TextStyle(fontSize: 20.0),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                  new ButtonTheme.bar(
                    // make buttons use the appropriate styles for cards
                    child: new ButtonBar(
                      children: <Widget>[
                        new FlatButton(
                          child: const Text('Update'),
                          onPressed: () {
                            var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new Update(
                                id: widget.id,
                              ),
                            );
                            Navigator.of(context).push(route);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
