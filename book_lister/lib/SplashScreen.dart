import 'package:flutter/material.dart';
import 'MainScreen.dart';

void main() => runApp(SplashScreen());

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Lister',
      home: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 10),
                ProcessIndicator(),
                SizedBox(height: 10),
                Text(
                  'Book Lister: For Everyone Who Loves Books',
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProcessIndicator extends StatefulWidget {
  ProcessIndicator({Key key}) : super(key: key);

  @override
  _ProcessIndicatorState createState() => _ProcessIndicatorState();
}

class _ProcessIndicatorState extends State<ProcessIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.99) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainScreen()));
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: animation.value,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    );
  }
}
