import 'package:flutter/material.dart';
import 'package:newsapp/signup.dart';
import 'package:newsapp/home_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Color(0xFFFEF9EB),
      ),
      home: MyHomePage(),

    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State {
  bool visible = false ;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {

    setState(() {
      visible = true;
    });


    String email = emailController.text;
    String password = passwordController.text;


    var url = 'https://flutterprojectcrudamelia.000webhostapp.com/login_user.php';


    var data = {'email': email, 'password': password};


    var response = await http.post(url, body: json.encode(data));


    var message = jsonDecode(response.body);


    if (message == 'Login Matched') {

      setState(() {
        visible = false;
      });


      Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {

      setState(() {
        visible = false;
      });


      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

      Widget build(BuildContext context) {
        return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Text('Hello',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                        child: Text('There',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                        child: Text('.',
                            style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple)),
                      )
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors
                                      .purple))),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors
                                      .purple))),
                          obscureText: true,
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        RaisedButton(
                          onPressed: () {
                            userLogin();
                          },
                          color: Colors.purple,
                          textColor: Colors.white,
                          child: Text('Login'),
                        ),

                      ],
                    )),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to Account ?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.purple,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ));
      }
    }


