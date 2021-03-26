import 'dart:convert';
import 'package:dietdiary/dietplandetailscreen.dart';
import 'package:dietdiary/loginscreen.dart';
import 'package:dietdiary/monitorscreen.dart';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'package:dietdiary/meal.dart';
import 'bmiscreen.dart';
import 'dietchecklistscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List bmiinfolist;

  @override
  void initState() {
    super.initState();
    _loadbmi();
  }

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String formatter = DateFormat('yMEd').format(now);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Stack(overflow: Overflow.visible, children: [
                        Container(
                          width: 50,
                          height: 50,
                        ),
                        IconButton(
                          icon: Icon(Icons.calculate),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (buildContextcontext) =>
                                        BMICalculatorScreen(
                                          user: widget.user,
                                        )));
                          },
                        ),
                      ])),
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Stack(overflow: Overflow.visible, children: [
                        Container(
                          width: 50,
                          height: 50,
                        ),
                        IconButton(
                          icon: Icon(Icons.list),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (buildContextcontext) =>
                                        DietchecklistScreen(
                                          user: widget.user
                                        )));
                          },
                        ),
                      ])),
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Stack(overflow: Overflow.visible, children: [
                        Container(
                          width: 50,
                          height: 50,
                        ),
                        IconButton(
                          icon: Icon(Icons.view_agenda),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (buildContextcontext) =>
                                        DietplandetailScreen()));
                          },
                        ),
                      ])),
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Stack(overflow: Overflow.visible, children: [
                        Container(
                          width: 50,
                          height: 50,
                        ),
                        IconButton(
                          icon: Icon(Icons.monitor),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (buildContextcontext) =>
                                        MonitorScreen()));
                          },
                        ),
                      ])),
                ]))),
        body: Column(children: [
          bmiinfolist == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  'Halo  '+'  PLEASE PRESS THIS BUTTON TO CONTINUE CALCULATE BMI ', textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))))
              : Flexible(
                  child: Stack(
                  children: List.generate(bmiinfolist.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            height: height * 0.38,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                bottom: const Radius.circular(40),
                              ),
                              child: Container(
                                color: Colors.blueGrey[50],
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20, bottom: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      subtitle: Text(
                                        "Hi  " + widget.user.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: width * 0.35,
                                          width: width * 0.35,
                                          child: Center(
                                            child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: double.parse(
                                                            bmiinfolist[index]
                                                                ['bmi'])
                                                        .toStringAsFixed(0),
                                                    style: TextStyle(
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                          0xFF200087),
                                                    ),
                                                  ),
                                                  TextSpan(text: "\n"),
                                                  TextSpan(
                                                    text: "BMI",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xFF200087),
                                                    ),
                                                  ),
                                                  TextSpan(text: "\n"),
                                                  TextSpan(
                                                    text: bmiinfolist[index]
                                                        ['type'],
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            _IngredientProgress(
                                              ingredient: "Height (cm) " +
                                                  double.parse(
                                                          bmiinfolist[index]
                                                              ['height'])
                                                      .toStringAsFixed(0),
                                              progress: 0.5,
                                              progressColor: Colors.green,
                                              width: width * 0.35,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            _IngredientProgress(
                                              ingredient: "Weight (kg) " +
                                                  double.parse(
                                                          bmiinfolist[index]
                                                              ['weight'])
                                                      .toStringAsFixed(0),
                                              progress: 0.5,
                                              progressColor: Colors.red,
                                              width: width * 0.35,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  formatter,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.logout),
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  onPressed: () => _logout(),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.38,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: height * 0.50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 20,
                                      left: 32,
                                      right: 16,
                                    ),
                                    child: Text(
                                      "CURRENT DIET PLAN",
                                      style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 32,
                                          ),
                                          for (int i = 0; i < meals.length; i++)
                                            _MealCard(
                                              meal: meals[i],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                )),
        ]));
  }

  _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Logout?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are your sure? ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Toast.show(
                  "Logout Success",
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (buildContextcontext) => LoginScreen()));
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Toast.show(
                  "Cancel Process",
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loadbmi() {
    http.post("http://triold.com/dietdiary/php/load_bmi_info.php", body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bmiinfolist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          bmiinfolist = jsondata["infobmi"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress(
      {Key key, this.ingredient, this.progress, this.progressColor, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 10,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;

  const _MealCard({Key key, @required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                    meal.imagePath,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      meal.mealTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      "1. " + meal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "2. " + meal.kiloCaloriesBurnt,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
