import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:/newsapp/detailspage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {

// Creating String Var to Hold sent Email.
  final String email;

// Receiving Email using Constructor.
  Home({Key key, @required this.email}) : super(key: key);

// User Logout Function.
  logout(BuildContext context){

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorLight: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
        home: Scaffold(
            body: HomeScreen()
        ),
    );
  }
}
class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
@override
  void initState(){
  super.initState();
  getdata();
}

ListData;
void getData() async{
  String url = 'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d15b394582754fe89139ec24e94a4de7';
  http.Response response = await http.get(url);
  if(response.statusCode == 200){
    var decodejson = jsonDecode(response.body);
    setState(() {
      data = decodedjson["articles"];
    });
  }else {
    print(response.statusCode);
  }
}
@override
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(10, 45.0, 0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.sort,
                  size: 30,
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'News Updates',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: .5,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Sports',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Fitness',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Technology',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Buisness',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Expanded(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      author: data[index]["author"],
                      content: data[index]["content"],
                      description: data[index]["description"],
                      publishdate: data[index]["publishedAt"],
                      title: data[index]["title"],
                      url: data[index]["url"],
                      urltoimage: data[index]["urlToImage"],
                    ),
                  ),
                );
              },
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                    child: Image.network(
                      data[index]["urlToImage"],
                      fit: BoxFit.cover,
                      height: 240,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 240.0, 0.0, 0.0),
                    child: Container(
                      height: 120,
                      width: 300,
                      child: Material(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(35.0),
                          bottomStart: Radius.circular(35.0),
                        ),
                        elevation: 20,
                        child: Center(
                          child: Text(
                            data[index]["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 10,
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Icons.home,
            semanticLabel: 'Home',
            size: 40,
          ),
          Icon(Icons.search),
          Icon(Icons.bookmark_border),
          CircleAvatar(
            backgroundColor: Colors.deepOrange,
            child: Text(
              'SB',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            //  image: Image.asset(''),
          ),
        ],
      )
    ],
  );
}
}
}