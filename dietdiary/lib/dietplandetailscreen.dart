import 'package:flutter/material.dart';

import 'dietplandetailfoodscreen.dart';
import 'profile_screen.dart';

class DietplandetailScreen extends StatefulWidget {
  @override
  _DietplandetailScreenState createState() => _DietplandetailScreenState();
}

class _DietplandetailScreenState extends State<DietplandetailScreen> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Current Diet Plan'),
          backgroundColor: Colors.black87,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen()));
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Column(
            children: [
              Card(
                child: InkWell(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      'Total Calories Per Day: 853 cal',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.today)
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Food: 7',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DietplanbreakfastScreen())),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/breakfast.png",
                              width: 150,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Food: 2',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Calories: 200 cal',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DietplanlunchScreen())),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/lunch.png",
                              width: 150,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Food: 3',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Calories: 300 cal',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DietplandinnerScreen())),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/dinner.png",
                              width: 150,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Food: 2',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Calories: 353 cal',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
