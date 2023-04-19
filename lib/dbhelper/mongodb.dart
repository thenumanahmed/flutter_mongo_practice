import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_practice/dbhelper/constant.dart';
import 'package:mongo_practice/dbhelper/mongodbModel.dart';

class MongoDatabase {
  static Db? db;
  static DbCollection? tracksCollection;
  static DbCollection? userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db!.open();
    print(inspect(db));
    userCollection = db!.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection!.find().toList();
    return arrData;
  }

  static Future<void> update(MongoDbModel data) async {
    // print('debug: in updatess');
    // var result = await userCollection!.findOne({"_id": data.id});
    // print('debug: in update');
    // // var newdoc = result;
    // result!['firstName'] = data.firstname;
    // result['lastName'] = data.lastname;
    // result['address'] = data.address;
    // //error:
    // var response = await userCollection!.updateOne({'_id': data.id}, result);
    // print('debug: ${response.document}');
    // print(response);
    // inspect(response);

    // Define the filter to identify the document you want to update
    final filter = where.eq('_id', data.id);

    // Perform the update operation
    final result = await userCollection!.replaceOne(filter, data.toJson());
    // final result = await userCollection!.updateOne(filter, data);

    print('Updated ${result.document} document');
    print('Updated ${filter} document');
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection!.insertOne(data.toJson());
      if (result.isSuccess) {
        return 'Data Inserted';
      } else {
        return 'Something Went Wrong while inserting data';
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
