import 'package:flutter/material.dart';
import 'package:flutter_mongo/dbHelper/mongodbconnected.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MongoLines extends StatefulWidget {
  const MongoLines({super.key});

  @override
  State<MongoLines> createState() => _MongoLinesState();
}

class _MongoLinesState extends State<MongoLines> {
  List<Map<String, dynamic>> result2 = [];
  List<Map<String, dynamic>> result5 = [];
  List<Map<String, dynamic>> result3 = [];
  List<Map<String, dynamic>> result4 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch Data Graph Form"),
        backgroundColor: Colors.pink[100],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> result1 = snapshot.data;

                void initState() {
                  super.initState();
                  MongoDatabase.getData();
                  result2 = result1;
                  result5 = result2;
                }

                void _runFilter1(String enteredKeyword) {
                  if (enteredKeyword.isEmpty) {
                    result3 = result1;
                  } else {
                    result3 = result1
                        .where((user) => user["EngName"]
                            .toLowerCase()
                            .contains(enteredKeyword.toLowerCase()))
                        .toList();
                  }
                  setState(() {
                    result2 = result3;
                  });
                }

                void _runFilter2(String enteredKeyword) {
                  if (enteredKeyword.isEmpty) {
                    result4 = result2;
                  } else {
                    result4 = result2
                        .where((user) => user["Year"]
                            .toString()
                            .toLowerCase()
                            .contains(enteredKeyword.toLowerCase()))
                        .toList();
                  }
                  setState(() {
                    result5 = result4;
                  });
                }

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButton(
                        hint: Text("Select City"),
                        isExpanded: true,
                        icon: Icon(Icons.playlist_add_check_circle_sharp),
                        items:
                            result1.map((e) => e["EngName"]).toSet().map((e) {
                          return DropdownMenuItem(
                              value: e.toString(), child: Text(e.toString()));
                        }).toList(),
                        onChanged: (value) => _runFilter1(value!),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButton(
                        hint: Text("Select Year"),
                        isExpanded: true,
                        icon: Icon(Icons.playlist_add_check_circle_sharp),
                        items: result1.map((e) => e["Year"]).toSet().map((e) {
                          return DropdownMenuItem(
                              value: e.toString(), child: Text(e.toString()));
                        }).toList(),
                        onChanged: (value) => _runFilter2(value!),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(
                                text: 'Average Amount of Rainfall per Area'),
                            legend: Legend(
                              isVisible: true,
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries<Map<String, dynamic>, String>>[
                              LineSeries<Map<String, dynamic>, String>(
                                dataSource: result5,
                                xValueMapper:
                                    (Map<String, dynamic> monthai, _) =>
                                        monthai["MonThai"],
                                yValueMapper:
                                    (Map<String, dynamic> avgrain, _) =>
                                        avgrain["AvgRain"],
                                name: "City 1",
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                              ),
                            ]),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("Not Found"),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
