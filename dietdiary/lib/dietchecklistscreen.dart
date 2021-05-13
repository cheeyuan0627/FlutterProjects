import 'dart:convert';
import 'package:dietdiary/dietplandetailscreen.dart';
import 'package:dietdiary/profile_screen.dart';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class DietchecklistScreen extends StatefulWidget {
  final User user;

  const DietchecklistScreen({Key key, this.user}) : super(key: key);
  @override
  _DietchecklistScreenState createState() => _DietchecklistScreenState();
}

class _DietchecklistScreenState extends State<DietchecklistScreen> {
  double screenHeight, screenWidth;
  List bmiinfolist;
  List breakfastlist;
  List lunchlist;
  List dinnerlist;
  String foodname, foodcycle;

  @override
  void initState() {
    super.initState();
    _loadbmi();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Diet Food List'),
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
            ),
            body: Column(children: [
              bmiinfolist == null
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
                                      width: screenWidth * 0.23,
                                    ),
                                    Text(
                                      'Loading Food Data..',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
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
                                      'Please Make Sure U Calculate BMI To Continue',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
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
                      child: Stack(
                      children: List.generate(bmiinfolist.length, (index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.update,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'BMI: ' +
                                        double.parse(bmiinfolist[index]['bmi'])
                                            .toStringAsFixed(0),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.face, size: 18),
                                      SizedBox(width: 5),
                                      Text(
                                        'Status: ' + bmiinfolist[index]['type'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 30,
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "BREASKFAST",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.breakfast_dining,
                                    size: 18,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              breakfastlist == null
                                  ? Flexible(
                                      child: Container(
                                          child: Center(
                                              child: Text(
                                      'LOADING BREAKFAST',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ))))
                                  : Flexible(
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: List.generate(
                                            breakfastlist.length, (index) {
                                          return Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Column(
                                              children: [
                                                SingleChildScrollView(
                                                    child: Card(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onLongPress: () {
                                                      setState(() {
                                                        foodname =
                                                            breakfastlist[index]
                                                                ['name'];
                                                        foodcycle =
                                                            breakfastlist[index]
                                                                ['cycle'];
                                                      });
                                                      _adddialog();
                                                    },
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            title: Text(
                                                              breakfastlist[
                                                                      index]
                                                                  ['name'],
                                                            ),
                                                            subtitle: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Quantity: ' +
                                                                      breakfastlist[
                                                                              index]
                                                                          [
                                                                          'quantity'],
                                                                ),
                                                              ],
                                                            ),
                                                            leading: ClipRRect(
                                                                child:
                                                                    CachedNetworkImage(
                                                              imageUrl:
                                                                  "http://triold.com/dietdiary/images/foodpictures/${breakfastlist[index]['name']}.png",
                                                              width: 60,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new CircularProgressIndicator(),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      new Icon(
                                                                Icons
                                                                    .broken_image,
                                                                size:
                                                                    screenWidth /
                                                                        2,
                                                              ),
                                                            )),
                                                            trailing: SizedBox(
                                                              width: 75,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          width:
                                                                              15,
                                                                          height:
                                                                              15,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          "PREFER",
                                                                        ),
                                                                      ],
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
                                                )),
                                              ],
                                            ),
                                          );
                                        }),
                                      )),
                                    ),
                              Container(
                                width: 30,
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "LUNCH",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.breakfast_dining,
                                    size: 18,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              lunchlist == null
                                  ? Flexible(
                                      child: Container(
                                          child: Center(
                                              child: Text(
                                      'LOADING LUNCH',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ))))
                                  : Flexible(
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: List.generate(
                                            lunchlist.length, (index) {
                                          return Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5),
                                                SingleChildScrollView(
                                                    child: Card(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onLongPress: () {
                                                      setState(() {
                                                        foodname =
                                                            lunchlist[index]
                                                                ['name'];
                                                        foodcycle =
                                                            lunchlist[index]
                                                                ['cycle'];
                                                      });
                                                      _adddialog();
                                                    },
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            title: Text(
                                                              lunchlist[index]
                                                                  ['name'],
                                                            ),
                                                            subtitle: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Quantity: ' +
                                                                      lunchlist[
                                                                              index]
                                                                          [
                                                                          'quantity'],
                                                                ),
                                                              ],
                                                            ),
                                                            leading: ClipRRect(
                                                                child:
                                                                    CachedNetworkImage(
                                                              imageUrl:
                                                                  "http://triold.com/dietdiary/images/foodpictures/${lunchlist[index]['name']}.png",
                                                              width: 60,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new CircularProgressIndicator(),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      new Icon(
                                                                Icons
                                                                    .broken_image,
                                                                size:
                                                                    screenWidth /
                                                                        2,
                                                              ),
                                                            )),
                                                            trailing: SizedBox(
                                                              width: 75,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          width:
                                                                              15,
                                                                          height:
                                                                              15,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Colors.blue,
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          "PREFER",
                                                                        ),
                                                                      ],
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
                                                )),
                                              ],
                                            ),
                                          );
                                        }),
                                      )),
                                    ),
                              Container(
                                width: 30,
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "DINNER",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.breakfast_dining,
                                    size: 18,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              dinnerlist == null
                                  ? Flexible(
                                      child: Container(
                                          child: Center(
                                              child: Text(
                                      'LOADING DINNER',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ))))
                                  : Flexible(
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: List.generate(
                                            dinnerlist.length, (index) {
                                          return Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5),
                                                SingleChildScrollView(
                                                    child: Card(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onLongPress: () {
                                                      setState(() {
                                                        foodname =
                                                            dinnerlist[index]
                                                                ['name'];
                                                        foodcycle =
                                                            dinnerlist[index]
                                                                ['cycle'];
                                                      });
                                                      _adddialog();
                                                    },
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            title: Text(
                                                              dinnerlist[index]
                                                                  ['name'],
                                                            ),
                                                            subtitle: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Quantity: ' +
                                                                      dinnerlist[
                                                                              index]
                                                                          [
                                                                          'quantity'],
                                                                ),
                                                              ],
                                                            ),
                                                            leading: ClipRRect(
                                                                child:
                                                                    CachedNetworkImage(
                                                              imageUrl:
                                                                  "http://triold.com/dietdiary/images/foodpictures/${dinnerlist[index]['name']}.png",
                                                              width: 60,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new CircularProgressIndicator(),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      new Icon(
                                                                Icons
                                                                    .broken_image,
                                                                size:
                                                                    screenWidth /
                                                                        2,
                                                              ),
                                                            )),
                                                            trailing: SizedBox(
                                                              width: 75,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          width:
                                                                              15,
                                                                          height:
                                                                              15,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Colors.yellow,
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          "PREFER",
                                                                        ),
                                                                      ],
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
                                                )),
                                              ],
                                            ),
                                          );
                                        }),
                                      )),
                                    ),
                            ],
                          ),
                        );
                      }),
                    )),
            ])));
  }

  _adddialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Add This Food?",
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
                _insertmealsplan();
                Navigator.of(context).pop();
                _navigatedialog();
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

  _navigatedialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Done?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Continue To Manage Diet Plan ",
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DietplandetailScreen(
                              user: widget.user,
                            )));
              },
            ),
            new FlatButton(
              child: new Text(
                "Add More Food",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
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
          _loadbreakfast();
          _loadlunch();
          _loaddinner();
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadbreakfast() {
    http.post("http://triold.com/dietdiary/php/load_breakfast.php", body: {
      "type": bmiinfolist[0]['type'],
      "cycle": "Breakfast"
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        breakfastlist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          breakfastlist = jsondata["breakfast"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadlunch() {
    http.post("http://triold.com/dietdiary/php/load_lunch.php",
        body: {"type": bmiinfolist[0]['type'], "cycle": "Lunch"}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        lunchlist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          lunchlist = jsondata["lunch"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loaddinner() {
    http.post("http://triold.com/dietdiary/php/load_dinner.php",
        body: {"type": bmiinfolist[0]['type'], "cycle": "Dinner"}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        dinnerlist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          dinnerlist = jsondata["dinner"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _insertmealsplan() {
    http.post("http://triold.com/dietdiary/php/insertmealsplan.php", body: {
      "email": widget.user.email,
      "name": foodname,
      "cycle": foodcycle,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Add/Update Success",
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
