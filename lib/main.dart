import 'package:flutter/material.dart';
import 'package:mongo_practice/dbhelper/mongodb.dart';
import 'package:mongo_practice/delete.dart';
import 'package:mongo_practice/query.dart';
import 'package:mongo_practice/update.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // calling db connect inside main when app starts
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: const QueryDatabase(),
        floatingActionButton: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
