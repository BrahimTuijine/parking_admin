import 'package:cloud_firestore/cloud_firestore.dart';

class UsersStore {
  static Stream<List<Map<String, dynamic>>> getUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  static Future<void> addUser(Map<String, String> user) async {
    await FirebaseFirestore.instance.collection("users").add(user);
  }
}
