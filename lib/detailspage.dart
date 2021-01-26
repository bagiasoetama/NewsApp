import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget{
  final String url,
    urltoimage,
    tittle,
    content,
    publishdate,
    author,
    description;
  DetailsPage(
  {this.url,
  this.urltoimage,
  this.author,
  this.content,
  this.description,
  this.publishdate,
  this.tittle
  });
  @override
  _DetailsPageState createState() => _DetailsPageState();
  
}

class _DetailsPageState extends State<DetailsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 300,
            width: 400,
            child: Image.network(widget.urltoimage,
                fit: BoxFit.cover,
                height: 100,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0.0, 240, 0.0, 0.0),
              child: Container(
                height: double.infinity,
                width: 400,
                child: Material(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    topRight: Radius.circular(35.0),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          widget.tittle,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'Date ${widget.publishdate.substring(0,10)}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.content,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'URL:${widget.url}',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }
}