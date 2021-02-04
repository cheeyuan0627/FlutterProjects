import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:t_gadget_v2/mainscreen.dart';
import 'package:toast/toast.dart';
import 'billscreen.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class Shoppingcart extends StatefulWidget {
  final User user;

  const Shoppingcart({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  _ShoppingcartState createState() => _ShoppingcartState();
}

class _ShoppingcartState extends State<Shoppingcart> {
  TextEditingController _addresscontroller = TextEditingController();

  List<String> locList = [
    "Johor",
    "Kedah",
    "Kelantan",
    "Malacca",
    "Negeri Sembilan",
    "Pahang",
    "Penang",
    "Perak",
    "Perlis",
    "Sabah",
    "Sarawak",
    "Selangor",
    "Terangganu",
  ];
  String selectedLoc;
  List cartlist;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Cart...";
  double totalPrice = 0.0;
  int numcart = 0;
  int producttype = 0;
  int stateprice = 0;
  int finalprice = 0;

  @override
  void initState() {
    super.initState();
    _loadcart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                numcart.toString() + " products in your cart",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black87,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Mainscreen()));
                  },
                )
              ],
            ),
            body: Column(children: [
              cartlist == null
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
                      childAspectRatio: (screenWidth / screenHeight) / 0.2,
                      children: List.generate(cartlist.length, (index) {
                        return Padding(
                            padding: EdgeInsets.all(1),
                            child: Card(
                                child: InkWell(
                              onLongPress: () => _deleteOrderDialog(index),
                              child: SingleChildScrollView(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: screenHeight / 6,
                                        width: screenWidth / 3,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://triold.com/tgadget/images/itempictures/${cartlist[index]['itempicture']}.png",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                            Icons.broken_image,
                                            size: screenWidth / 2,
                                          ),
                                        )),
                                    SizedBox(width: 40),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          cartlist[index]['itemname'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("RM " +
                                            cartlist[index]['itemprice'] +
                                            " x " +
                                            cartlist[index]['itemquantity'] +
                                            " unit"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("Total Price : RM " +
                                            (double.parse(cartlist[index]
                                                        ['itemprice']) *
                                                    int.parse(cartlist[index]
                                                        ['itemquantity']))
                                                .toStringAsFixed(2))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )));
                      }),
                    )),
              Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                  height: 45,
                  child: TextField(
                    controller: _addresscontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                        labelText: 'Please Enter Full Delivery Address',
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 5, 5),
                                      child: Icon(Icons.location_city),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 20, 0),
                                      alignment: Alignment.centerLeft,
                                      height: 40,
                                      child: DropdownButton(
                                        hint: Text(
                                          'Please select your state',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        value: selectedLoc,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedLoc = newValue;
                                            _calculatePayment();
                                            print(selectedLoc);
                                          });
                                        },
                                        items: locList.map((selectedLoc) {
                                          return DropdownMenuItem(
                                            child: new Text(selectedLoc,
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            value: selectedLoc,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Total Product Price : RM" +
                                      totalPrice.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Final Price With Shipping Fee: RM" +
                                      finalprice.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Shipping Fee(Each Type): West M= RM9 East M= RM15",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                height: 40,
                child: Text('Make Payment'),
                color: Colors.black,
                textColor: Colors.white,
                elevation: 10,
                onPressed: () => {
                  _makePaymentDialog(),
                },
              ),
            ])));
  }

  void _loadcart() {
    http.post("http://triold.com/tgadget/php/load_shoppingcart.php", body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        cartlist = null;
        setState(() {
          titlecenter = "Empty Cart";
        });
      } else {
        totalPrice = 0;
        numcart = 0;
        setState(() {
          var jsondata = json.decode(res.body);
          cartlist = jsondata["cart"];
          for (int i = 0; i < cartlist.length; i++) {
            totalPrice = totalPrice +
                double.parse(cartlist[i]['itemprice']) *
                    int.parse(cartlist[i]['itemquantity']);
            numcart = numcart + int.parse(cartlist[i]['itemquantity']);
            producttype = cartlist.length;
          }
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _deleteOrderDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Delete order " + cartlist[index]['itemname'] + "?",
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
              onPressed: () async {
                print("Delete " + cartlist[index]['itemname']);
                Navigator.of(context).pop();
                _deletecart(index);
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _makePaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Are you sure to pay RM' + finalprice.toStringAsFixed(2) + "?",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        content: Text(
          'Address: ' + _addresscontroller.text,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                  _makePayment();
              },
              child: Text(
                "Ok",
                style: TextStyle(),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(),
              )),
        ],
      ),
    );
  }

  _calculatePayment() {
    setState(() {
      if (selectedLoc == "Johor") {
        stateprice = 9;
      } else if (selectedLoc == "Kedah") {
        stateprice = 9;
      } else if (selectedLoc == "Kelantan") {
        stateprice = 9;
      } else if (selectedLoc == "Malacca") {
        stateprice = 9;
      } else if (selectedLoc == "Negeri Sembilan") {
        stateprice = 9;
      } else if (selectedLoc == "Pahang") {
        stateprice = 9;
      } else if (selectedLoc == "Penang") {
        stateprice = 9;
      } else if (selectedLoc == "Perak") {
        stateprice = 9;
      } else if (selectedLoc == "Perlis") {
        stateprice = 9;
      } else if (selectedLoc == "Sabah") {
        stateprice = 15;
      } else if (selectedLoc == "Sarawak") {
        stateprice = 15;
      } else if (selectedLoc == "Selangor") {
        stateprice = 9;
      } else if (selectedLoc == "Terengganu") {
        stateprice = 9;
      }

      finalprice = (stateprice * producttype) + totalPrice.toInt();
    });
  }

  void _deletecart(int index) async {
    http.post("http://triold.com/tgadget/php/delete_shoppingcart.php", body: {
      "email": widget.user.email,
      "itemid": cartlist[index]['itemid'],
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        _loadcart();
        Toast.show(
          "Delete Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
      } else {
        Toast.show(
          "Delete failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
      }
    }).catchError((err) {
      print(err);
    });
  }
  
  Future<void> _makePayment() async {
     await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BillScreen(
                  user: widget.user,
                  val: finalprice.toStringAsFixed(2),
                  add: _addresscontroller.text,
                )));
                _calculatePayment();
                _loadcart();
  }
}


