# flutter_native_contact_picker

With this plugin a Flutter app can ask its user to select a contact or contacts from his/her address book. The information associated with the contacts is returned to the app.

This plugin uses the operating system's native UI for selecting contacts and does not require any special permissions from the user.

Currently, the plugin only supports picking phone numbers. However, it should be easy to extend the plugin to request other properties from a contact (e.g. addresses) or to obtain the entire record of a contact (PRs are welcome).

## Features

- [x] iOS Support

  - Select single contact
  - Select multiple contacts

- [x] Android Support
  - Select single contact

### Example

```dart
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

  @override
  void initState() {
    super.initState();
  }

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
              MaterialButton(
                color: Colors.blue,
                child: const Text("Single"),
                onPressed: () async {
                  Contact? contact = await _contactPicker.selectContact();
                  setState(() {
                    _contacts = contact == null ? null : [contact];
                  });
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: const Text("Multiple"),
                onPressed: () async {
                  final contacts = await _contactPicker.selectContacts();
                  setState(() {
                    _contacts = contacts;
                  });
                },
              ),
              if (_contacts != null)
                ..._contacts!.map(
                  (e) => Text(e.toString()),
                )
            ],
          ),
        ),
      ),
    );
  }
}

```