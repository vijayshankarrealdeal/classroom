import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/chat_model.dart';
import 'package:classroom/model/database_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Database extends ChangeNotifier {
  final String uid;
  final String email;

  Database({required this.uid, required this.email});

  final _ref = FirebaseFirestore.instance;
  bool load = false;
  Future<void> addUser(UserFromDatabase user) async {
    await _ref.collection('users').doc(uid).set(user.toJson());
  }

  Future<void> addChat(ChatModelX data, String classid) async {
    await _ref
        .collection('chats')
        .doc(classid)
        .collection('discuss')
        .doc()
        .set(data.toJson());
  }

  Future<void> addNewClass(ClassDataStudent data) async {
    load = true;
    notifyListeners();
    await _ref
        .collection('allTopics')
        .doc(data.classX)
        .collection('topicscreted')
        .doc(data.id)
        .set(data.toJson());
    await _ref.collection('users').doc(uid).update({
      'topicCreated': FieldValue.arrayUnion([
        {'class': data.classX, 'classid': data.id}
      ])
    });
    load = false;
    notifyListeners();
  }

  Future<void> enroll(ClassDataStudent data) async {
    load = true;
    data.studentenrollUid.add(uid);
    notifyListeners();
    await _ref.collection('users').doc(uid).update({
      'topicenrolled': FieldValue.arrayUnion([
        {'class': data.classX, 'classid': data.id}
      ])
    });
    await _ref
        .collection('allTopics')
        .doc(data.classX)
        .collection('topicscreted')
        .doc(data.id)
        .update({
      'studentenrollUid': FieldValue.arrayUnion([uid])
    });
    load = false;
    notifyListeners();
  }

  Future<void> unenroll(ClassDataStudent data) async {
    load = true;
    data.studentenrollUid.remove(uid);
    notifyListeners();
    await _ref.collection('users').doc(uid).update({
      'topicenrolled': FieldValue.arrayRemove([
        {'class': data.classX, 'classid': data.id}
      ])
    });
    await _ref
        .collection('allTopics')
        .doc(data.classX)
        .collection('topicscreted')
        .doc(data.id)
        .update({
      'studentenrollUid': FieldValue.arrayRemove([uid])
    });
    load = false;
    notifyListeners();
  }

  Stream<List<ClassDataStudent>> getAlltopics(String studentclass) {
    return _ref
        .collection('allTopics')
        .doc(studentclass)
        .collection('topicscreted')
        .orderBy('time', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => ClassDataStudent.fromJson(e.data()))
            .toList());
  }

  Stream<List<ChatModelX>> classDiscuss(String classid) {
    return _ref
        .collection('chats')
        .doc(classid)
        .collection('discuss')
        .orderBy('time', descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ChatModelX.fromJson(e.data())).toList());
  }

  Stream<List<ClassDataStudent>> getClassesOfUser(
      String studentclass, UserFromDatabase user) {
    if (user.isMentor) {
      return _ref
          .collection('allTopics')
          .doc(studentclass)
          .collection('topicscreted')
          .where('mentoruid', isEqualTo: uid)
          .snapshots()
          .map((event) => event.docs
              .map((e) => ClassDataStudent.fromJson(e.data()))
              .toList());
    } else {
      return _ref
          .collection('allTopics')
          .doc(studentclass)
          .collection('topicscreted')
          .where('studentenrollUid', arrayContains: uid)
          .snapshots()
          .map((event) => event.docs
              .map((e) => ClassDataStudent.fromJson(e.data()))
              .toList());
    }
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
