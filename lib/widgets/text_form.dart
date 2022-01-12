import 'package:flutter/cupertino.dart';

class FormFeildApp extends StatelessWidget {
  final TextEditingController controller;
  final bool hide;
  final String placeholder;
  final TextInputType type;
  final Widget? suffix;
  final int maxlines;
  const FormFeildApp({
    Key? key,
    this.suffix,
    this.maxlines = 1,
    required this.placeholder,
    this.type = TextInputType.multiline,
    required this.controller,
    this.hide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: SizedBox(
        child: CupertinoTextField(
          suffix: suffix,
          maxLines: maxlines,
          keyboardType: type,
          controller: controller,
          obscureText: hide,
          placeholder: placeholder,
        ),
      ),
    );
  }
}
