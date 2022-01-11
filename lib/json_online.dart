import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class OnlineJSON extends StatefulWidget {
  const OnlineJSON({Key? key}) : super(key: key);

  @override
  _OnlineJSONState createState() => _OnlineJSONState();
}

class _OnlineJSONState extends State<OnlineJSON> {
  final String url = "https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true";
  late List data;
  bool isData = false;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    setState(() {
      data = jsonDecode(response.body)['regionData'];
      isData = true;
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return isData
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("State: "),
                                  Text("newInfected: "),
                                  Text("Total recovered: "),
                                  Text("Total death: "),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index]['region']),
                                  Text(data[index]['newInfected'].toString()),
                                  Text(data[index]['newRecovered'].toString()),
                                  Text(data[index]['deceased'].toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            })
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
