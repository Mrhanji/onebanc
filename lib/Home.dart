import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List c;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Hitapi();
  }

  Hitapi() async {
    var url = Uri.parse(
        "https://dev.onebanc.ai/assignment.asmx/GetTransactionHistory?userId=1&recipientId=2");

    var data = await http.get(url).then((value) {
      setState(() {
        var b = jsonDecode(value.body);
        c = b['transactions'];
      });
      //print(c['transactions']);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Onebanc'),
        ),
        body: c != null
            ? ListView.builder(
                itemCount: c.length,
                itemBuilder: (context, index) {
                  var dir = false;
                  if (c[index]['direction'] == 1) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.green,
                              height: size.height*0.1,
                              width: size.width*0.3,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: Colors.red,
                             height: size.height*0.1,
                              width: size.width*0.3,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        )
                      ],
                    );
                  }
                })
            : Text('do'),
      ),
    );
  }
}
