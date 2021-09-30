import 'package:flutter/cupertino.dart';
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
                  if (c[index]['direction'] == 2) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)),
                              height: size.height * 0.2,
                              width: size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  c[index]['type']==1?Row( mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    Icon(Icons.upgrade_rounded),Text('You Paid'),
                                  ],):Row( mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    Icon(Icons.file_download),Text('You Collected'),
                                  ],),
                                  Text('₹ ' + c[index]['amount'].toString(),
                                      style: TextStyle(
                                          fontSize: size.height * 0.05,
                                          fontWeight: FontWeight.bold)),
                                  Text('Transaction Id: ' +
                                      c[index]['amount'].toString()),


                                ],
                              ),
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
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)),
                              height: size.height * 0.2,
                              width: size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  c[index]['type']==1?Row( mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    Icon(Icons.upgrade_rounded),Text('You Paid'),
                                  ],):Row( mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    Icon(Icons.file_download),Text('You Collected'+c[index]['type'].toString()),
                                  ],),
                                  Text('₹ ' + c[index]['amount'].toString(),
                                      style: TextStyle(
                                          fontSize: size.height * 0.05,
                                          fontWeight: FontWeight.bold)),
                                  Text('Transaction Id: ' +
                                      c[index]['amount'].toString()),
                                ],
                              ),
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
