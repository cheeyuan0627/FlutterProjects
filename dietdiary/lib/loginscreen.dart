import 'package:dietdiary/profile_screen.dart';
import 'forgotpass.dart';
import 'registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emcontroller = TextEditingController();
  String _email = "";
  TextEditingController _pscontroller = TextEditingController();
  String _pass = "";
  bool _rememberMe = false;
  bool _passwordVisible = true;
  SharedPreferences prefs;

  @override
  void initState() {
    loadpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressAppBar,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/dietdiary2.png",
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _emcontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          icon: Icon(Icons.email)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _pscontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              })),
                      obscureText: _passwordVisible,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: 300,
                      height: 50,
                      child: Text('Login'),
                      color: Colors.black,
                      textColor: Colors.white,
                      elevation: 20,
                      onPressed: _onPress,
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (bool value) {
                            _onChange(value);
                          },
                        ),
                        Text('Remember Me',
                            style: TextStyle(fontSize: 16, color: Colors.black))
                      ],
                    ),
                    GestureDetector(
                      onTap: _onRegister,
                      child: Text(
                        'Register New Account',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: _onForgot,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
      savepref(value);
    });
  }

  void _onPress() async {
    _email = _emcontroller.text;
    _pass = _pscontroller.text;

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Login...");
    await pr.show();

    http.post("http://triold.com/dietdiary/php/login_user.php", body: {
      "email": _email,
      "password": _pass,
    }).then((res) {
      print(res.body);
      List userdata = res.body.split(",");
      if (userdata[0] == "success") {
        Toast.show("Login success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        User user = new User(
            name: userdata[1],
            email: userdata[2],
            phone: userdata[3],
            password: userdata[4],
            datereg: userdata[5]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ProfileScreen(
                      user: user,
                    )));
      } else {
        Toast.show("Login failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }

  void _onRegister() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Registerscreen()));
  }

  void _onForgot() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ForgorpassScreen()));
  }

  void loadpref() async {
    prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email')) ?? '';
    _pass = (prefs.getString('password')) ?? '';
    _rememberMe = (prefs.getBool('rememberme')) ?? false;
    if (_email.isNotEmpty) {
      setState(() {
        _emcontroller.text = _email;
        _pscontroller.text = _pass;
        _rememberMe = true;
      });
    }
  }

  void savepref(bool value) async {
    prefs = await SharedPreferences.getInstance();
    _email = _emcontroller.text;
    _pass = _pscontroller.text;

    if (value) {
      if (_email.length < 5 && _pass.length < 1) {
        print('Email/Password Empty');
        _rememberMe = false;
        Toast.show("Email/password is empty", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        return;
      } else {
        await prefs.setString('email', _email);
        await prefs.setString('password', _pass);
        await prefs.setBool('rememberme', value);
        Toast.show("Login Detail Saved", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      await prefs.setBool('rememberme', false);
      Toast.show("Login Detail Removed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      setState(() {
        _emcontroller.text = '';
        _pscontroller.text = '';
        _rememberMe = false;
      });
    }
  }
}
