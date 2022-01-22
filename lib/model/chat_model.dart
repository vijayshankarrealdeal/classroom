import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModelX {
  final String text;
  final Timestamp time;
  final String uid;
  final bool ismentor;
  final String id;
  final bool pin;
  ChatModelX(
      {required this.text,
      required this.ismentor,
      required this.time,
      required this.id,
      required this.pin,
      required this.uid});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin': pin,
      'text': text,
      "time": Timestamp.now(),
      "uid": uid,
      "ismentor": ismentor,
    };
  }

  factory ChatModelX.fromJson(Map<String, dynamic> data) {
    return ChatModelX(
        id: data['id'],
        pin: data['pin'],
        ismentor: data['ismentor'],
        text: data['text'],
        time: data['time'],
        uid: data['uid']);
  }
}
