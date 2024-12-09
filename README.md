# flutter_native_contact_picker

With this plugin a Flutter app can ask its user to select a contact or contacts from their address book, with the option to select specific phone numbers. The information associated with the contacts is returned to the app.

This plugin uses the operating system's native UI for selecting contacts and does not require any special permissions from the user, even on Android.

## Features

- [x] iOS Support
  - Select single contact
  - Select multiple contacts
  - Select specific phone number from a contact
  - Returns all phone numbers for selected contacts

- [x] Android Support
  - Select single contact
  - Select specific phone number from a contact
  - No READ_CONTACTS permission required

## Usage

### Basic Contact Selection

```dart
// Create an instance of the picker
final FlutterNativeContactPicker _contactPicker = FlutterNativeContactPicker();

// Select a single contact
Contact? contact = await _contactPicker.selectContact();
print(contact?.fullName);
print(contact?.phoneNumbers);

// Select multiple contacts (iOS only)
List<Contact>? contacts = await _contactPicker.selectContacts();
for (var contact in contacts ?? []) {
  print(contact.fullName);
  print(contact.phoneNumbers);
}
```

### Phone Number Selection

```dart
// Select a specific phone number from a contact
Contact? contact = await _contactPicker.selectPhoneNumber();
print(contact?.fullName);
print(contact?.selectedPhoneNumber); // The specifically selected number
print(contact?.phoneNumbers); // All available numbers (iOS only)
```

## Contact Model

The `Contact` class provides the following properties:

```dart
class Contact {
  final String? fullName;           // Contact's full name
  final List<String>? phoneNumbers; // All phone numbers (iOS: all numbers, Android: selected number only)
  final String? selectedPhoneNumber; // The specifically selected phone number when using selectPhoneNumber()
}
```

## Platform Differences

### iOS

- Supports selecting multiple contacts
- Returns all phone numbers associated with a contact
- When using `selectPhoneNumber()`, returns both the selected number and all available numbers
- Uses native CNContactPickerViewController

### Android

- Single contact selection only
- When using `selectPhoneNumber()`, returns only the selected phone number
- No READ_CONTACTS permission required
- Uses native contact picker intent

## Example

See the [example](example) directory for a complete sample app demonstrating all features.

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
  final FlutterNativeContactPicker _contactPicker = FlutterNativeContactPicker();
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
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text("Select Contact"),
                onPressed: () async {
                  Contact? contact = await _contactPicker.selectContact();
                  setState(() {
                    _contacts = contact == null ? null : [contact];
                    _selectedPhoneNumber = null;
                  });
                },
              ),
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
              if (_contacts != null) ...[
                ..._contacts!.map(
                  (contact) => Column(
                    children: [
                      Text(contact.fullName ?? 'No name'),
                      if (_selectedPhoneNumber != null)
                        Text('Selected: $_selectedPhoneNumber'),
                      ...?contact.phoneNumbers?.map((number) => Text(number)),
                    ],
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
```
