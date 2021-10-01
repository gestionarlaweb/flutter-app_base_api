import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // Para jsonDecode

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Equips de futbol'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? _dataList;
  void _incrementCounter() async {
    final data =
        await http.get(Uri.parse('https://api.npoint.io/8becd3a84a59e32bc124'));
    _dataList = jsonDecode(data.body);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
    // WidgetsBinding.instance!.addPostFrameCallback((_) { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _dataList != null
            ? PageView.builder(
                itemCount: _dataList?.length,
                itemBuilder: (context, index) {
                  final item = _dataList?[index];
                  final _image = item['image'];
                  final _city = item['city'];
                  final _name = item['name'];
                  final _description = item['description'];
                  final equipo = Equipo(
                      name: _name,
                      city: _city,
                      image: _image,
                      description: _description);
                  // Mostrar datos
                  return MyItems(equipo: equipo);
                },
              )
            : CircularProgressIndicator(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class MyItems extends StatelessWidget {
  final Equipo equipo;
  const MyItems({Key? key, required this.equipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(equipo.image),
          Text(
            equipo.name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(equipo.city),
          Text(equipo.description,
              overflow: TextOverflow.ellipsis, maxLines: 4),
        ],
      ),
    );
  }
}

class Equipo {
  final String name;
  final String city;
  final String description;
  final String image;

  Equipo(
      {required this.name,
      required this.city,
      required this.description,
      required this.image});
}
