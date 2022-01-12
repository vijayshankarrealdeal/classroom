import 'package:classroom/controllers/data.dart';
import 'package:flutter/cupertino.dart';

class TrendsController extends ChangeNotifier {
  List<ClassDataStudent> listdata = [
    ClassDataStudent(
      topic: "Number Systems",
      mentorname: "Yash",
      subtpoics: [
        "Decimal Expansions of Real Numbers",
        "Euclid's Division Lemma",
        "The Fundamental Theorem of Arithmetic"
      ],
      studentenrollUid: ['a', 's'],
    ),
    ClassDataStudent(
      topic: "Polynomials",
      mentorname: "Yash Raj",
      subtpoics: [
        "Division Algorithm for Polynomials.",
        "Geometrical Meaning of the Zeroes of a Polynomial.",
        "Relationship Between Zeroes and Coefficients of a Polynomial."
      ],
      studentenrollUid: ['a', 's', 'af', 's'],
    ),
    ClassDataStudent(
      topic: "Pair of Linear Equations",
      mentorname: "Yash",
      subtpoics: [
        "Cross-Multiplication Method to Solve a Pair of Linear Equations.",
        "Elimination Method to Solve a Pair of Linear Equations.",
        "Equation Pairs: Reducing to Linear Form",
        "Graphical Method of Solution of a Pair of Linear Equations",
        "Substitution Method to Solve a Pair of Linear Equations"
      ],
      studentenrollUid: ['af'],
    ),
    ClassDataStudent(
      topic: "Quadratic Equations",
      mentorname: "Yash",
      subtpoics: [
        "Introduction to Quadratic Equations",
        "Nature of Roots",
        "Solution of a Quadratic Equation by Completing the Square",
        "Solution of a Quadratic Equation by Factorisation"
      ],
      studentenrollUid: ['a', 's', 'af'],
    ),
  ];
}
