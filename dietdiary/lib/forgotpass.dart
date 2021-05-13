import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class ForgorpassScreen extends StatefulWidget {
  @override
  _ForgorpassState createState() => _ForgorpassState();
}

class _ForgorpassState extends State<ForgorpassScreen> {
  TextEditingController _emcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email = "";
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ));
              },
            ),
            centerTitle: true,
            title: Text('Reset Password'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/resetpass.png",
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: 100,
                    ),
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
                                    title: Text('Please Enter U Email To Reset',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 20, right: 20),
                      child: TextFormField(
                        controller: _emcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please Enter a valid Email';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _email = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 45,
                      child: RaisedButton(
                        color: Colors.black,
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            _confirmdialog();
                            return;
                          } else {
                            Toast.show(
                                "Please Check And Fill In All Required Info",
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.TOP);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.black, width: 2)),
                        textColor: Colors.white,
                        child: Text("Confirm"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _resetpass() async {
    _email = _emcontroller.text;

    if (true) {
      http.post("http://triold.com/dietdiary/php/PHPMailer/resetpass.php",
          body: {
            "email": _email,
          }).then((res) {
        if (res.body == "success") {
          Toast.show("Success! Please Check Your Email", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          setState(() {
            _emcontroller.text = '';
          });
        } else {
          Toast.show("Email No Yet Registered", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  _confirmdialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Email Is Correct?",
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
                _resetpass();
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
}

