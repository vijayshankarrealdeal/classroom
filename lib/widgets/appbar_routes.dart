import 'package:flutter/cupertino.dart';

CupertinoNavigationBar appBarRoute(String ptitle, String mtitle) {
  return CupertinoNavigationBar(
    automaticallyImplyLeading: true,
    previousPageTitle: ptitle,
    middle: Text(mtitle),
  );
}
