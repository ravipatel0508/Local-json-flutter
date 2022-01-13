import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JSON Example",
      home: OnlineJSON(),
    );
  }
}

class Data {
  final String stateName;
  final int activeCases;
  final int newCases;
  final int recovered;
  final int deaths;
  final int totalCases;

  Data(
      {required this.stateName,
      required this.activeCases,
      required this.newCases,
      required this.recovered,
      required this.deaths,
      required this.totalCases});

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      stateName: json['region'],
      activeCases: json['activeCases'],
      newCases: json['newInfected'],
      recovered: json['recovered'],
      deaths: json['deceased'],
      totalCases: json['totalInfected'],
    );
  }
}

class OnlineJSON extends StatefulWidget {
  const OnlineJSON({Key? key}) : super(key: key);

  @override
  _OnlineJSONState createState() => _OnlineJSONState();
}

class _OnlineJSONState extends State<OnlineJSON> {
  final String uri =
      "https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true";
  late Future<Data> futureData;
  bool isData = false;
  var xyz;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<Data> fetchData() async {
    final response =
        await http.get(Uri.parse(uri), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        isData = true;
        xyz = Data.fromJson(jsonDecode(response.body)['regionData']);
      });

      print(Data.fromJson(jsonDecode(response.body)['regionData'][0]));

      return Data.fromJson(jsonDecode(response.body)['regionData'][1]);
    } else {
      throw Exception('Failed to load JSON');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('${xyz}');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Text('${xyz}');
          },
        ),
      ),
    );
  }
}
