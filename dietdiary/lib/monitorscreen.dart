import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:toast/toast.dart';

import 'profile_screen.dart';

class MonitorScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(
          children: [
            TodayCounter(),
            TodayStats(),
            KcalGraph(),
          ],
          padding: EdgeInsets.all(20),
        ),
      ),
      appBar: AppBar(
        title: Text('Monitor Daily Calories'),
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
    );
  }
  
}

/// Calorie counter for the day
class TodayCounter extends StatelessWidget {
  Widget build(BuildContext context) {
    return FancyCard(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15),
      borderRadius: 15,
      gradient: Gradients.blush,
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
                "1423",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                "Suggestion cal",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "1232",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                "User's cal ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),SizedBox(width:30),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "191  ",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                "Cal left       ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

/// Food stats for the day
class TodayStats extends StatelessWidget {
  Widget build(BuildContext context) {
    return FancyCard(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 15),
      borderRadius: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Calories by food:")),
                Text(
                  "1232 cal",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(FontAwesomeIcons.seedling, color: Colors.green),
                  ),
                  Text("Vegetables"),
                  Expanded(child: Text("110 cal", textAlign: TextAlign.end)),
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
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child:
                        Icon(FontAwesomeIcons.appleAlt, color: Colors.red[400]),
                  ),
                  Text("Fruits"),
                  Expanded(child: Text("134 cal", textAlign: TextAlign.end)),
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
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(FontAwesomeIcons.breadSlice,
                        color: Colors.yellow[700]),
                  ),
                  Text("Starch"),
                  Expanded(child: Text("180 cal", textAlign: TextAlign.end)),
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
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(FontAwesomeIcons.drumstickBite,
                        color: Colors.orange[700]),
                  ),
                  Text("Meat"),
                  Expanded(child: Text("234 cal", textAlign: TextAlign.end)),
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
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(FontAwesomeIcons.candyCane, color: Colors.pink),
                  ),
                  Text("Other"),
                  Expanded(child: Text("574 cal", textAlign: TextAlign.end)),
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
          ),
          SizedBox(height: 15),
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
    );
  }
}

/// Calorie per day graph

class KcalGraph extends StatelessWidget {
  Widget build(BuildContext context) {
    return FancyCard(
      child: Column(
        children: <Widget>[
          Container(
              child: Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  labelText: 'Plese Enter The Food Name',
                  labelStyle: TextStyle(color: Colors.black),
                  icon: Icon(Icons.food_bank)),
            ),
          )),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            minWidth: 300,
            height: 50,
            child: Text('Add Food'),
            color: Colors.black87,
            textColor: Colors.white,
            elevation: 15,
            onPressed: () => {
              Toast.show(
                " Success Add",
                context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
              )
            },
          ),
        ],
      ),
      borderRadius: 10,
      padding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      boxShadow: BoxShadow(
        color: Colors.grey[400],
        blurRadius: 3.0,
        offset: Offset(1, 1),
      ),
    );
  }
  
}

class FancyCard extends StatelessWidget {
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

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          this.boxShadow,
        ],
        borderRadius: BorderRadius.circular(this.borderRadius),
        gradient: this.gradient,
        color: this.backgroundColor,
      ),
      margin: this.margin,
      child: Padding(
        padding: this.padding,
        child: this.child,
      ),
      height: height,
    );
  }
}
