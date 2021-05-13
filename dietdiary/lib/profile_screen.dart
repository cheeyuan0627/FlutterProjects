import 'dart:convert';
import 'package:dietdiary/boucingbuttonscreen.dart';
import 'package:dietdiary/dietplandetailscreen.dart';
import 'package:dietdiary/loginscreen.dart';
import 'package:dietdiary/monitorscreen.dart';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'bmiscreen.dart';
import 'dietchecklistscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List bmiinfolist;
  List mealbreakfastlist;
  List meallunchlist;
  List mealdinnerlist;
  int i;
  int j;
  int k;
  double screenWidth;
  double screenHeight;

  @override
  void initState() {
    super.initState();
    _loadbmi();
    _loadmealbreakfast();
    _loadmeallunch();
    _loadmealdinner();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String formatter = DateFormat('yMEd').format(now);
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
                          icon: Icon(
                            FontAwesomeIcons.calculator,
                            color: Colors.black,
                            size: 20,
                          ),
                          tooltip: 'Calculate BMI',
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
                          icon: Icon(
                            FontAwesomeIcons.listAlt,
                            color: Colors.black,
                            size: 20,
                          ),
                          tooltip: 'Food List',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (buildContextcontext) =>
                                        DietchecklistScreen(
                                            user: widget.user)));
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
                          icon: Icon(
                            FontAwesomeIcons.starHalfAlt,
                            color: Colors.black,
                            size: 20,
                          ),
                          tooltip: 'Manage Food',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (buildContextcontext) =>
                                        DietplandetailScreen(
                                            user: widget.user)));
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
                          icon: Icon(
                            FontAwesomeIcons.chartLine,
                            color: Colors.black,
                            size: 20,
                          ),
                          tooltip: 'Cal Monitor',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (buildContextcontext) =>
                                        MonitorScreen(user: widget.user)));
                          },
                        ),
                      ])),
                ]))),
        body: Column(children: [
          bmiinfolist == null
              ? Flexible(child: BouncingButtonScreen(user: widget.user))
              : Flexible(
                  child: Stack(
                  children: List.generate(bmiinfolist.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            height: screenHeight * 0.35,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                bottom: const Radius.circular(40),
                              ),
                              child: Container(
                                color: Colors.blueGrey[50],
                                padding: const EdgeInsets.only(
                                    top: 0, left: 20, right: 0, bottom: 0),
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
                                          height: screenWidth * 0.35,
                                          width: screenWidth * 0.30,
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
                                              width: screenWidth * 0.35,
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
                                              width: screenWidth * 0.35,
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
                                                  icon: Icon(
                                                    FontAwesomeIcons.signOutAlt,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
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
                            top: screenHeight * 0.36,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: screenHeight * 0.50,
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
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 20,
                                              bottom: 10,
                                            ),
                                            child: Material(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              elevation: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: GestureDetector(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child: Image.asset(
                                                          "assets/images/breakfast.png",
                                                          width: 150,
                                                          height: 200,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  mealbreakfastlist == null
                                                      ? Flexible(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                          '    Loading Data ...',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ))))
                                                      : Flexible(
                                                          fit: FlexFit.tight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  'BREAKFAST',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .blueGrey,
                                                                  ),
                                                                ),
                                                                for (i = 0;
                                                                    i <
                                                                        mealbreakfastlist
                                                                            .length;
                                                                    i++)
                                                                  Text(
                                                                    (i + 1).toString() +
                                                                        '. ' +
                                                                        mealbreakfastlist[i]
                                                                            [
                                                                            'name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                SizedBox(
                                                                    height: 16),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 20,
                                              bottom: 10,
                                            ),
                                            child: Material(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              elevation: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: GestureDetector(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child: Image.asset(
                                                          "assets/images/lunch.png",
                                                          width: 150,
                                                          height: 200,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  meallunchlist == null
                                                      ? Flexible(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                          '    Loading Data ...',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ))))
                                                      : Flexible(
                                                          fit: FlexFit.tight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  'LUNCH',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .blueGrey,
                                                                  ),
                                                                ),
                                                                for (j = 0;
                                                                    j <
                                                                        meallunchlist
                                                                            .length;
                                                                    j++)
                                                                  Text(
                                                                    (j + 1).toString() +
                                                                        '. ' +
                                                                        meallunchlist[j]
                                                                            [
                                                                            'name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                SizedBox(
                                                                    height: 16),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 20,
                                              bottom: 10,
                                            ),
                                            child: Material(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              elevation: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: GestureDetector(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child: Image.asset(
                                                          "assets/images/dinner.png",
                                                          width: 150,
                                                          height: 200,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  mealdinnerlist == null
                                                      ? Flexible(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                          '    Loading Data ...',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ))))
                                                      : Flexible(
                                                          fit: FlexFit.tight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  'DINNER',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .blueGrey,
                                                                  ),
                                                                ),
                                                                for (k = 0;
                                                                    k <
                                                                        mealdinnerlist
                                                                            .length;
                                                                    k++)
                                                                  Text(
                                                                    (k + 1).toString() +
                                                                        '. ' +
                                                                        mealdinnerlist[k]
                                                                            [
                                                                            'name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                SizedBox(
                                                                    height: 16),
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
                  gravity: Toast.TOP,
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
                  gravity: Toast.TOP,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loadbmi() async {
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

  void _loadmealbreakfast() async {
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
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadmeallunch() async {
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
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadmealdinner() async {
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
