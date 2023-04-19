import 'package:flutter/material.dart';
import 'package:mongo_practice/dbhelper/mongodbModel.dart';

import 'dbhelper/mongodb.dart';

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({super.key});

  @override
  State<MongoDbDelete> createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: MongoDatabase.getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              // display data
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return _dataCard(
                        MongoDbModel.fromJson(snapshot.data[index]));
                  });
            } else {
              return const Center(
                child: Text('No Data Found'),
              );
            }
          }
        },
      ),
    ));
  }

  Widget _dataCard(MongoDbModel data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text(data.firstname),
                  const SizedBox(height: 5),
                  _text(data.lastname),
                  const SizedBox(height: 5),
                  _text(data.address),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    // print(data.id);
                    await MongoDatabase.delete(data);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Data Deleted ID${data.id.$oid}')));
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(String value) {
    return Text(
      value,
      style: const TextStyle(fontSize: 20),
    );
  }
}
