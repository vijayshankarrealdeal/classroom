import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Request extends ChangeNotifier {
  final String id;
  final String requestBy;
  final String classw;
  final String chapter;
  final String request;
  final String discription;
  final String requestemail;
  final Timestamp time;

  Request({
    required this.requestBy,
    required this.id,
    required this.requestemail,
    required this.classw,
    required this.chapter,
    required this.request,
    required this.discription,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'class': classw,
      'chapter': chapter,
      'request': request,
      'discription': discription,
      'time': time,
      'id': id,
      'requestby': requestBy,
      'requestemail': requestemail,
    };
  }

  factory Request.fromJson(Map<String, dynamic> data) {
    return Request(
        id: data['id'],
        requestemail: data['requestemail'],
        requestBy: data['requestby'],
        classw: data['class'],
        chapter: data["chapter"],
        request: data['request'],
        discription: data['discription'],
        time: data['time']);
  }
}
