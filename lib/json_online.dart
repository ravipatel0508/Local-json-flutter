import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:json_example/service/json_data.dart';

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

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<Data> fetchData() async {
    final response = await http.get(Uri.parse(uri), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        isData = true;
      });
      log(Data.fromJson(jsonDecode(response.body)['regionData'][0]).toString());
      return Data.fromJson(jsonDecode(response.body)['regionData'][1]);

    } else {
      throw Exception('Failed to load JSON');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isData
        ? FutureBuilder<Data>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.stateName.length,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.stateName),
                                          Text("${snapshot.data!.newCases}"),
                                          Text("${snapshot.data!.recovered}"),
                                          Text("${snapshot.data!.deaths}"),
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
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            })
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
