import 'package:crypto_app/utils/kTextStyle.dart';
import 'package:flutter/material.dart';

class Headers extends StatelessWidget {
  String text;
  Headers({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: kTextStyle(size: 15));
    
  }
}