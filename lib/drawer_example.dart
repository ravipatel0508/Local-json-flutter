import 'package:flutter/material.dart';

class DrawerExample extends StatelessWidget {
  const DrawerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer Example"),
      ),
      body: Container(
        child: Center(child: Text("data")),
      ),
    );
  }
}
