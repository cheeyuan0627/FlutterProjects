import 'dart:convert';
import 'package:dietdiary/dietplandetailscreen.dart';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class DietplanbreakfastScreen extends StatefulWidget {
  final User user;

  const DietplanbreakfastScreen({Key key, this.user}) : super(key: key);

  @override
  _DietplandetailbreakfastScreenState createState() =>
      _DietplandetailbreakfastScreenState();
}

class _DietplandetailbreakfastScreenState
    extends State<DietplanbreakfastScreen> {
  double screenHeight, screenWidth;
  List mealbreakfastlist;
  String foodname;

  @override
  void initState() {
    super.initState();
    _loadmealbreakfast();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Breakfast Detail'),
          backgroundColor: Colors.black87,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_return),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DietplandetailScreen(user: widget.user)));
            },
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              mealbreakfastlist == null
                  ? Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FancyCard(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.19,
                                    ),
                                    Text(
                                      'Loading Breakfast Data..',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            borderRadius: 10,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            backgroundColor: Colors.blueGrey[50],
                            boxShadow: BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 3.0,
                              offset: Offset(1, 1),
                            ),
                          ),
                          FancyCard(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Text(
                                      'Please Make Sure U Add Breakfast To Continue',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            borderRadius: 10,
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            backgroundColor: Colors.blueGrey[50],
                            boxShadow: BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 3.0,
                              offset: Offset(1, 1),
                            ),
                          )
                        ],
                      ),
                    )
                  : Flexible(
                      child: SingleChildScrollView(
                          child: Column(
                              children: List.generate(mealbreakfastlist.length,
                                  (index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                  child: Card(
                                child: InkWell(
                                  onLongPress: () {
                                    setState(() {
                                      foodname =
                                          mealbreakfastlist[index]['name'];
                                    });
                                    _deletedialog();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "http://triold.com/dietdiary/images/foodpictures/${mealbreakfastlist[index]['name']}.png",
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(
                                          Icons.broken_image,
                                          size: screenWidth / 2,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 30),
                                          Text(
                                            'Food Name: ' +
                                                mealbreakfastlist[index]
                                                    ['name'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Calories per: ' +
                                                mealbreakfastlist[index]
                                                    ['calorie'] +
                                                ' Cal',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Quantity: ' +
                                                mealbreakfastlist[index]
                                                    ['quantity'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        );
                      }))),
                    ),
            ],
          ),
        ]),
      ),
    );
  }

  _deletedialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Delete This Food?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are Your Sure? ",
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
                _deletebreakfast();
                Navigator.of(context).pop();
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
                  "Process Cancel",
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

  void _deletebreakfast() async {
    http.post("http://triold.com/dietdiary/php/delete_mealsplan.php", body: {
      "email": widget.user.email,
      "name": foodname,
      "cycle": mealbreakfastlist[0]['cycle'],
    }).then((res) {
      print(res.body);
      print(foodname);
      if (res.body == "success") {
        _loadmealbreakfast();
        Toast.show(
          "Process Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      } else {
        Toast.show(
          "Process Failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
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
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}

class DietplanlunchScreen extends StatefulWidget {
  final User user;

  const DietplanlunchScreen({Key key, this.user}) : super(key: key);

  @override
  _DietplandetaillunchScreenState createState() =>
      _DietplandetaillunchScreenState();
}

class _DietplandetaillunchScreenState extends State<DietplanlunchScreen> {
  double screenHeight, screenWidth;
  List meallunchlist;
  String foodname;

  @override
  void initState() {
    super.initState();
    _loadmeallunch();
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lunch Detail'),
          backgroundColor: Colors.black87,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_return),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DietplandetailScreen(user: widget.user)));
            },
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              meallunchlist == null
                  ? Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FancyCard(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.21,
                                    ),
                                    Text(
                                      'Loading Lunch Data..',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            borderRadius: 10,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            backgroundColor: Colors.blueGrey[50],
                            boxShadow: BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 3.0,
                              offset: Offset(1, 1),
                            ),
                          ),
                          FancyCard(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    Text(
                                      'Please Make Sure U Add Lunch To Continue',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            borderRadius: 10,
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            backgroundColor: Colors.blueGrey[50],
                            boxShadow: BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 3.0,
                              offset: Offset(1, 1),
                            ),
                          )
                        ],
                      ),
                    )
                  : Flexible(
                      child: SingleChildScrollView(
                          child: Column(
                              children:
                                  List.generate(meallunchlist.length, (index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                  child: Card(
                                child: InkWell(
                                  onLongPress: () {
                                    setState(() {
                                      foodname = meallunchlist[index]['name'];
                                    });
                                    _deletedialog();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "http://triold.com/dietdiary/images/foodpictures/${meallunchlist[index]['name']}.png",
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(
                                          Icons.broken_image,
                                          size: screenWidth / 2,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 30),
                                          Text(
                                            'Food Name: ' +
                                                meallunchlist[index]['name'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Calories per: ' +
                                                meallunchlist[index]
                                                    ['calorie'] +
                                                ' Cal',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Quantity: ' +
                                                meallunchlist[index]
                                                    ['quantity'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        );
                      }))),
                    ),
            ],
          ),
        ]),
      ),
    );
  }

  _deletedialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Delete This Food?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are Your Sure? ",
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
                _deletelunch();
                Navigator.of(context).pop();
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
                  "Process Cancel",
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

  void _deletelunch() async {
    http.post("http://triold.com/dietdiary/php/delete_mealsplan.php", body: {
      "email": widget.user.email,
      "name": foodname,
      "cycle": meallunchlist[0]['cycle'],
    }).then((res) {
      print(res.body);
      print(foodname);
      if (res.body == "success") {
        _loadmeallunch();
        Toast.show(
          "Process Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      } else {
        Toast.show(
          "Process Failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
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
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}

class DietplandinnerScreen extends StatefulWidget {
  final User user;

  const DietplandinnerScreen({Key key, this.user}) : super(key: key);

  @override
  _DietplandetaildinnerScreenState createState() =>
      _DietplandetaildinnerScreenState();
}

class _DietplandetaildinnerScreenState extends State<DietplandinnerScreen> {
  double screenHeight, screenWidth;
  List mealdinnerlist;
  String foodname;

  @override
  void initState() {
    super.initState();
    _loadmealdinner();
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dinner Detail'),
          backgroundColor: Colors.black87,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_return),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DietplandetailScreen(user: widget.user)));
            },
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              mealdinnerlist == null
                  ? Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FancyCard(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.21,
                                    ),
                                    Text(
                                      'Loading Dinner Data..',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            borderRadius: 10,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            backgroundColor: Colors.blueGrey[50],
                            boxShadow: BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 3.0,
                              offset: Offset(1, 1),
                            ),
                          ),
                          FancyCard(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    Text(
                                      'Please Make Sure U Add Dinner To Continue',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            borderRadius: 10,
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            backgroundColor: Colors.blueGrey[50],
                            boxShadow: BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 3.0,
                              offset: Offset(1, 1),
                            ),
                          )
                        ],
                      ),
                    )
                  : Flexible(
                      child: SingleChildScrollView(
                          child: Column(
                              children:
                                  List.generate(mealdinnerlist.length, (index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                  child: Card(
                                child: InkWell(
                                  onLongPress: () {
                                    setState(() {
                                      foodname = mealdinnerlist[index]['name'];
                                    });
                                    _deletedialog();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "http://triold.com/dietdiary/images/foodpictures/${mealdinnerlist[index]['name']}.png",
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(
                                          Icons.broken_image,
                                          size: screenWidth / 2,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 30),
                                          Text(
                                            'Food Name: ' +
                                                mealdinnerlist[index]['name'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Calories per: ' +
                                                mealdinnerlist[index]
                                                    ['calorie'] +
                                                ' Cal',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Quantity: ' +
                                                mealdinnerlist[index]
                                                    ['quantity'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        );
                      }))),
                    ),
            ],
          ),
        ]),
      ),
    );
  }

  _deletedialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Delete This Food?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are Your Sure? ",
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
                _deletedinner();
                Navigator.of(context).pop();
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
                  "Process Cancel",
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

  void _deletedinner() async {
    http.post("http://triold.com/dietdiary/php/delete_mealsplan.php", body: {
      "email": widget.user.email,
      "name": foodname,
      "cycle": mealdinnerlist[0]['cycle'],
    }).then((res) {
      print(res.body);
      print(foodname);
      if (res.body == "success") {
        _loadmealdinner();
        Toast.show(
          "Process Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      } else {
        Toast.show(
          "Process Failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
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
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}

class FancyCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;
  final Color backgroundColor;
  final Gradient gradient;
  final BoxShadow boxShadow;
  final double height;

  FancyCard({
    @required this.child,
    @required this.padding,
    @required this.borderRadius,
    this.boxShadow,
    this.backgroundColor,
    this.gradient,
    this.margin,
    this.height,
  });

  @override
  _FancyCardState createState() => _FancyCardState();
}

class _FancyCardState extends State<FancyCard> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          this.widget.boxShadow,
        ],
        borderRadius: BorderRadius.circular(this.widget.borderRadius),
        gradient: this.widget.gradient,
        color: this.widget.backgroundColor,
      ),
      margin: this.widget.margin,
      child: Padding(
        padding: this.widget.padding,
        child: this.widget.child,
      ),
      height: widget.height,
    );
  }
}
