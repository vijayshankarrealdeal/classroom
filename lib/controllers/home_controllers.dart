import 'dart:async';

import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeController extends ChangeNotifier {
  HomeController(Database db, BuildContext context) {
    getClasses(db, context);
  }
  List<ClassDataStudent> _data = [];
  List<ClassDataStudent> get listdata => _data;
  // ignore: unused_field
  late StreamSubscription _notficaitons;
  late StreamSubscription _classes;

  void getClasses(Database db, BuildContext context) {
    final d = Provider.of<UserFromDatabase>(context, listen: false);
    _classes = db.getClassesOfUser(d.classstudy, d).listen((event) {
      _data = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _classes.cancel();
    super.dispose();
  }
}


// List<ClassDataStudent> listdata = [
//     ClassDataStudent(
//       topic: "Number Systems",
//       mentorname: "Yash",
//       subtpoics: [
//         "Decimal Expansions of Real Numbers",
//         "Euclid's Division Lemma",
//         "The Fundamental Theorem of Arithmetic"
//       ],
//       studentenrollUid: ['a', 's'],
//     ),
//     ClassDataStudent(
//       topic: "Polynomials",
//       mentorname: "Yash Raj",
//       subtpoics: [
//         "Division Algorithm for Polynomials.",
//         "Geometrical Meaning of the Zeroes of a Polynomial.",
//         "Relationship Between Zeroes and Coefficients of a Polynomial."
//       ],
//       studentenrollUid: ['a', 's', 'af', 's'],
//     ),
//     ClassDataStudent(
//       topic: "Pair of Linear Equations",
//       mentorname: "Yash",
//       subtpoics: [
//         "Cross-Multiplication Method to Solve a Pair of Linear Equations.",
//         "Elimination Method to Solve a Pair of Linear Equations.",
//         "Equation Pairs: Reducing to Linear Form",
//         "Graphical Method of Solution of a Pair of Linear Equations",
//         "Substitution Method to Solve a Pair of Linear Equations"
//       ],
//       studentenrollUid: ['af'],
//     ),
//     ClassDataStudent(
//       topic: "Quadratic Equations",
//       mentorname: "Yash",
//       subtpoics: [
//         "Introduction to Quadratic Equations",
//         "Nature of Roots",
//         "Solution of a Quadratic Equation by Completing the Square",
//         "Solution of a Quadratic Equation by Factorisation"
//       ],
//       studentenrollUid: ['a', 's', 'af'],
//     ),
//   ];