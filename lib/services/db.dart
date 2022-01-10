import 'package:classroom/model/database_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Database extends ChangeNotifier {
  final String uid;
  final String email;

  Database({required this.uid, required this.email});

  final _ref = FirebaseFirestore.instance;

  Future<void> addUser(UserFromDatabase user) async {
    await _ref.collection('users').doc(uid).set(user.toJson());
  }

  Stream<List<UserFromDatabase>> userstream() {
    return _ref
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((event) => event.docs
            .map((e) => UserFromDatabase.fromJson(e.data()))
            .toList());
  }
}
