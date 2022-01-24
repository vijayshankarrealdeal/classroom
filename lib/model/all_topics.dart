import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ClassDataStudent extends ChangeNotifier {
  late final String topic;
  late final String mentorname;
  late final String mentoruid;
  late final List subtpoics;
  late final List studentenrollUid;
  late final List reviews;
  late final String id;
  late final String classX;
  late final String classInfo;
  late final Timestamp time;
  late final double rating;

  ClassDataStudent({
    required this.topic,
    required this.mentorname,
    required this.subtpoics,
    required this.id,
    required this.mentoruid,
    required this.classX,
    required this.studentenrollUid,
    required this.reviews,
    required this.classInfo,
    required this.time,
    required this.rating,
  });

  List<String> _createIndex(String name) {
    List<String> index = [];
    int i = 0;
    int j = 1;
    while (j < name.length) {
      index.add(name.substring(i, j).toLowerCase());
      j++;
    }
    return index;
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'topic': topic,
      'id': id,
      'mentoruid': mentoruid,
      'review': reviews,
      'mentorname': mentorname,
      'subtpoics': subtpoics,
      'studentenrollUid': studentenrollUid,
      'classInfo': classInfo,
      'time': time,
      'class': classX,
      'searchIndex': _createIndex(topic),
    };
  }

  factory ClassDataStudent.fromJson(Map<String, dynamic> data) {
    return ClassDataStudent(
      rating: data['rating'] ?? 0.3,
      mentoruid: data['mentoruid'],
      time: data['time'],
      classInfo: data['classInfo'],
      id: data['id'],
      classX: data['class'],
      reviews: data['review'],
      topic: data['topic'],
      mentorname: data['mentorname'],
      subtpoics: data["subtpoics"],
      studentenrollUid: data["studentenrollUid"],
    );
  }
}
