import 'package:educational_app/screens/course_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  // Creating static data in lists

  List catNames = [
    "Category",
    'Class',
    'Free Courses',
    'BookStore',
    'Live Course',
    'LeaderBoard',
  ];

  List<Color> catColors = [
    Color(0xFFFFCF2F),
    Color(0xFF6FE08D),
    Color(0xFF61BDFD),
    Color(0xFFFC7F7F),
    Color(0xFFCB84FB),
    Color(0xFF78E667),
  ];

  List<Icon> catIcons = [
    Icon(Icons.category, color: Colors.white, size: 30),
    Icon(Icons.video_library, color: Colors.white, size: 30),
    Icon(Icons.assignment, color: Colors.white, size: 30),
    Icon(Icons.store, color: Colors.white, size: 30),
    Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
    Icon(Icons.emoji_events, color: Colors.white, size: 30),
  ];

  List imgList = [
    'Flutter',
    'React Native',
    'Python',
    'C#'
        'JavaScript'
        'Rust',
  ];

  get context => context;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xFF674AEF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Hi, Programmer",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here......",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: catNames.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: catColors[index],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: catIcons[index],
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          catNames[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Courses",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF674AEF),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                FutureBuilder<http.Response>(
                  future: getDataFromWebServer(),
                  builder: (BuildContext context,
                      AsyncSnapshot<http.Response> snapshot) {
                    if (snapshot.hasData) {
                      var sadData = jsonDecode(snapshot.data!.body);
                      return GridView.builder(
                        itemCount: sadData.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return pad(
                              pfp: sadData[index]['avatar'],
                              tits: sadData[index]["name"].toString(),
                              sasd: sadData[index]["count"].toString() +
                                  " Videos");
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              (MediaQuery.of(context).size.height - 50 - 25) /
                                  (4 * 240),
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                    // Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pad({required pfp, required tits, required sasd}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFF5F3FF),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return CourseScreen();
            },
          ));
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(
                pfp,
                width: 80,
                height: 80,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              tits,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              sasd,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<http.Response> getDataFromWebServer() async {
  print("data");
  var response = await http
      .get(Uri.parse('https://63fefbdd571200b7b7d341fc.mockapi.io/languages'));
  print(response.body.toString());
  return response;
}
