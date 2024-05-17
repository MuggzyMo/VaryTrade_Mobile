import 'package:flutter/material.dart';

class CommonThemeProvider {
    ButtonStyle buttonDesign(BuildContext context, double size) => ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(size, size)),
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      );
}