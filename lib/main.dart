
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:onebanc/Home.dart';

Future main() async {
  runApp(Splash());
}

class Splash extends StatelessWidget {
  Splash({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  Screen({Key? key}) : super(key: key);
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late List c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      child: Text('wait'),
    ));
  }
}
