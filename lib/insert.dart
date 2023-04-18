import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            const Text(
              'Insert Data',
              style: TextStyle(fontSize: 22),
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
                      _insertData(fNameController.text, lNameController.text,
                          addressController.text);
                    },
                    child: const Text('Insert Data')),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> _insertData(String fName, String lName, String address) async {}

  void _fakeData() {
    fNameController.text = faker.person.firstName();
    lNameController.text = faker.person.lastName();
    addressController.text =
        "${faker.address.streetName()}\n${faker.address.streetAddress()}";
  }
}
