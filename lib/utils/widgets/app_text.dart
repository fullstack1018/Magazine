// ignore_for_file: prefer_const_constructors, must_be_immutable
// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/material.dart';

Widget appText(
    {required String text,
    double size = 20,
    TextDecoration underLine = TextDecoration.none,
    TextAlign textAlign = TextAlign.left,
    FontWeight fontWeight = FontWeight.w400,
    String fontFamily = "ARIALNB",
    int? maxline,
    bool isGoogleFont = true,
    TextOverflow? overflow,
    Color color = Colors.black,
    TextStyle? style}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxline,
    overflow: overflow,
    style: style ??
        TextStyle(
            fontSize: size,
            decoration: underLine,
            overflow: overflow,
            fontWeight: fontWeight,
            color: color,
            fontFamily: fontFamily),
  );
}

printLog(value) {
  log(value.toString());
}
