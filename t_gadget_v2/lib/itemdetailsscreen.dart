import 'package:flutter/material.dart';
import 'package:t_gadget_v2/addtoshoppingcartscreen.dart';
import 'package:t_gadget_v2/item.dart';
import 'package:t_gadget_v2/mainscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:t_gadget_v2/user.dart';

class ItemdetailsscreenState extends StatefulWidget {
  final Item item;
  final User user;

  const ItemdetailsscreenState({Key key, this.item, this.user})
      : super(key: key);
  @override
  __ItemdetailsscreenStateState createState() =>
      __ItemdetailsscreenStateState();
}

class __ItemdetailsscreenStateState extends State<ItemdetailsscreenState> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.item.itemname),
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
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_arrow,
          backgroundColor: Colors.black87,
          children: [
            SpeedDialChild(
                child: Icon(Icons.shopping_cart_sharp),
                label: "Add To Cart",
                backgroundColor: Colors.black87,
                labelBackgroundColor: Colors.white,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Addtoshoppingcartscreen(
                                item: widget.item,
                                user: widget.user,
                              )));
                }),
          ],
        ),
        body: Container(
            child: Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  height: screenHeight / 2.5,
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
              Container(
                  child: Table(
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Item Description',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                    TableCell(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(widget.item.itemdescription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ))),
                    )
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Item Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))),
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(widget.item.itemname,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Item Price',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))),
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text("RM" + widget.item.itemprice,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Item Type',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))),
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(widget.item.itemtype,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Item Status',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))),
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(widget.item.itemstatus,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Shipped From',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))),
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(widget.item.itemlocation,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Seller Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                    TableCell(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(widget.item.sellerid,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ))),
                    )
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Item Quantity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))),
                    TableCell(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(widget.item.itemquantity,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )))),
                  ]),
                ],
              )),
              SizedBox(height: 10),
            ]),
          ),
        )),
      ),
    );
  }
}
