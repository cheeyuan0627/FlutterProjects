import 'package:dietdiary/loginscreen.dart';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'bmiscreen.dart';
import 'package:toast/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BouncingButtonScreen extends StatefulWidget {
  final User user;

  const BouncingButtonScreen({Key key, this.user}) : super(key: key);
  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButtonScreen>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  double screenWidth;
  double screenHeight;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String formatter = DateFormat('yMEd').format(now);
    _scale = 1 - _controller.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome ",
        ),
        leading: IconButton(
          icon: Icon(Icons.home),
          tooltip: 'Home',
          onPressed: () {},
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Stack(
            children: [
              Positioned(
                top: 0,
                height: screenHeight * 0.33,
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
                              width: screenWidth * 0.35,
                              child: Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '0',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF200087),
                                        ),
                                      ),
                                      TextSpan(text: "\n"),
                                      TextSpan(
                                        text: "BMI",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF200087),
                                        ),
                                      ),
                                      TextSpan(text: "\n"),
                                      TextSpan(
                                        text: 'No Data',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _IngredientProgress(
                                  ingredient: "Height (cm) " + '0',
                                  progress: 0.5,
                                  progressColor: Colors.green,
                                  width: screenWidth * 0.35,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _IngredientProgress(
                                  ingredient: "Weight (kg) " + '0',
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
            ],
          )),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Card(
              color: Colors.blueGrey[50],
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Hi User',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Card(
              color: Colors.blueGrey[50],
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('New To Diet Diary?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 15),
            child: Card(
              color: Colors.blueGrey[50],
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Press Button Below to Get Started',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTapDown: _tapDown,
              onTapUp: _tapUp,
              child: Transform.scale(
                scale: _scale,
                child: _animatedButton(),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          )
        ],
      ),
    );
  }

  Widget _animatedButton() {
    return Container(
      height: 60,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey[50], Colors.grey[50]],
          )),
      child: Center(
        child: Text(
          'Get Started',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (buildContextcontext) => BMICalculatorScreen(
                  user: widget.user,
                )));
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
