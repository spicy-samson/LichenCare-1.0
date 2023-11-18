import 'package:flutter/material.dart';

Widget richText(String text,
    {required double fontSize,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color}) {
  return RichText(
    textAlign: (textAlign == null) ? TextAlign.justify : textAlign,
    text: TextSpan(
      style: TextStyle(
        color: (color == null) ? Colors.black87 : color,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        fontSize: fontSize*1.02,
      ),
      children: [TextSpan(text: text)],
    ),
  );
}


String makeAnonymous(String name){
    String anonymous = "";
    String firstName = name.split(" ")[0];
    for (int i = 0; i < firstName.length; i++){
      if(i==0){
        anonymous+=firstName[i];
      }else{
        anonymous+="*";
      }
    }
    return anonymous;
  }