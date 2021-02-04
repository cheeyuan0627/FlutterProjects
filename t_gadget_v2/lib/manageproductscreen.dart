import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:t_gadget_v2/user.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:toast/toast.dart';
import 'mainscreen.dart';

class Manageproduct extends StatefulWidget {
  final User user;

  const Manageproduct({Key key, this.user}) : super(key: key);
  @override
  _ManageproductState createState() => _ManageproductState();
}

class _ManageproductState extends State<Manageproduct> {
  List productList;
  String titlecenter = "Loading Products...";
  double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    _loaduserproduct();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Text('Manage Product'),
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Mainscreen(user: widget.user,),
                    ));
              },
            ),
          ),
          body: Column(children: [
            productList == null
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
                    children: List.generate(productList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(1),
                          child: Card(
                              child: InkWell(
                             onLongPress: () => _deleteuserproduct(index),
                            child: SingleChildScrollView(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: screenHeight / 6,
                                      width: screenWidth / 4,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://triold.com/tgadget/images/itempictures/${productList[index]['itempicture']}.png",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(
                                          Icons.broken_image,
                                          size: screenWidth / 2,
                                        ),
                                      )),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        productList[index]['itemname'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                       Text("Unit: "  +
                                          productList[index]['itemquantity'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                        height: 15,
                                      ),
                                        Text(
                                          "RM  " +productList[index]['itemprice'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                     
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )));
                    }),
                  )),
          ]),
        ));
  }

  void _loaduserproduct() {
    http.post("http://triold.com/tgadget/php/manage_myproduct.php", body: {
        "sellerid": widget.user.name,
    }).then(
        (res) {
      print(res.body);
      if (res.body == "nodata") {
        productList = null;
        setState(() {
          titlecenter = "No Item Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          productList = jsondata["product"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
   _deleteuserproduct(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Delete order " + productList[index]['itemname'] + "?",
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
                print("Delete " + productList[index]['itemname']);
                Navigator.of(context).pop();
                _deleteproduct(index);
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
  void _deleteproduct(int index) async{
     http.post("http://triold.com/tgadget/php/delete_myproduct.php", body: {
      "sellerid": widget.user.name,
      'itemid': productList[index]['itemid'],
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
         _loaduserproduct();
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
}

