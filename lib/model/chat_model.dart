import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModelX {
  final String text;
  final Timestamp time;
  final String uid;
  final bool ismentor;

  ChatModelX(
      {required this.text,
      required this.ismentor,
      required this.time,
      required this.uid});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      "time": Timestamp.now(),
      "uid": uid,
      "ismentor": ismentor,
    };
  }

  factory ChatModelX.fromJson(Map<String, dynamic> data) {
    return ChatModelX(
        ismentor: data['ismentor'],
        text: data['text'],
        time: data['time'],
        uid: data['uid']);
  }
}
