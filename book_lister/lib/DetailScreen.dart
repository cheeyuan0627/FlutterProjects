import 'package:book_lister/Book.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'Book.dart';

class DetailScreen extends StatefulWidget {
  final Book books;
  const DetailScreen({Key key, this.books}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenHeight, screenWidth;

  String titlecenter = "Please wait, loading Books...";

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.books.booktitle),
          centerTitle: true,
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
                        "http://slumberjer.com/bookdepo/bookcover/${widget.books.cover}.jpg",
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(
                      Icons.broken_image,
                      size: screenWidth / 2,
                    ),
                  )),
              SizedBox(height: 10),
              // Row(children: [
              Text(
                'Book ID: ' + widget.books.bookid,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Book Title: ' + widget.books.booktitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Book Author: ' + widget.books.author,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Book Price: ' + widget.books.price,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Book Description: ' + widget.books.description,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Book Rating: ' + widget.books.rating,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Book Publisher: ' + widget.books.publisher,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Book ISBN: ' + widget.books.isbn,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        )));
  }

  Future<void> _loadBooks() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    await pr.show();
    http.post("http://slumberjer.com/bookdepo/php/load_books.php", body: {
      "bookid": widget.books.bookid,
    }).then((res) {
      print(res.body);
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }
}
