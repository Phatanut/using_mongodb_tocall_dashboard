import 'package:flutter/material.dart';
import 'package:flutter_mongo/barchartmongo/mongobarcharts.dart';
import 'package:flutter_mongo/dbHelper/mongodbconnected.dart';
import 'package:flutter_mongo/linechartmongo/mongolinecharts.dart';
import 'package:flutter_mongo/listmongo/mongolists.dart';

import 'countrymaps/countrythailands.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
            children: [MongoSearch(), MongoLines(), MongoBars(), CountryMap()]),
        backgroundColor: Colors.blue[100],
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.search),
            ),
            Tab(
              icon: Icon(Icons.line_axis),
            ),
            Tab(
              icon: Icon(Icons.bar_chart),
            ),
            Tab(
              icon: Icon(Icons.map),
            )
          ],
        ),
      ),
    );
  }
}
