import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _heightcontroller = TextEditingController();
  final TextEditingController _weightcontroller =
      TextEditingController(); //for user input

  double boer = 0.0,
      james = 0.0,
      hume = 0.0,
      peters = 0.0,
      bodyfat1 = 0.0,
      bodyfat2 = 0.0,
      bodyfat3 = 0.0,
      bodyfat4 = 0.0,
      weight = 0.0,
      height = 0.0;

  String _radioValue, _radioAge; //for radio value
  String choice,
      choice1,
      choice2,
      male,
      female,
      ageoptionyes,
      ageoptionno,
      ageoption,
      yes,
      no,
      boerformat,
      jamesformat,
      humeformat,
      petersformat,
      bodyfat1format,
      bodyfat2format,
      bodyfat3format,
      bodyfat4format;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lean Body Mass (Metric Unit) ',
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: Text(
              'Lean Body Mass (Metric Unit)',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/calculator.jpg',
                    scale: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Gender",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Radio(
                        value: 'male',
                        groupValue: _radioValue,
                        onChanged: radioButtonChanges,
                      ),
                      Text(
                        "Male",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: 'female',
                        groupValue: _radioValue,
                        onChanged: radioButtonChanges,
                      ),
                      Text(
                        "Female",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Are You 14 Or Younger?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Radio(
                        value: 'yes',
                        groupValue: _radioAge,
                        onChanged: radioButtonChanges2,
                      ),
                      Text(
                        "Yes",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: 'no',
                        groupValue: _radioAge,
                        onChanged: radioButtonChanges2,
                      ),
                      Text(
                        "No",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    "Height",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _heightcontroller,
                    decoration:
                        InputDecoration(hintText: "Please Enter Height(cm)"),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Weight",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _weightcontroller,
                    decoration:
                        InputDecoration(hintText: "Please Enter Weight(kg)"),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Calculate",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        onPressed: _calculate,
                      ),
                      SizedBox(height: 5),
                      SizedBox(width: 40),
                      RaisedButton(
                        child: Text("Clear",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        onPressed: _clear,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Boer Formula     :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(width: 15),
                      Text("LBM: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text("$boerformat" + "kg",
                          style: TextStyle(fontSize: 15)),
                      SizedBox(width: 15),
                      Text("Bodyfat: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(" $bodyfat1format" + "%",
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("James Formula :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(width: 15),
                      Text(" LBM: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text("$jamesformat" + "kg",
                          style: TextStyle(fontSize: 15)),
                      SizedBox(width: 15),
                      Text("Bodyfat: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text("$bodyfat2format" + "%",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Hume Formula   :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(width: 15),
                      Text("  LBM: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text("$humeformat" + "kg",
                          style: TextStyle(fontSize: 15)),
                      SizedBox(width: 15),
                      Text("Bodyfat: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(" $bodyfat3format" + "%",
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (_radioAge == ageoptionyes)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Peters Formula :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(width: 15),
                        Text("  LBM: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text("$petersformat" + "kg",
                            style: TextStyle(fontSize: 15)),
                        SizedBox(width: 15),
                        Text("Bodyfat: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(" $bodyfat4format" + "%",
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  if (_radioAge == ageoptionno)
                    Text("Only Display When Age 14 Or Younger",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
            ),
          )),
    );
  }

  void _calculate() {
    height = double.parse(_heightcontroller.text);
    weight = double.parse(_weightcontroller.text);
    setState(() {
      if (_radioValue == choice1 && _radioAge == ageoptionyes) {
        boer = (0.407 * weight + 0.267 * height - 19.2);
        bodyfat1 = 100 - (boer / weight) * 100;
        james = (1.1 * weight - 128 * pow((weight / height), 2));
        bodyfat2 = 100 - (james / weight) * 100;
        hume = (0.32810 * weight + 0.33929 * height - 29.5336);
        bodyfat3 = 100 - (hume / weight) * 100;
        peters = 3.8 * 0.0215 * pow(weight, 0.6469) * pow(height, 0.7236);
        bodyfat4 = 100 - (peters / weight) * 100; //male formula and 14 age
      } else if (_radioValue == choice1 && _radioAge == ageoptionno) {
        boer = (0.407 * weight + 0.267 * height - 19.2);
        bodyfat1 = 100 - (boer / weight) * 100;
        james = (1.1 * weight - 128 * pow((weight / height), 2));
        bodyfat2 = 100 - (james / weight) * 100;
        hume = (0.32810 * weight + 0.33929 * height - 29.5336);
        bodyfat3 = 100 - (hume / weight) * 100; //male formula not 14 age
      } else if (_radioValue == choice2 && _radioAge == ageoptionyes) {
        boer = (0.252 * weight + 0.473 * height - 48.3);
        bodyfat1 = 100 - (boer / weight) * 100;
        james = (1.07 * weight - 148 * pow((weight / height), 2));
        bodyfat2 = 100 - (james / weight) * 100;
        hume = (0.29569 * weight + 0.41813 * height - 43.2933);
        bodyfat3 = 100 - (hume / weight) * 100;
        peters = 3.8 * 0.0215 * pow(weight, 0.6469) * pow(height, 0.7236);
        bodyfat4 = 100 - (peters / weight) * 100; //female formula and 14 age
      } else if (_radioValue == choice2 && _radioAge == ageoptionno) {
        boer = (0.252 * weight + 0.473 * height - 48.3);
        bodyfat1 = 100 - (boer / weight) * 100;
        james = (1.07 * weight - 148 * pow((weight / height), 2));
        bodyfat2 = 100 - (james / weight) * 100;
        hume = (0.29569 * weight + 0.41813 * height - 43.2933);
        bodyfat3 = 100 - (hume / weight) * 100; //female formula not 14 age
      }
      boerformat = format(boer);
      jamesformat = format(james);
      humeformat = format(hume);
      petersformat = format(peters);
      bodyfat1format = format2(bodyfat1);
      bodyfat2format = format2(bodyfat2);
      bodyfat3format = format2(bodyfat3);
      bodyfat4format = format2(bodyfat4); //define for format
    });
  }

  String format(double n) {
    return n.toStringAsFixed(
        n.truncateToDouble() == n ? 0 : 1); //for decimal output format
  }

  String format2(double f) {
    return f.toStringAsFixed(
        f.truncateToDouble() == f ? 0 : 0); //for decimal output format
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'male':
          choice1 = value;
          break;
        case 'female':
          choice2 = value;
          break;
        default:
          choice = null; //for gender radio
      }
    });
  }

  void radioButtonChanges2(String age) {
    setState(() {
      _radioAge = age;
      switch (age) {
        case 'yes':
          ageoptionyes = age;
          break;
        case 'no':
          ageoptionno = age;
          break;
        default:
          ageoption = null; //for age radio
      }
    });
  }

  void _clear() {
    _weightcontroller.clear();
    _heightcontroller.clear(); //for clear button
  }
}
