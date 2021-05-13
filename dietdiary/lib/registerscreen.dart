import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'loginscreen.dart';

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

  double screenWidth;
  double screenHeight;
  String _name = "";
  String _email = "";
  String _pass = "";
  String _phone = "";
  bool _passwordVisible = true;
  bool _agree = false;
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
                      labelText: 'Name',
                      icon: Icon(Icons.person),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _phcontroller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      icon: Icon(Icons.phone),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
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
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
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
                            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.black, width: 2)),
                    textColor: Colors.white,
                    child: Text("Register"),
                  ),
                ),SizedBox(height: 10,),
                GestureDetector(
                  onTap: _onLogin,
                  child: Text(
                    'Already Have An Account？',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),SizedBox(height: 10,)
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

        http.post(
            "http://triold.com/dietdiary/php/PHPMailer/register_usernew.php",
            body: {
              "name": _name,
              "email": _email,
              "phone": _phone,
              "password": _pass,
            }).then((res) {
          if (res.body == "success") {
            Toast.show("Registration Success, Please Check Email", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
            setState(() {
              _nmcontroller.text = '';
              _emcontroller.text = '';
              _phcontroller.text = '';
              _pscontroller.text = '';
              _agree = false;
            });
          } else {
            Toast.show("Registration failed", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          }
        }).catchError((err) {
          print(err);
        });
        await pr.hide();
      }
    } else {
      Toast.show("Please accept terms and condition ", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
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
  final String agreementtext = """Acceptable use policy

This acceptable use policy ("Policy") sets forth the general guidelines and acceptable and prohibited uses of the "Diet Diary" mobile application ("Mobile Application" or "Service") and any of its related products and services (collectively, "Services"). This Policy is a legally binding agreement between you ("User", "you" or "your") and this Mobile Application developer ("Operator", "we", "us" or "our"). By accessing and using the Mobile Application and Services, you acknowledge that you have read, understood, and agree to be bound by the terms of this Agreement. If you are entering into this Agreement on behalf of a business or other legal entity, you represent that you have the authority to bind such entity to this Agreement, in which case the terms "User", "you" or "your" shall refer to such entity. If you do not have such authority, or if you do not agree with the terms of this Agreement, you must not accept this Agreement and may not access and use the Mobile Application and Services. You acknowledge that this Agreement is a contract between you and the Operator, even though it is electronic and is not physically signed by you, and it governs your use of the Mobile Application and Services.

Prohibited activities and uses

You may not use the Mobile Application and Services to publish content or engage in activity that is illegal under applicable law, that is harmful to others, or that would subject us to liability, including, without limitation, in connection with any of the following, each of which is prohibited under this Policy:

- Distributing malware or other malicious code.
- Disclosing sensitive personal information about others.
- Collecting, or attempting to collect, personal information about third parties without their knowledge or consent.
- Distributing pornography or adult related content.
- Promoting or facilitating prostitution or any escort services.
- Hosting, distributing or linking to child pornography or content that is harmful to minors.
- Promoting or facilitating gambling, violence, terrorist activities or selling weapons or ammunition.
- Engaging in the unlawful distribution of controlled substances, drug contraband or prescription medications.
- Managing payment aggregators or facilitators such as processing payments on behalf of other businesses or charities.
- Facilitating pyramid schemes or other models intended to seek payments from public actors.
- Threatening harm to persons or property or otherwise harassing behavior.
- Infringing the intellectual property or other proprietary rights of others.
- Facilitating, aiding, or encouraging any of the above activities through the Mobile Application and Services.

System abuse

Any User in violation of the Mobile Application and Services security is subject to criminal and civil liability, as well as immediate account termination. Examples include, but are not limited to the following:

- Use or distribution of tools designed for compromising security of the Mobile Application and Services.
- Intentionally or negligently transmitting files containing a computer virus or corrupted data.
- Accessing another network without permission, including to probe or scan for vulnerabilities or breach security or authentication measures.
- Unauthorized scanning or monitoring of data on any network or system without proper authorization of the owner of the system or network.

Service resources

You may not consume excessive amounts of the resources of the Mobile Application and Services or use the Mobile Application and Services in any way which results in performance issues or which interrupts the Services for other Users. Prohibited activities that contribute to excessive use, include without limitation:

- Deliberate attempts to overload the Mobile Application and Services and broadcast attacks (i.e. denial of service attacks).
- Engaging in any other activities that degrade the usability and performance of the Mobile Application and Services.

No spam policy

You may not use the Mobile Application and Services to send spam or bulk unsolicited messages. We maintain a zero tolerance policy for use of the Mobile Application and Services in any manner associated with the transmission, distribution or delivery of any bulk e-mail, including unsolicited bulk or unsolicited commercial e-mail, or the sending, assisting, or commissioning the transmission of commercial e-mail that does not comply with the U.S. CAN-SPAM Act of 2003 ("SPAM").

Your products or services advertised via SPAM (i.e. Spamvertised) may not be used in conjunction with the Mobile Application and Services. This provision includes, but is not limited to, SPAM sent via fax, phone, postal mail, email, instant messaging, or newsgroups.

Defamation and objectionable content

We value the freedom of expression and encourage Users to be respectful with the content they post. We are not a publisher of User content and are not in a position to investigate the veracity of individual defamation claims or to determine whether certain material, which we may find objectionable, should be censored. However, we reserve the right to moderate, disable or remove any content to prevent harm to others or to us or the Mobile Application and Services, as determined in our sole discretion.

Copyrighted content

Copyrighted material must not be published via the Mobile Application and Services without the explicit permission of the copyright owner or a person explicitly authorized to give such permission by the copyright owner. Upon receipt of a claim for copyright infringement, or a notice of such violation, we may, at our discretion, run an investigation and, upon confirmation, may remove the infringing material from the Mobile Application and Services. We may terminate the Service of Users with repeated copyright infringements. Further procedures may be carried out if necessary. We will assume no liability to any User of the Mobile Application and Services for the removal of any such material. If you believe your copyright is being infringed by a person or persons using the Mobile Application and Services, please get in touch with us to report copyright infringement.

Security

You take full responsibility for maintaining reasonable security precautions for your account. You are responsible for protecting and updating any login account provided to you for the Mobile Application and Services. You must protect the confidentiality of your login details, and you should change your password periodically.

Enforcement

We reserve our right to be the sole arbiter in determining the seriousness of each infringement and to immediately take corrective actions, including but not limited to:

- Disabling or removing any content which is prohibited by this Policy, including to prevent harm to others or to us or the Mobile Application and Services, as determined by us in our sole discretion.
- Reporting violations to law enforcement as determined by us in our sole discretion.
- A failure to respond to an email from our abuse team within 2 days, or as otherwise specified in the communication to you, may result in the suspension or termination of your account.

Suspended and terminated User accounts due to violations will not be re-activated.

Nothing contained in this Policy shall be construed to limit our actions or remedies in any way with respect to any of the prohibited activities. In addition, we reserve at all times all rights and remedies available to us with respect to such activities at law or in equity.

Reporting violations

If you have discovered and would like to report a violation of this Policy, please contact us immediately. We will investigate the situation and provide you with full assistance.

Changes and amendments

We reserve the right to modify this Policy or its terms relating to the Mobile Application and Services at any time, effective upon posting of an updated version of this Policy in the Mobile Application. When we do, we will revise the updated date at the bottom of this page. Continued use of the Mobile Application and Services after any such changes shall constitute your consent to such changes. Policy was created with https://www.WebsitePolicies.com

Acceptance of this policy

You acknowledge that you have read this Policy and agree to all its terms and conditions. By accessing and using the Mobile Application and Services you agree to be bound by this Policy. If you do not agree to abide by the terms of this Policy, you are not authorized to access or use the Mobile Application and Services.

Contacting us

If you would like to contact us to understand more about this Policy or wish to contact us concerning any matter relating to it, you may send an email to teocheeyuan1998@gmail.com

This document was last updated on January 23, 2021


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
