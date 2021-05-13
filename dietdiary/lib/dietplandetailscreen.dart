import 'dart:convert';
import 'package:dietdiary/monitorscreen.dart';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'dietplandetailfoodscreen.dart';
import 'profile_screen.dart';
import 'package:http/http.dart' as http;

class DietplandetailScreen extends StatefulWidget {
  final User user;

  const DietplandetailScreen({Key key, this.user}) : super(key: key);
  @override
  _DietplandetailScreenState createState() => _DietplandetailScreenState();
}

class _DietplandetailScreenState extends State<DietplandetailScreen> {
  double screenHeight, screenWidth;
  List meallist;
  List mealbreakfastlist;
  List meallunchlist;
  List mealdinnerlist;
  double totalcal = 0.0, breaskfastcal = 0.0, lunchcal = 0.0, dinnercal = 0.0;
  int totalfood = 0, totalbreakfast = 0, totallunch = 0, totaldinner = 0;

  @override
  void initState() {
    super.initState();
    _loadmeal();
    _loadmealbreakfast();
    _loadmeallunch();
    _loadmealdinner();
  }

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProfileScreen(user: widget.user)));
            },
          ),
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.monitor),
                iconSize: 24,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (buildContextcontext) => MonitorScreen(
                                user: widget.user,
                              )));
                },
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
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
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      'Total Calories Per Day: ' +
                                          totalcal.toStringAsFixed(0) +
                                          ' Cal',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.today)
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      'Total Food: ' + totalfood.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                )
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
                              DietplanbreakfastScreen(user: widget.user))),
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
                                  height: 65,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Food: ' +
                                      totalbreakfast.toStringAsFixed(0),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Calories: ' +
                                      breaskfastcal.toStringAsFixed(0) +
                                      ' Cal',
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
                              DietplanlunchScreen(user: widget.user))),
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
                                  height: 65,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Food: ' +
                                      totallunch.toStringAsFixed(0),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Calories: ' +
                                      lunchcal.toStringAsFixed(0) +
                                      ' Cal',
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
                              DietplandinnerScreen(user: widget.user))),
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
                                  height: 65,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Food: ' +
                                      totaldinner.toStringAsFixed(0),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Calories: ' +
                                      dinnercal.toStringAsFixed(0) +
                                      ' Cal',
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

  void _loadmeal() {
    http.post("http://triold.com/dietdiary/php/load_mealsplan.php",
        body: {"email": widget.user.email}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        meallist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          meallist = jsondata["meal"];
          for (int i = 0; i < meallist.length; i++) {
            totalcal = totalcal + double.parse(meallist[i]['calorie']);
            totalfood = meallist.length;
          }
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadmealbreakfast() {
    http.post("http://triold.com/dietdiary/php/load_mealsplanbreakfast.php",
        body: {"email": widget.user.email, "cycle": "Breakfast"}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        mealbreakfastlist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          mealbreakfastlist = jsondata["mealbreakfast"];
          for (int i = 0; i < mealbreakfastlist.length; i++) {
            breaskfastcal =
                breaskfastcal + double.parse(mealbreakfastlist[i]['calorie']);
            totalbreakfast = mealbreakfastlist.length;
          }
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadmeallunch() {
    http.post("http://triold.com/dietdiary/php/load_mealsplanlunch.php",
        body: {"email": widget.user.email, "cycle": "Lunch"}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        meallunchlist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          meallunchlist = jsondata["meallunch"];
          for (int i = 0; i < meallunchlist.length; i++) {
            lunchcal = lunchcal + double.parse(meallunchlist[i]['calorie']);
            totallunch = meallunchlist.length;
          }
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadmealdinner() {
    http.post("http://triold.com/dietdiary/php/load_mealsplandinner.php",
        body: {"email": widget.user.email, "cycle": "Dinner"}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        mealdinnerlist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          mealdinnerlist = jsondata["mealdinner"];
          for (int i = 0; i < mealdinnerlist.length; i++) {
            dinnercal = lunchcal + double.parse(mealdinnerlist[i]['calorie']);
            totaldinner = mealdinnerlist.length;
          }
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
