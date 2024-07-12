import 'dart:convert';

List<MongoDbModel> mongoDbModelFromJson(String str) => List<MongoDbModel>.from(
    json.decode(str).map((x) => MongoDbModel.fromJson(x)));

String mongoDbModelToJson(List<MongoDbModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MongoDbModel {
  String? engName;
  double? minRain;
  double? maxRain;
  double? avgRain;
  int? year;
  String? monThai;

  MongoDbModel({
    this.engName,
    this.minRain,
    this.maxRain,
    this.avgRain,
    this.year,
    this.monThai,
  });

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        engName: json["EngName"],
        minRain: json["MinRain"]?.toDouble(),
        maxRain: json["MaxRain"]?.toDouble(),
        avgRain: json["AvgRain"]?.toDouble(),
        year: json["Year"],
        monThai: json["MonThai"],
      );

  Map<String, dynamic> toJson() => {
        "EngName": engName,
        "MinRain": minRain,
        "MaxRain": maxRain,
        "AvgRain": avgRain,
        "Year": year,
        "MonThai": monThai,
      };
}

enum MonThai { APR, AUG, FEB, JAN, JUL, JUN, MAR, MAY, SEP }

final monThaiValues = EnumValues({
  "Apr ": MonThai.APR,
  "Aug ": MonThai.AUG,
  "Feb ": MonThai.FEB,
  "Jan": MonThai.JAN,
  "Jul ": MonThai.JUL,
  "Jun ": MonThai.JUN,
  "Mar ": MonThai.MAR,
  "May ": MonThai.MAY,
  "Sep": MonThai.SEP
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
