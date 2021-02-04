import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_gadget_v2/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  TextEditingController _nmcontroller = TextEditingController();
  TextEditingController _emcontroller = TextEditingController();
  TextEditingController _pscontroller = TextEditingController();
  TextEditingController _phcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _pass = "";
  String _phone = "";
  bool _passwordVisible = true;
  bool _agree = false;
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Registration'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/register.png",
                  scale: 1.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _nmcontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Name', icon: Icon(Icons.person)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _name = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _emcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email', icon: Icon(Icons.email)),
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _phcontroller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Phone', icon: Icon(Icons.phone)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Phone No ';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _phone = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _pscontroller,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: 'password',
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            })),
                    obscureText: _passwordVisible,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _agree,
                      onChanged: (bool value) {
                        _onagree(value);
                      },
                    ),
                    Text('I have read and accept terms and conditions ',
                        style: TextStyle(
                          fontSize: 15,
                        ))
                  ],
                ),
                GestureDetector(
                  onTap: _onAgreement,
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        _showdialog();
                        return;
                      } else {
                        Toast.show("Please Check And Fill In All Required Info",
                            context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.black, width: 2)),
                    textColor: Colors.white,
                    child: Text("Register"),
                  ),
                ),
                GestureDetector(
                  onTap: _onLogin,
                  child: Text(
                    'Already Have An Account？',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegister() async {
    _name = _nmcontroller.text;
    _email = _emcontroller.text;
    _phone = _phcontroller.text;
    _pass = _pscontroller.text;

    if (_agree) {
      if (true) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: false);
        pr.style(message: "Registration...");
        await pr.show();

        http.post("http://triold.com/tgadget/php/PHPMailer/register_usernew.php", body: {
          "name": _name,
          "email": _email,
          "phone": _phone,
          "password": _pass,
        }).then((res) {
          if (res.body == "success") {
            Toast.show("Registration success, Plese Check Your Email To Verify Account", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            setState(() {
              _nmcontroller.text = '';
              _emcontroller.text = '';
              _phcontroller.text = '';
              _pscontroller.text = '';
              _agree = false;
            });
          } else {
            Toast.show("Registration failed", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        }).catchError((err) {
          print(err);
        });
        await pr.hide();
      }
    } else {
      Toast.show("Please accept terms and condition ", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _onLogin() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onagree(bool value) {
    setState(() {
      _agree = value;
    });
  }

  void _onAgreement() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Agreement()));
  }

  _showdialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Are u sure you want to register?"),
              content: new Text("Please make sure all info is correct!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _onRegister();
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}

class Agreement extends StatelessWidget {
  final String agreementtext = """Terms and conditions

These terms and conditions ("Agreement") set forth the general terms and conditions of your use of the "T Gadget" mobile application ("Mobile Application" or "Service") and any of its related products and services (collectively, "Services"). This Agreement is legally binding between you ("User", "you" or "your") and this Mobile Application developer ("Operator", "we", "us" or "our"). By accessing and using the Mobile Application and Services, you acknowledge that you have read, understood, and agree to be bound by the terms of this Agreement. If you are entering into this Agreement on behalf of a business or other legal entity, you represent that you have the authority to bind such entity to this Agreement, in which case the terms "User", "you" or "your" shall refer to such entity. If you do not have such authority, or if you do not agree with the terms of this Agreement, you must not accept this Agreement and may not access and use the Mobile Application and Services. You acknowledge that this Agreement is a contract between you and the Operator, even though it is electronic and is not physically signed by you, and it governs your use of the Mobile Application and Services.

Accounts and membership

If you create an account in the Mobile Application, you are responsible for maintaining the security of your account and you are fully responsible for all activities that occur under the account and any other actions taken in connection with it. We may, but have no obligation to, monitor and review new accounts before you may sign in and start using the Services. Providing false contact information of any kind may result in the termination of your account. You must immediately notify us of any unauthorized uses of your account or any other breaches of security. We will not be liable for any acts or omissions by you, including any damages of any kind incurred as a result of such acts or omissions. We may suspend, disable, or delete your account (or any part thereof) if we determine that you have violated any provision of this Agreement or that your conduct or content would tend to damage our reputation and goodwill. If we delete your account for the foregoing reasons, you may not re-register for our Services. We may block your email address and Internet protocol address to prevent further registration.

User content

We do not own any data, information or material (collectively, "Content") that you submit in the Mobile Application in the course of using the Service. You shall have sole responsibility for the accuracy, quality, integrity, legality, reliability, appropriateness, and intellectual property ownership or right to use of all submitted Content. We may, but have no obligation to, monitor and review the Content in the Mobile Application submitted or created using our Services by you. You grant us permission to access, copy, distribute, store, transmit, reformat, display and perform the Content of your user account solely as required for the purpose of providing the Services to you. Without limiting any of those representations or warranties, we have the right, though not the obligation, to, in our own sole discretion, refuse or remove any Content that, in our reasonable opinion, violates any of our policies or is in any way harmful or objectionable. You also grant us the license to use, reproduce, adapt, modify, publish or distribute the Content created by you or stored in your user account for commercial, marketing or any similar purpose.

Backups

We are not responsible for the Content residing in the Mobile Application. In no event shall we be held liable for any loss of any Content. It is your sole responsibility to maintain appropriate backup of your Content. Notwithstanding the foregoing, on some occasions and in certain circumstances, with absolutely no obligation, we may be able to restore some or all of your data that has been deleted as of a certain date and time when we may have backed up data for our own purposes. We make no guarantee that the data you need will be available.

Links to other resources

Although the Mobile Application and Services may link to other resources (such as websites, mobile applications, etc.), we are not, directly or indirectly, implying any approval, association, sponsorship, endorsement, or affiliation with any linked resource, unless specifically stated herein. We are not responsible for examining or evaluating, and we do not warrant the offerings of, any businesses or individuals or the content of their resources. We do not assume any responsibility or liability for the actions, products, services, and content of any other third parties. You should carefully review the legal statements and other conditions of use of any resource which you access through a link in the Mobile Application and Services. Your linking to any other off-site resources is at your own risk.

Changes and amendments

We reserve the right to modify this Agreement or its terms relating to the Mobile Application and Services at any time, effective upon posting of an updated version of this Agreement in the Mobile Application. When we do, we will revise the updated date at the bottom of this page. Continued use of the Mobile Application and Services after any such changes shall constitute your consent to such changes. Policy was created with https://www.WebsitePolicies.com

Acceptance of these terms

You acknowledge that you have read this Agreement and agree to all its terms and conditions. By accessing and using the Mobile Application and Services you agree to be bound by this Agreement. If you do not agree to abide by the terms of this Agreement, you are not authorized to access or use the Mobile Application and Services.

Contacting us

If you would like to contact us to understand more about this Agreement or wish to contact us concerning any matter relating to it, you may send an email to teocheeyuan1998@gmail.com

This document was last updated on December 11, 2020


""";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.label_important),
        centerTitle: true,
        title: Text('Agreement'),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Go Back',
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
              child: Text(
            agreementtext,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ))),
      backgroundColor: Colors.white,
    );
  }
}
