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
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                            child: Card(
                              color: Colors.blueGrey[50],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Loading Breaskfast Data ...',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                            child: Card(
                              color: Colors.blueGrey[50],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                        'Please Add Some Breakfast To Continue',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Flexible(
                      child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: Card(
                              color: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Long Press To Delete Food',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                              child: Column(
                                  children: List.generate(
                                      mealbreakfastlist.length, (index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                                            width: 140,
                                            height: 150,
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(
                                              Icons.broken_image,
                                              size: screenWidth / 2,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 30),
                                              Text(
                                                'Name: ' +
                                                    mealbreakfastlist[index]
                                                        ['name'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Calories per: ' +
                                                    mealbreakfastlist[index]
                                                        ['calorie'] +
                                                    ' Cal',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Quantity: ' +
                                                    mealbreakfastlist[index]
                                                        ['quantity'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            );
                          }))),
                        ],
                      ),
                    )),
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
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                            child: Card(
                              color: Colors.blueGrey[50],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Loading Lunch Data ...',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                            child: Card(
                              color: Colors.blueGrey[50],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                        'Please Add Some Lunch To Continue',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Flexible(
                      child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: Card(
                              color: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Long Press To Delete Food',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                              child: Column(
                                  children: List.generate(meallunchlist.length,
                                      (index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: Column(
                                children: [
                                  SingleChildScrollView(
                                      child: Card(
                                    child: InkWell(
                                      onLongPress: () {
                                        setState(() {
                                          foodname =
                                              meallunchlist[index]['name'];
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
                                            width: 140,
                                            height: 150,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(
                                              Icons.broken_image,
                                              size: screenWidth / 2,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 30),
                                              Text(
                                                'Name: ' +
                                                    meallunchlist[index]
                                                        ['name'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Calories per: ' +
                                                    meallunchlist[index]
                                                        ['calorie'] +
                                                    ' Cal',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Quantity: ' +
                                                    meallunchlist[index]
                                                        ['quantity'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                        ],
                      ),
                    )),
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
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                            child: Card(
                              color: Colors.blueGrey[50],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Loading Dinner Data ...',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                            child: Card(
                              color: Colors.blueGrey[50],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                        'Please Add Some Dinner To Continue',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Flexible(
                      child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: Card(
                              color: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Long Press To Delete Food',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                              child: Column(
                                  children: List.generate(mealdinnerlist.length,
                                      (index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: Column(
                                children: [
                                  SingleChildScrollView(
                                      child: Card(
                                    child: InkWell(
                                      onLongPress: () {
                                        setState(() {
                                          foodname =
                                              mealdinnerlist[index]['name'];
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
                                            width: 140,
                                            height: 150,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(
                                              Icons.broken_image,
                                              size: screenWidth / 2,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 30),
                                              Text(
                                                'Name: ' +
                                                    mealdinnerlist[index]
                                                        ['name'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Calories per: ' +
                                                    mealdinnerlist[index]
                                                        ['calorie'] +
                                                    ' Cal',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Quantity: ' +
                                                    mealdinnerlist[index]
                                                        ['quantity'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                        ],
                      ),
                    )),
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
