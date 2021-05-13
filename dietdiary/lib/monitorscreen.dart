import 'dart:convert';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:toast/toast.dart';
import 'profile_screen.dart';
import 'package:http/http.dart' as http;

class MonitorScreen extends StatefulWidget {
  final User user;

  const MonitorScreen({Key key, this.user}) : super(key: key);
  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  @override
  void initState() {
    super.initState();
    _loadmeal();
  }

  List<String> foodlist = [
    "Cereals",
    "Meat, Fish, Eggs",
    "Fruits",
    "Vegetables",
    "Milk & Substitutes",
  ];

  String selectedfood = "Cereals";

  List<String> quantitylist = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];

  String selectedquantity = "1";

  List meallist;
  List userdailydatalist;
  double usercal = 0.0;
  double totalsuggestioncal = 0.0;
  double calleft = 0.0;
  int j = 0;
  int k = 0;
  int i = 0;
  double screenWidth;
  double screenHeight;

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Daily Cal Monitor'),
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
      body: SingleChildScrollView(
        child: Column(children: [
          FancyCard(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            borderRadius: 15,
            gradient: Gradients.cosmicFusion,
            boxShadow: BoxShadow(
              color: Colors.blueGrey[50],
              blurRadius: 5.0,
              offset: Offset(1, 1),
            ),
            child: Row(children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      totalsuggestioncal.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Suggest's cal",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      usercal.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " User's cal ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      calleft.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Cal Left/Over",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          FancyCard(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            borderRadius: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "Calories By Food:",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Text(
                        usercal.toStringAsFixed(0) + ' Cal',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                for (j = 0; j < k; j++)
                  (Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(FontAwesomeIcons.circleNotch,
                                color: Colors.blueAccent),
                          ),
                          Text(userdailydatalist[j]['foodname'],
                              textAlign: TextAlign.start),
                          Expanded(
                              child: Text(
                                  userdailydatalist[j]['quantity'] +
                                      ' Qty * ' +
                                      userdailydatalist[j]['calorie'] +
                                      ' Cal ',
                                  textAlign: TextAlign.end)),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  )),
                Row(
                  children: [
                    Text(
                      'Press Here To Clear All Data',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.black,
                        size: 16,
                      ),
                      alignment: Alignment.center,
                      onPressed: () {
                        _deletedialog();
                      },
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
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
                    Icon(Icons.food_bank),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Food',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        alignment: Alignment.centerLeft,
                        height: 40,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedfood,
                            onChanged: (newValue) {
                              setState(() {
                                selectedfood = newValue;
                                print(selectedfood);
                              });
                            },
                            items: foodlist.map((selectedtype) {
                              return DropdownMenuItem(
                                child: new Text(selectedtype,
                                    style: TextStyle(color: Colors.black)),
                                value: selectedtype,
                              );
                            }).toList(),
                          ),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.format_list_numbered_rtl),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Quantity',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                        alignment: Alignment.centerLeft,
                        height: 40,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedquantity,
                            onChanged: (newValue) {
                              setState(() {
                                selectedquantity = newValue;
                                print(selectedquantity);
                              });
                            },
                            items: quantitylist.map((selectedquantity) {
                              return DropdownMenuItem(
                                child: new Text(selectedquantity,
                                    style: TextStyle(color: Colors.black)),
                                value: selectedquantity,
                              );
                            }).toList(),
                          ),
                        )),
                    SizedBox(
                      width: 62,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minWidth: 300,
                    height: 40,
                    child: Text('Add / Update Food'),
                    color: Colors.blueAccent[100],
                    textColor: Colors.white,
                    elevation: 15,
                    onPressed: () => {_savedialog()}),
              ],
            ),
            borderRadius: 10,
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            backgroundColor: Colors.white,
            boxShadow: BoxShadow(
              color: Colors.grey[400],
              blurRadius: 3.0,
              offset: Offset(1, 1),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Estimated Calories Based On Food Type!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _loadmeal() async {
    http.post("http://triold.com/dietdiary/php/load_mealsplan.php",
        body: {"email": widget.user.email}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        meallist = null;
        setState(() {
          print('failed');
          _loaduserdailydata();
        });
      } else {
        _loaduserdailydata();
        setState(() {
          var jsondata = json.decode(res.body);
          meallist = jsondata["meal"];
          for (int i = 0; i < meallist.length; i++) {
            totalsuggestioncal =
                totalsuggestioncal + double.parse(meallist[i]['calorie']);
          }
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loaduserdailydata() async {
    http.post("http://triold.com/dietdiary/php/load_userdailydata.php",
        body: {"email": widget.user.email}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        userdailydatalist = null;
        setState(() {
          print('failed');
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          userdailydatalist = jsondata["userdata"];
          k = userdailydatalist.length;
          for (i = 0; i < userdailydatalist.length; i++) {
            usercal = double.parse(userdailydatalist[i]['calorie']) *
                    double.parse(userdailydatalist[i]['quantity']) +
                usercal;
            calleft = totalsuggestioncal - usercal;
          }
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _savedialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Add / Update?",
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
                _saveuserdailydata();
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

  void _saveuserdailydata() async {
    http.post("http://triold.com/dietdiary/php/save_userdailydata.php", body: {
      "email": widget.user.email,
      "foodname": selectedfood,
      "quantity": selectedquantity,
    }).then((res) {
      if (res.body == "success") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MonitorScreen(user: widget.user)));
        Toast.show("Add / Update Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      } else {
        Toast.show("Process Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }
    }).catchError((err) {
      print(err);
    });
  }

  _deletedialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Clear All Data?",
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
                _deletedata();
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

  void _deletedata() async {
    http.post("http://triold.com/dietdiary/php/delete_userdailydata.php",
        body: {
          "email": widget.user.email,
        }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MonitorScreen(user: widget.user)));
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
