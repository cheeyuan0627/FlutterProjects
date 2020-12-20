import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:book_lister/Book.dart';
import 'DetailScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookList;
  double screenHeight, screenWidth;
  String titlecenter = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('List of Books'),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: Column(children: [
            bookList == null
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
                    childAspectRatio: (screenWidth / screenHeight) / 0.75,
                    children: List.generate(bookList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(5),
                          child: Card(
                              child: InkWell(
                            onTap: () => _loadBookDetail(index),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                          height: screenHeight / 4.5,
                                          width: screenWidth / 2,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "http://slumberjer.com/bookdepo/bookcover/${bookList[index]['cover']}.jpg",
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
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(
                                              children: [
                                                Text(bookList[index]['rating'],
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                Icon(Icons.star,
                                                    color: Colors.yellow),
                                              ],
                                            )),
                                        bottom: 110,
                                        right: 125,
                                      )
                                    ],
                                  ),
                                  Text(
                                    bookList[index]['booktitle'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    bookList[index]['author'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "RM " + bookList[index]['price'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Rating: " + bookList[index]['rating'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )));
                    }),
                  ))
          ])),
    );
  }

  void _loadBook() {
    http.post("http://slumberjer.com/bookdepo/php/load_books.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "no data") {
        bookList = null;
        setState(() {
          titlecenter = "No Book Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          bookList = jsondata["books"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadBookDetail(int index) {
    Book book = new Book(
        bookid: bookList[index]['bookid'],
        booktitle: bookList[index]['booktitle'],
        author: bookList[index]['author'],
        price: bookList[index]['price'],
        description: bookList[index]['description'],
        rating: bookList[index]['rating'],
        publisher: bookList[index]['publisher'],
        isbn: bookList[index]['isbn'],
        cover: bookList[index]['cover']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailScreen(books: book)));
  }
}
