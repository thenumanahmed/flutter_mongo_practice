import 'package:flutter/material.dart';
import 'package:mongo_practice/dbhelper/mongodb.dart';
import 'package:mongo_practice/dbhelper/mongodbModel.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({super.key});

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder(
              future: MongoDatabase.getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var totalData = snapshot.data.length;
                    // print('debug: total data $totalData');
                    return Flexible(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(
                                MongoDbModel.fromJson(snapshot.data[0]));
                          }),
                    );
                  } else {
                    return const Center(
                      child: Text('No Data Available'),
                    );
                  }
                }
              })
        ],
      )),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.id.$oid),
            const SizedBox(
              height: 5,
            ),
            Text(data.firstname),
            const SizedBox(
              height: 5,
            ),
            Text(data.lastname),
            const SizedBox(
              height: 5,
            ),
            Text(data.address),
          ],
        ),
      ),
    );
  }
}
