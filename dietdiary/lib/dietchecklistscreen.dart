import 'package:dietdiary/profile_screen.dart';
import 'package:dietdiary/user.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DietchecklistScreen extends StatefulWidget {
  final User user;

  const DietchecklistScreen({Key key, this.user}) : super(key: key);
  @override
  _DietchecklistScreenState createState() => _DietchecklistScreenState();
}

class _DietchecklistScreenState extends State<DietchecklistScreen> {
  double screenHeight, screenWidth;

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
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfileScreen()));
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [Icon(Icons.update),
                      SizedBox(width: 5,),
                        Text(
                          "BMI : 33",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 15,
                          height: 25,
                          child: Center(),
                        ),Icon(Icons.face),
                        SizedBox(width:5),
                        Text(
                          "Status: You Are Obesed",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: 30,
                          child: Center(),
                        ),
                        Text(
                          "BREASKFAST",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),SizedBox(width: 5,),
                        Icon(Icons.breakfast_dining)
                      ],
                    )),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: (Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                    child: InkWell(
                      onLongPress: () => _adddialog(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Egg",
                              ),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Quantity : 1",
                                  ),
                                ],
                              ),
                              leading: ClipRRect(
                                child: Image.asset(
                                  "assets/images/egg.jpg",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
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
                ),
                SingleChildScrollView(
                  child: (Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                    child: InkWell(
                      onLongPress: () => _adddialog(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Yougurt",
                              ),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Quantity : 1",
                                  ),
                                ],
                              ),
                              leading: ClipRRect(
                                child: Image.asset(
                                  "assets/images/yougurt.png",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
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
                ),
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: 25,
                          child: Center(),
                        ),
                        Text(
                          "LUNCH",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),SizedBox(width: 5,),
                        Icon(Icons.lunch_dining)
                      ],
                    )),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: (Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                    child: InkWell(
                      onLongPress: () => _adddialog(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Greek Quinoa Salad",
                              ),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Quantity : 1",
                                  ),
                                ],
                              ),
                              leading: ClipRRect(
                                child: Image.asset(
                                  "assets/images/salad.jpg",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
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
                ),
                SingleChildScrollView(
                  child: (Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                    child: InkWell(
                      onLongPress: () => _adddialog(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Whole Grains",
                              ),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Quantity : 1",
                                  ),
                                ],
                              ),
                              leading: ClipRRect(
                                child: Image.asset(
                                  "assets/images/wholegrains.jpg",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
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
                ),
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: 25,
                          child: Center(),
                        ),
                        Text(
                          "DINNER",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),SizedBox(width: 5,),
                        Icon(Icons.dinner_dining,)
                      ],
                    )),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: (Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                    child: InkWell(
                      onLongPress: () => _adddialog(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Boiled Potatoes",
                              ),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Quantity : 1",
                                  ),
                                ],
                              ),
                              leading: ClipRRect(
                                child: Image.asset(
                                  "assets/images/boiledpotatoes.jpg",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
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
                ),
                SingleChildScrollView(
                  child: (Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                    child: InkWell(
                      onLongPress: () => _adddialog(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Soup",
                              ),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Quantity : 1",
                                  ),
                                ],
                              ),
                              leading: ClipRRect(
                                child: Image.asset(
                                  "assets/images/soup.jpg",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
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
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
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
}
