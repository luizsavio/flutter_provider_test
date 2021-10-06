import 'package:flutter/material.dart';

Text text(String s, {
  double? fontSize,
  color,
  bold = false,
  fontFamily = "Roboto",
  underline = false,
  int maxLines = 1,
  bool ellipsis = true,
  TextAlign textAlign = TextAlign.left
}) {
  if (s == "null") {
    // Corrigir problema do servidor
    s = "";
  }

  return Text(
    s,
    maxLines: maxLines,
    overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.clip,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      decoration: underline ? TextDecoration.underline : null,
    ),
  );
}
