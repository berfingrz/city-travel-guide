import 'package:flutter/material.dart';
import 'package:city_travel_guide/main.dart';

void main() {
  runApp(MaterialApp(home: MySplash()));
}

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/logo.png"), fit: BoxFit.cover)),
      ),
    );
  }
}
