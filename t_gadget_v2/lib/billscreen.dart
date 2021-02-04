import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'user.dart';

class BillScreen extends StatefulWidget {
  final User user;
  final String val;
  final String add;

  const BillScreen({Key key, this.user, this.val, this.add}) : super(key: key);

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bill Info'),
          backgroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl: 'http://triold.com/tgadget/php/payment.php?email=' +
                    widget.user.email +
                    '&mobile=' +
                    widget.user.phone +
                    '&name=' +
                    widget.user.name +
                    '&amount=' +
                    widget.val,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            )
          ],
        ));
  }
}
