import 'package:firebase_crud/Model/data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'FIrebase',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child("Users");

  @override
  void initState() {

    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase CRUD"),
      ),
      body: Center()
    );
  }

  readData() async {

    FutureBuilder(
      future: _databaseReference.once(),
      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {

        if(snapshot.connectionState == ConnectionState.done) {

          if(snapshot.hasData && !snapshot.hasError) {

            Map<String, dynamic> values = snapshot.data.value;

            values.forEach((key, value) {

              Data data = Data.fromMap(key, value);

              print(data);
            });
          }
        }

        return null;
      },
    );
  }

  writeData(Data data) {

    _databaseReference.push().set((data.toMap())).then((_) {

      print("Data added!!!");

    }).catchError((error) {

      print(error);
    });
  }

  updateData(Data data) {

    _databaseReference.child(data.dataKey).set((data.toMap())).then((_) {

      print("Data updated!!!");

    }).catchError((error) {

      print(error);
    });
  }
}
