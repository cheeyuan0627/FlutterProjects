import 'package:flutter/material.dart';
import 'package:t_gadget_v2/itemdetailsscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:t_gadget_v2/user.dart';
import 'package:toast/toast.dart';
import 'item.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:http/http.dart' as http;

class Addtoshoppingcartscreen extends StatefulWidget {
  final User user;
  final Item item;
  const Addtoshoppingcartscreen({Key key, this.item, this.user}) : super(key: key);

  @override
  _AddtocartState createState() => _AddtocartState();
}

class _AddtocartState extends State<Addtoshoppingcartscreen> {
  double screenHeight, screenWidth;
  int selectedQty = 0;

  @override
  void initState() {
    super.initState();
    selectedQty = int.parse(widget.item.itemquantity) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    var itemquantity =
        Iterable<int>.generate(int.parse(widget.item.itemquantity) + 1)
            .toList();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Add To Cart'),
              backgroundColor: Colors.black87,
              centerTitle: true,
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ItemdetailsscreenState(),
                          ));
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
              ],
            ),
            body: Container(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: screenHeight / 3,
                              width: screenWidth / 0.1,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://triold.com/tgadget/images/itempictures/${widget.item.itempicture}.png",
                                fit: BoxFit.contain,
                                placeholder: (context, url) =>
                                    new CircularProgressIndicator(),
                                errorWidget: (context, url, error) => new Icon(
                                  Icons.broken_image,
                                  size: screenWidth / 2,
                                ),
                              )),
                          SizedBox(height: 10),
                          Text(
                            "Product Name:  " + widget.item.itemname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Row(
                            children: [
                              Text("Plese Select Quantity  : "),
                              SizedBox(width: 10),
                              NumberPicker.integer(
                                decoration: BoxDecoration(
                                  border: new Border(
                                    top: new BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.black26,
                                    ),
                                    bottom: new BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                                initialValue: selectedQty,
                                minValue: 1,
                                maxValue: itemquantity.length - 1,
                                step: 1,
                                zeroPad: false,
                                onChanged: (value) =>
                                    setState(() => selectedQty = value),
                              ),
                            ],
                          ),                                           
                          Text(
                            "Price RM: " +
                                (selectedQty *
                                        double.parse(widget.item.itemprice))
                                    .toStringAsFixed(2),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            minWidth: 300,
                            height: 50,
                            child: Text('Add/Update Cart'),
                            color: Colors.black,
                            textColor: Colors.white,
                            elevation: 15,
                            onPressed: _addtocart,
                          ),
                        ],
                      ),
                    )))));
  }

  void _addtocart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Order " + widget.item.itemname + "?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Quantity " + selectedQty.toString(),
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
                Navigator.of(context).pop();
                _orderproduct();
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

  void _orderproduct() {
    http.post("http://triold.com/tgadget/php/insert_shoppingcart.php", body: {
      "email": widget.user.email,
      "itemid": widget.item.itemid,
      "itemquantity": selectedQty.toString(),
      "sellerid": widget.item.sellerid
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        Navigator.pop(context);
      } else {
        Toast.show(
          res.body,
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
