import 'package:flutter/material.dart';
import 'package:json_example/json_online.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JSON Example",
      home: Scaffold(
        appBar: AppBar(
          title: Text("JSON"),
        ),
        body: OnlineJSON(),
      ),
    );
  }
}