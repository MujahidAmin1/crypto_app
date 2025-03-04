import 'package:flutter/material.dart';

TextStyle? kTextStyle({double? size = 20, isBold = false}){
    return TextStyle(
      fontSize: size,
      fontWeight: isBold,
    );
}