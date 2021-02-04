import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:t_gadget_v2/item.dart';
import 'package:t_gadget_v2/itemdetailsscreen.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:t_gadget_v2/managepaymenthistoryscreen.dart';
import 'package:t_gadget_v2/shoppingcartscreen.dart';
import 'package:t_gadget_v2/user.dart';
import 'package:toast/toast.dart';
import 'addproductscreen.dart';
import 'loginscreen.dart';
import 'manageproductscreen.dart';

class Mainscreen extends StatefulWidget {
  final User user;

  const Mainscreen({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List itemList;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Products...";

  List<String> typeList = [
    "Computer/Laptop",
    "Assesories",
    "Mouse",
    "Keyboard",
    "Monitor",
  ];
  String selectedtype;
  @override
  void initState() {
    super.initState();
    _loaditemlist();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Product List'),
              centerTitle: true,
              backgroundColor: Colors.black87,
              actions: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(Icons.refresh),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Mainscreen(
                                    user: widget.user,
                                  )));
                      Toast.show(
                        " Refresh Success",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM,
                      );
                    },
                  ),
                ),
                Flexible(
                    child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () => _shoppingcart(),
                )),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            drawer: Drawer(
              child: Column(children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(widget.user.name,
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  accountEmail: Text(widget.user.email,
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  decoration: BoxDecoration(
                    color: const Color(0xDD000000),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      '${widget.user.name[0]}',
                      style: TextStyle(fontSize: 50.0),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text(
                    'Add New Product',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Addproduct(
                                  user: widget.user,
                                )));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.storage),
                  title: Text(
                    'Manage My Product',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Manageproduct(
                                  user: widget.user,
                                )));
                  },
                ),
                    ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    'Payment History',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => PaymenthistoryScreen(user: widget.user,
                                
                                )));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () => _logoutDialog(),
                )
              ]),
            ),
            body: Column(children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 90,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      height: 40,
                      child: DropdownButton(
                        hint: Text(
                          'SELECT TYPE TO SEARCH',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        value: selectedtype,
                        onChanged: (newValue) {
                          setState(() {
                            selectedtype = newValue;
                            print(selectedtype);
                          });
                        },
                        items: typeList.map((selectedtype) {
                          return DropdownMenuItem(
                            child: new Text(selectedtype,
                                style: TextStyle(color: Colors.black)),
                            value: selectedtype,
                          );
                        }).toList(),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      icon: Icon(Icons.search),
                      iconSize: 22,
                      onPressed: () {
                        if (selectedtype != null) {
                          _loadSearchitem();
                        } else {
                          Toast.show(
                            " Plese Select Product Type Before Seacrh",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                          );
                        }
                      },
                    ),
                  ],
                ),
                color: Colors.blueGrey[100],
              ),
              itemList == null
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
                      crossAxisCount: 2,
                      children: List.generate(itemList.length, (index) {
                        return Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Card(
                                child: InkWell(
                              onTap: () => _loadItemDetail(index),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Stack(children: [
                                      Container(
                                          height: 115,
                                          width: 165,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "http://triold.com/tgadget/images/itempictures/${itemList[index]['itempicture']}.png",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(
                                              Icons.broken_image,
                                              size: screenWidth / 2,
                                            ),
                                          )),
                                      Positioned(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(
                                              children: [
                                                Text(
                                                    itemList[index]
                                                        ['itemstatus'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Icon(Icons.recommend,
                                                    color: Colors.black),
                                              ],
                                            )),
                                        top: 2,
                                        right: 2,
                                      )
                                    ]),
                                    Text(
                                      itemList[index]['itemname'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "RM " + itemList[index]['itemprice'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      itemList[index]['itemtype'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )));
                      }),
                    ))
            ])));
  }

  void _loaditemlist() {
    http.post("http://triold.com/tgadget/php/load_productlist.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        itemList = null;
        setState(() {
          titlecenter = "No Product Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          itemList = jsondata["item"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadSearchitem() async {
    http.post("http://triold.com/tgadget/php/load_productlist.php", body: {
      "itemtype": selectedtype,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        itemList = null;
        setState(() {
          titlecenter = "No Product Found";
        });
        Toast.show(
          " No Result Found",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          itemList = jsondata["item"];
          Toast.show(
            "Product search found",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
          );
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _logoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Logout ?",
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
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
                Toast.show(
                  "Logout Success",
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                );
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
                Toast.show(
                  " Process Cancel",
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                );
              },
            ),
          ],
        );
      },
    );
  }

  _loadItemDetail(int index) {
    Item items = new Item(
        itempicture: itemList[index]['itempicture'],
        itemname: itemList[index]['itemname'],
        itemprice: itemList[index]['itemprice'],
        itemtype: itemList[index]['itemtype'],
        itemstatus: itemList[index]['itemstatus'],
        itemlocation: itemList[index]['itemlocation'],
        itemdescription: itemList[index]['itemdescription'],
        itemquantity: itemList[index]['itemquantity'],
        itemid: itemList[index]['itemid'],
        sellerid: itemList[index]['sellerid']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ItemdetailsscreenState(
                  item: items,
                  user: widget.user,
                )));
  }

  _shoppingcart() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Shoppingcart(
                  user: widget.user,
                )));
  }
}
