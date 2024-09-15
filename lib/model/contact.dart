/// Represents a contact selected by the user.
class Contact {
  Contact({this.fullName, this.phoneNumbers});

  factory Contact.fromMap(Map<dynamic, dynamic> map) => Contact(
      fullName: map['fullName'],
      // phoneNumber: new PhoneNumber.fromMap(map['phoneNumber']));
      phoneNumbers: map['phoneNumbers'].cast<String>());

  /// The full name of the contact, e.g. "Jayesh Pansheriya".
  final String? fullName;

  /// The phone number of the contact.
  // final PhoneNumber phoneNumber;
  final List<String>? phoneNumbers;

  @override
  String toString() => '$fullName: $phoneNumbers';
}
