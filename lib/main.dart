import 'package:flutter/material.dart';
import 'package:json_example/drawer_example.dart';
import 'package:json_example/json_online.dart';
import 'package:json_example/local_json.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JSON Example",
      home: HomePage(),
      routes: {
        "newPage" : (BuildContext context) => DrawerExample()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItem = 0;

  List _widgetOption = [OnlineJSON(),LocalJSON()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON"),
      ),
      body: _widgetOption[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.wifi_tethering),
              label: 'Online JSON',
              backgroundColor: Colors.amberAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Local JSON',
              backgroundColor: Colors.white70),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedItem,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Ravi"),
                accountEmail: Text("Ravi@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Text("R"),
              ),
              otherAccountsPictures: [CircleAvatar(
                child: Text("P"),
              )],
            ),
            ListTile(
              title: Text("Page1"),
              trailing: Icon(Icons.ac_unit),
              onTap: (){
                Navigator.of(context).pushNamed("newPage");
              }
            ),
            Divider(indent: 10,endIndent: 10,thickness: 2,),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.backspace_outlined),
              onTap: ()=> Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
