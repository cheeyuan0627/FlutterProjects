import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:t_gadget_v2/user.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'mainscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Addproduct extends StatefulWidget {
  final User user;
  const Addproduct({Key key, this.user}) : super(key: key);
  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  TextEditingController _itemnamecontroller = TextEditingController();
  TextEditingController _itempricecontroller = TextEditingController();
  TextEditingController _itemtypecontroller = TextEditingController();
  TextEditingController _itemstatuscontroller = TextEditingController();
  TextEditingController _itemlocationcontroller = TextEditingController();
  TextEditingController _itemdescriptioncontroller = TextEditingController();
  TextEditingController _itemquantitycontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _itemname = "";
  String _itemprice = "";
  String _itemdescription = "";
  String _itemquantity = "";
  double screenHeight, screenWidth;
  File _image;
  String pathAsset = 'assets/images/camera.png';

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
  String selectedLoc; //= "Johor";

  List<String> statusList = [
    "New",
    "SH",
  ];
  String selectedstatus; //= "New";

  List<String> typeList = [
    "Computer/Laptop",
    "Assesories",
    "Mouse",
    "Keyboard",
    "Monitor",
  ];
  String selectedtype; //= "Computer/Laptop";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Mainscreen( user: widget.user,),
                ));
          },
        ),
        centerTitle: true,
        title: Text('Add New Product'),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(height: 10,),
                GestureDetector(
                    onTap: () => {_onPictureSelection()},
                    child: Container(
                      height: screenHeight / 3.8,
                      width: screenWidth / 2.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image == null
                              ? AssetImage(pathAsset)
                              : FileImage(_image),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          width: 3.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _itemnamecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Product Name',
                        labelStyle: TextStyle(color: Colors.black, fontSize: 16,),
                        icon: Icon(Icons.label, color: Colors.black)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _itemname = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _itempricecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Product Price (RM)',
                        labelStyle: TextStyle(color: Colors.black, fontSize: 16,),
                        icon: Icon(
                          Icons.money,
                          color: Colors.black,
                        )),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Price';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _itemprice = value;
                    },
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
                      child: Icon(Icons.merge_type_sharp),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                      alignment: Alignment.centerLeft,
                      height: 40,
                      child: DropdownButton(
                        hint: Text(
                          'Please select the product type',
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
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
                      child: Icon(Icons.star_outline_sharp),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                      alignment: Alignment.centerLeft,
                      height: 40,
                      child: DropdownButton(
                        hint: Text(
                          'Please select the product status',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        value: selectedstatus,
                        onChanged: (newValue) {
                          setState(() {
                            selectedstatus = newValue;
                            print(selectedstatus);
                          });
                        },
                        items: statusList.map((selectedstatus) {
                          return DropdownMenuItem(
                            child: new Text(selectedstatus,
                                style: TextStyle(color: Colors.black)),
                            value: selectedstatus,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
                      child: Icon(Icons.location_city),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                      alignment: Alignment.centerLeft,
                      height: 40,
                      child: DropdownButton(
                        hint: Text(
                          'Please select your location',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        value: selectedLoc,
                        onChanged: (newValue) {
                          setState(() {
                            selectedLoc = newValue;
                            print(selectedLoc);
                          });
                        },
                        items: locList.map((selectedLoc) {
                          return DropdownMenuItem(
                            child: new Text(selectedLoc,
                                style: TextStyle(color: Colors.black)),
                            value: selectedLoc,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _itemdescriptioncontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Product Description',
                        labelStyle: TextStyle(color: Colors.black, fontSize: 16,),
                        icon: Icon(Icons.description, color: Colors.black)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Desciption';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _itemdescription = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _itemquantitycontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Product Quantity',
                        labelStyle: TextStyle(color: Colors.black,fontSize: 16,),
                        icon: Icon(Icons.format_list_numbered_sharp,
                            color: Colors.black)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Quantity';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _itemquantity = value;
                    },
                  ),
                ),
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
                    child: Text("Add Product"),
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onaddproduct() async {
    _itemname = _itemnamecontroller.text;
    _itemprice = _itempricecontroller.text;
    _itemdescription = _itemdescriptioncontroller.text;
    _itemquantity = _itemquantitycontroller.text;

    final dateTime = DateTime.now();
    String base64Image = base64Encode(_image.readAsBytesSync());

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Adding...");
    await pr.show();

    http.post("http://triold.com/tgadget/php/add_newproduct.php", body: {
      "itemname": _itemname,
      "itemprice": _itemprice,
      "itemtype": selectedtype,
      "itemstatus": selectedstatus,
      "itemlocation": selectedLoc,
      "itemdescription": _itemdescription,
      "itemquantity": _itemquantity,
      "encoded_string": base64Image,
      "itempicture": _itemquantity + "-${dateTime.microsecondsSinceEpoch}",
      "itemid": "-${dateTime.microsecondsSinceEpoch}" + _itemquantity,
      "sellerid": widget.user.name,
    }).then((res) {
      if (res.body == "success") {
        Toast.show("Process Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        setState(() {
          _itemnamecontroller.text = '';
          _itempricecontroller.text = '';
          _itemtypecontroller.text = '';
          _itemstatuscontroller.text = '';
          _itemlocationcontroller.text = '';
          _itemdescriptioncontroller.text = '';
          _itemquantitycontroller.text = '';
        });
      } else {
        Toast.show("Process Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  _showdialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Are u sure you want to add product?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pop(Addproduct());
                    _onaddproduct();
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pop(Addproduct());
                    Toast.show("Process Cancel", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                )
              ],
            ));
  }

  _onPictureSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              height: screenHeight / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('Take Picture',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        color: Colors.grey,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseCamera()},
                      )),
                      SizedBox(width: 10),
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('From Gallery',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        color: Colors.grey,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: () => {
                          Navigator.pop(context),
                          _chooseGallery(),
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _chooseCamera() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  void _chooseGallery() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Resize',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }
}
