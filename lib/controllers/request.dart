import 'package:flutter/cupertino.dart';

class RequestController extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController topic = TextEditingController();
  TextEditingController request = TextEditingController();
  TextEditingController about = TextEditingController();

  bool validate() {
    if (name.text.isEmpty ||
        topic.text.isEmpty ||
        request.text.isEmpty ||
        about.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void clearAll() {
    name.clear();
    about.clear();
    request.clear();
    topic.clear();
  }

  @override
  void dispose() {
    name.dispose();
    about.dispose();
    request.dispose();
    topic.dispose();
    super.dispose();
  }
}
