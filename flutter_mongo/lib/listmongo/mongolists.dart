import 'package:flutter/material.dart';
import 'package:flutter_mongo/dbHelper/mongodbconnected.dart';
import 'package:flutter_mongo/rainfallthaimongo/rainfallthaimongo.dart';

class MongoSearch extends StatefulWidget {
  const MongoSearch({super.key});

  @override
  State<MongoSearch> createState() => _MongoSearchState();
}

class _MongoSearchState extends State<MongoSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PROVINCE LIST"),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  var totalData = snapshot.data.length;
                  print("Total Data" + totalData.toString());
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return displayCard(
                            MongoDbModel.fromJson(snapshot.data[index]));
                      });
                } else {
                  return Center(
                    child: Text("Not Found"),
                  );
                }
              }
            }),
      )),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text("Province : ${data.engName}"),
          SizedBox(
            height: 10,
          ),
          Text("Month : ${data.monThai}"),
          SizedBox(
            height: 10,
          ),
          Text("Year : ${data.year}"),
          SizedBox(
            height: 10,
          ),
          Text("MinRain : ${data.minRain}"),
          SizedBox(
            height: 10,
          ),
          Text("MaxRain : ${data.maxRain}"),
          SizedBox(
            height: 10,
          ),
          Text("AvgRain : ${data.avgRain}"),
        ],
      ),
    ));
  }
}
