import 'dart:async';
import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:flutter/cupertino.dart';

class TrendsController extends ChangeNotifier {
  TrendsController(BuildContext context, UserFromDatabase user, Database db) {
    getData(context, user, db);
  }
  List<ClassDataStudent> _stdu = [];
  List<ClassDataStudent> get listdata => _stdu;
  List<ClassDataStudent> tmpsearch = [];

  TextEditingController search = TextEditingController();
  late StreamSubscription _controller;

  void getData(BuildContext context, UserFromDatabase user, Database db) {
    _controller = db.getAlltopics(user.classstudy).listen((event) {
      _stdu = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    search.dispose();
    _controller.cancel();
    super.dispose();
  }
}
