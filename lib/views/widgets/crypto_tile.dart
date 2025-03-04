import 'package:crypto_app/models/coins.dart';
import 'package:flutter/material.dart';

class CryptoTile extends StatelessWidget {
  Widget? leading;
  Text? title;
  Text? subtitle;
  CryptoTile({super.key, this.leading, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
    );
  }
}