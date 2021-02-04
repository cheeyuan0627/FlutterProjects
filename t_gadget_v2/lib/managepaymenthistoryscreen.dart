import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:t_gadget_v2/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:t_gadget_v2/user.dart';

class PaymenthistoryScreen extends StatefulWidget {
  final User user;

  const PaymenthistoryScreen({Key key, this.user}) : super(key: key);
  @override
  _PaymenthistoryScreenState createState() => _PaymenthistoryScreenState();
}

class _PaymenthistoryScreenState extends State<PaymenthistoryScreen> {
  List paidlist;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Payment History...";

  @override
  void initState() {
    super.initState();
    _loadhistory();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Payment History'),
            backgroundColor: Colors.black87,
            centerTitle: true,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Mainscreen(),
                    ));
              },
            ),
          ),
          body: Column(children: [
            paidlist == null
                ? Flexible(
                    child: Container(
                        child: Center(
                            child: Text(
                    titlecenter,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ))))
                : Flexible(
                    child: GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: (screenWidth / screenHeight) / 0.23,
                    children: List.generate(paidlist.length, (index) {
                      return Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Card(
                              color: Colors.blueGrey[100],
                              child: InkWell(
                                child: SingleChildScrollView(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        20,
                                        0,
                                        20,
                                        0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "USER EMAIL: " + widget.user.email,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                           Text(
                                            "USER PHONE: " + widget.user.phone,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "RECEIPT ID: " +
                                                paidlist[index]['receiptid'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "TOTAL PAY AMOUNT: RM" +
                                                paidlist[index]['amount'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "DATE/TIME: " +
                                                paidlist[index]['date'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              )));
                    }),
                  ))
          ])),
    );
  }

  void _loadhistory() {
    http.post("http://triold.com/tgadget/php/load_paidhistory.php", body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        paidlist = null;
        setState(() {
          titlecenter = "Empty History";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          paidlist = jsondata["paid"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
