import 'package:flutter/material.dart';

import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  List<Contact>? _contacts;
  String? _selectedPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Contact Picker Example App'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Contact Selection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text("Single Contact"),
                    onPressed: () async {
                      Contact? contact = await _contactPicker.selectContact();
                      setState(() {
                        _contacts = contact == null ? null : [contact];
                        _selectedPhoneNumber = null;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text("Multiple Contacts"),
                    onPressed: () async {
                      final contacts = await _contactPicker.selectContacts();
                      setState(() {
                        _contacts = contacts;
                        _selectedPhoneNumber = null;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Phone Number Selection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text("Select Phone Number"),
                onPressed: () async {
                  Contact? contact = await _contactPicker.selectPhoneNumber();
                  setState(() {
                    _contacts = contact == null ? null : [contact];
                    _selectedPhoneNumber = contact?.selectedPhoneNumber;
                  });
                },
              ),
              const SizedBox(height: 24),
              if (_contacts != null) ...[
                const Text(
                  'Selected Contact(s):',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ..._contacts!.map(
                  (contact) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          contact.fullName ?? 'No name',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        if (_selectedPhoneNumber != null)
                          Text(
                            'Selected number: $_selectedPhoneNumber',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ...?contact.phoneNumbers?.map(
                          (number) => Text(
                            number,
                            style: TextStyle(
                              color: number == _selectedPhoneNumber
                                  ? Colors.green
                                  : Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
