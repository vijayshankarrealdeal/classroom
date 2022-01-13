import 'dart:async';

import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NotificationController extends ChangeNotifier {
  NotificationController(Database db, BuildContext context) {
    getClasses(db, context);
  }
  // ignore: unused_field
  late StreamSubscription _notficaitons;
  late StreamSubscription _classes;

  void getClasses(Database db, BuildContext context) {
    final d = Provider.of<UserFromDatabase>(context, listen: false);
    _classes = db.getClassesOfUser(d.classstudy, d).listen((event) {});
  }

  @override
  void dispose() {
    _classes.cancel();
    super.dispose();
  }
}
