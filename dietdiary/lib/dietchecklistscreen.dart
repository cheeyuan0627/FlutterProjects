import 'dart:convert';
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
  List foodslist;

  @override
  void initState() {
    super.initState();
    _loadbmi();
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ProfileScreen()));
                },
              ),
            ),
            body: Column(children: [
              bmiinfolist == null
                  ? Flexible(
                      child: Container(
                          child: Center(
                              child: Text(
                      'LOADING FOOD LIST ',
                      textAlign: TextAlign.center,
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
                              Column(
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
                                            double.parse(
                                                    bmiinfolist[index]['bmi'])
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
                                            'Status: ' +
                                                bmiinfolist[index]['type'],
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
                                    child: Center(),
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
                                  foodslist == null
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
                                                foodslist.length, (index) {
                                              return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 5),
                                                    SingleChildScrollView(
                                                        child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                      child: InkWell(
                                                        onLongPress: () =>
                                                            _adddialog(),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  foodslist[
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
                                                                          foodslist[index]
                                                                              [
                                                                              'quantity'],
                                                                    ),
                                                                  ],
                                                                ),
                                                                leading:
                                                                    ClipRRect(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                  imageUrl:
                                                                      "http://triold.com/dietdiary/images/foodpictures/${foodslist[index]['name']}.png",
                                                                  width: 60,
                                                                  height: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      new CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      new Icon(
                                                                    Icons
                                                                        .broken_image,
                                                                    size:
                                                                        screenWidth /
                                                                            2,
                                                                  ),
                                                                )),
                                                                trailing:
                                                                    SizedBox(
                                                                  width: 75,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              width: 15,
                                                                              height: 15,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: Colors.red,
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
                                    child: Center(),
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
                                  foodslist == null
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
                                                foodslist.length, (index) {
                                              return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 5),
                                                    SingleChildScrollView(
                                                        child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                      child: InkWell(
                                                        onLongPress: () =>
                                                            _adddialog(),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  foodslist[
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
                                                                          foodslist[index]
                                                                              [
                                                                              'quantity'],
                                                                    ),
                                                                  ],
                                                                ),
                                                                leading:
                                                                    ClipRRect(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                  imageUrl:
                                                                      "http://triold.com/dietdiary/images/foodpictures/${foodslist[index]['name']}.png",
                                                                  width: 60,
                                                                  height: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      new CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      new Icon(
                                                                    Icons
                                                                        .broken_image,
                                                                    size:
                                                                        screenWidth /
                                                                            2,
                                                                  ),
                                                                )),
                                                                trailing:
                                                                    SizedBox(
                                                                  width: 75,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              width: 15,
                                                                              height: 15,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: Colors.blue,
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
                                    child: Center(),
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
                                  foodslist == null
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
                                                foodslist.length, (index) {
                                              return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 5),
                                                    SingleChildScrollView(
                                                        child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                      child: InkWell(
                                                        onLongPress: () =>
                                                            _adddialog(),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  foodslist[
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
                                                                          foodslist[index]
                                                                              [
                                                                              'quantity'],
                                                                    ),
                                                                  ],
                                                                ),
                                                                leading:
                                                                    ClipRRect(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                  imageUrl:
                                                                      "http://triold.com/dietdiary/images/foodpictures/${foodslist[index]['name']}.png",
                                                                  width: 60,
                                                                  height: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      new CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      new Icon(
                                                                    Icons
                                                                        .broken_image,
                                                                    size:
                                                                        screenWidth /
                                                                            2,
                                                                  ),
                                                                )),
                                                                trailing:
                                                                    SizedBox(
                                                                  width: 75,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              width: 15,
                                                                              height: 15,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: Colors.yellow,
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
                  "Add Success",
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                );

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
          _loadfood();
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadfood() {
    http.post("http://triold.com/dietdiary/php/load_food_list.php", body: {
      "type": bmiinfolist[0]['type'],
      "cycle": "Breakfast"
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        foodslist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          foodslist = jsondata["foods"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
