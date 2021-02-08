import 'package:dietdiary/profile_screen.dart';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';


class ResultScreen extends StatelessWidget {
  final bmiModel;
  final User user;

  const ResultScreen({Key key, this.bmiModel, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            child: bmiModel.isNormal
                ? (Image.asset(
                    "assets/images/strong1.png",
                  ))
                : (Image.asset(
                    "assets/images/fat1.png",
                  )),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Your BMI is ${bmiModel.bmi.round()}",
            style: TextStyle(
                color: Colors.blue[700],
                fontSize: 34,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "${bmiModel.comments}",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 16,
          ),
          bmiModel.isNormal
              ? Text(
                  "Hurray! Your BMI is Normal.",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )
              : Text(
                  "Sadly! Your BMI is not Normal.",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: FlatButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              label: Text("LET CALCULATE AGAIN / GO BACK"),
              textColor: Colors.white,
              color: Colors.blue,
            ),
            width: double.infinity,
            padding: EdgeInsets.only(left: 16, right: 16),
          ),
        ],
      ),
    ));
  }
}

class BMIModel {
  double bmi;
  bool isNormal;
  String comments;

  BMIModel({this.bmi, this.isNormal, this.comments});
}

class BMICalculatorScreen extends StatefulWidget {
  final User user;

  const BMICalculatorScreen({Key key, this.user}) : super(key: key);
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _heightOfUser = 120.0;
  double _weightOfUser = 48.0;
  double _bmi = 0;

  BMIModel _bmiModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Please calculate your BMI ",),backgroundColor: Colors.black87,
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 180,
                width: 200,
                child: Image.asset(
                  "assets/images/bmi.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "BMI Calculator",
                style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "We care about your health",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Height (cm)",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Slider(
                  min: 0.0,
                  max: 200.0,
                  onChanged: (height) {
                    setState(() {
                      _heightOfUser = height;
                    });
                  },
                  value: _heightOfUser,
                  divisions: 100,
                  activeColor: Colors.blue,
                  label: "$_heightOfUser",
                ),
              ),
              Text(
                "$_heightOfUser cm",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Weight (kg)",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Slider(
                  min: 0.0,
                  max: 150.0,
                  onChanged: (height) {
                    setState(() {
                      _weightOfUser = height;
                    });
                  },
                  value: _weightOfUser,
                  divisions: 100,
                  activeColor: Colors.blue,
                  label: "$_weightOfUser",
                ),
              ),
              Text(
                "$_weightOfUser kg",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      _bmi = _weightOfUser /
                          ((_heightOfUser / 100) * (_heightOfUser / 100));

                      if (_bmi >= 18.5 && _bmi <= 25) {
                        _bmiModel = BMIModel(
                            bmi: _bmi,
                            isNormal: true,
                            comments: "You are Totaly Fit");
                      } else if (_bmi < 18.5) {
                        _bmiModel = BMIModel(
                            bmi: _bmi,
                            isNormal: false,
                            comments: "You are Underweighted");
                      } else if (_bmi > 25 && _bmi <= 30) {
                        _bmiModel = BMIModel(
                            bmi: _bmi,
                            isNormal: false,
                            comments: "You are Overweighted");
                      } else if(_bmi > 30 && _bmi <= 40) {
                        _bmiModel = BMIModel(
                            bmi: _bmi,
                            isNormal: false,
                            comments: "You are Obesed");
                      }
                      else {
                        _bmiModel = BMIModel(
                            bmi: _bmi,
                            isNormal: false,
                            comments: "You are Class 3 Obese");
                      }
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                  bmiModel: _bmiModel,
                                  user: widget.user,
                                )));
                    _savebmiinfo();
                  },
                  icon: Icon(
                    Icons.calculate,
                    color: Colors.white,
                  ),
                  label: Text("CALCULATE"),
                  textColor: Colors.white,
                  color: Colors.blue,
                ),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _savebmiinfo() async {
    http.post("http://triold.com/dietdiary/php/save_bmiuser.php", body: {
      "weight": _weightOfUser.toString(),
      "height": _heightOfUser.toString(),
      "bmi": _bmi.toString(),
      "type" : _bmiModel.comments,
      "email": widget.user.email,
    }).then((res) {
       if (res.body == "success") {
        Toast.show("BMI INFO SAVED", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }else {
        Toast.show("FAILED TO SAVE BMI INFO", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }
}