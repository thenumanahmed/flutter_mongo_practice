import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongo_practice/dbhelper/mongodb.dart';
import 'package:mongo_practice/dbhelper/mongodbModel.dart';
import 'package:mongo_practice/display.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var addressController = TextEditingController();

  var _checkInsertUpdate = "Insert";

  @override
  Widget build(BuildContext context) {
    // MongoDbModel data =
    //     ModalRoute.of(context)!.settings.arguments as MongoDbModel;

    // if (data != Null) {
    //   fNameController.text = data.firstname;
    //   lNameController.text = data.lastname;
    //   addressController.text = data.address;
    //   _checkInsertUpdate = 'Update';
    // }
    return Scaffold(
        floatingActionButton: TextButton(
          child: const Text('View Data'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const MongoDbDisplay();
                },
              ),
            );
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Text(
                    _checkInsertUpdate,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: fNameController,
                    decoration: const InputDecoration(labelText: "First Name"),
                  ),
                  TextField(
                    controller: lNameController,
                    decoration: const InputDecoration(labelText: "Last Name"),
                  ),
                  TextField(
                    minLines: 3,
                    maxLines: 5,
                    controller: addressController,
                    decoration: const InputDecoration(labelText: "Address"),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            _fakeData();
                          },
                          child: const Text('Generate Data')),
                      ElevatedButton(
                          onPressed: () {
                            if (_checkInsertUpdate == 'Update') {
                              // _updateData(data.id, fNameController.text,
                              //     lNameController.text, addressController.text);
                            } else {
                              _insertData(fNameController.text,
                                  lNameController.text, addressController.text);
                            }
                          },
                          child: Text(_checkInsertUpdate)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _updateData(
      var id, String fName, String lName, String address) async {
    final updateData = MongoDbModel(
        id: id, firstname: fName, lastname: lName, address: address);
    // print('debug call update');
    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
    // print('debug after call upadte');
  }

  Future<void> _insertData(String fName, String lName, String address) async {
    var _id = M.ObjectId(); // storing unique id
    final data = MongoDbModel(
        id: _id, firstname: fName, lastname: lName, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Data Inserted ID${_id.$oid}')));
    _clearAll();
  }

  void _clearAll() {
    fNameController.text = "";
    lNameController.text = "";
    addressController.text = "";
  }

  void _fakeData() {
    fNameController.text = faker.person.firstName();
    lNameController.text = faker.person.lastName();
    addressController.text =
        "${faker.address.streetName()}\n${faker.address.streetAddress()}";
  }
}
