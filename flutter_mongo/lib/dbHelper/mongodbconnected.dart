import 'dart:developer';

import 'package:flutter_mongo/dbHelper/constantusers.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL); // link of my user in MongoDB Compass
    await db.open();
    inspect(db);
    userCollection =
        db.collection(USER_COLLECTION); // my collection name in database
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final users = await userCollection.find().toList();
    return users;
  }
}
