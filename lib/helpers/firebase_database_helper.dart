import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseHelper {
  final FirebaseDatabase database;
  FirebaseDatabaseHelper({required this.database});

  Future<DataSnapshot> getObject(String reference) async {
    DatabaseReference ref = database.ref(reference);
    DataSnapshot dataSnapshot = await ref.get();
    return dataSnapshot;
  }

  Future<void> updateValue(String reference, String key, dynamic value) async {
    await database.ref(reference).update({
      key: value
    });
    return;
  }
}