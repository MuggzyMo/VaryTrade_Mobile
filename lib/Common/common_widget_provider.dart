import 'package:flutter/material.dart';

class CommonWidgetProvider {

  const CommonWidgetProvider();

  Widget space(BuildContext context, double size) => SizedBox(
        height: size,
      );

  Future selectDate(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now());

  AlertDialog alert(String title, String content, Color color) => AlertDialog(
      title: Text(title, style: TextStyle(color: color)),
      content: Text(content, style: TextStyle(color: color)));
}
