import 'package:flutter/material.dart';
import 'package:mongo_practice/dbhelper/mongodbModel.dart';

import 'dbhelper/mongodb.dart';

class QueryDatabase extends StatefulWidget {
  const QueryDatabase({super.key});

  @override
  State<QueryDatabase> createState() => _QueryDatabaseState();
}

class _QueryDatabaseState extends State<QueryDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:
              // Center(child: Text('Query Data')),
              FutureBuilder(
        future: MongoDatabase.getQueryData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return Center(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return displayData(
                            MongoDbModel.fromJson(snapshot.data[index]));
                      }));
            } else {
              return const Center(
                child: Text('Data not Found'),
              );
            }
          }
        },
      )),
    );
  }

  Widget displayData(MongoDbModel data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.firstname} ${data.lastname}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                data.address,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
