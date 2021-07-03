import 'dart:convert';

import 'package:flutter/material.dart';

class LocalJSON extends StatefulWidget {
  const LocalJSON({Key? key}) : super(key: key);

  @override
  _LocalJSONState createState() => _LocalJSONState();
}

class _LocalJSONState extends State<LocalJSON> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('load_json/person.json'),
        builder: (context, snapshot) {
          var mydata = jsonDecode(snapshot.data.toString());

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Name: " + mydata[index]['name']),
                      Text("Age: " + mydata[index]['age']),
                      Text("Gender: " + mydata[index]['gender']),
                    ],
                  ),
                ),
              );
            },
            itemCount: mydata == null ? 0 : mydata.length,
          );
        },
      ),
    );
  }
}
