  
  import 'package:flutter/material.dart';

  Widget richText(String text,{required double fontSize, TextAlign? textAlign, FontWeight? fontWeight,FontStyle? fontStyle, Color? color}){
    return RichText(
                    textAlign: (textAlign==null) ?  TextAlign.justify : textAlign,
                    text: TextSpan(
                      style: TextStyle(
                        color: (color==null)? Colors.black87:color,
                        fontStyle: fontStyle,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                      ),
                      children: [
                        TextSpan(
                            text:
                                text)
                      ],
                    ),
                  );
  }