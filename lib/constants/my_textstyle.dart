import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

double textFontSize;
void getFontSize({double getTextFontSize}) {
  textFontSize = getTextFontSize;
}

TextStyle myTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);
