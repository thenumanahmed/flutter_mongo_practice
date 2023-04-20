import 'package:flutter/material.dart';
import 'package:mongo_practice/dbhelper/mongodb.dart';
import 'package:mongo_practice/insert.dart';

import 'dbhelper/mongodbModel.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({super.key});

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return displayCard(
                          MongoDbModel.fromJson(snapshot.data[index]));
                    },
                  );
                } else {
                  return Center(
                    child: Text('No Data Found'),
                  );
                }
              }
            }),
      ),
    );
  }

  // Widget cardData(){
  //   return Card(
  //     child: Column(children: [

  //     ]),
  //   )
  // }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.id.$oid),
                const SizedBox(height: 5),
                Text(data.firstname),
                const SizedBox(height: 5),
                Text(data.lastname),
                const SizedBox(height: 5),
                Text(data.address),
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const MongoDbInsert();
                              },
                              settings: RouteSettings(arguments: data)))
                      .then((value) {
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
