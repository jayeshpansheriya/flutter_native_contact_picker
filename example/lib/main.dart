import 'package:flutter/material.dart';
import 'package:flutter_contact_picker/flutter_native_contact_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  Contact _contact;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Contact Picker Example App'),
        ),
        body: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new MaterialButton(
                color: Colors.blue,
                child: new Text("CLICK ME"),
                onPressed: () async {
                  Contact contact = await _contactPicker.selectContact();
                  setState(() {
                    _contact = contact;
                  });
                },
              ),
              new Text(
                _contact == null ? 'No contact selected.' : _contact.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}