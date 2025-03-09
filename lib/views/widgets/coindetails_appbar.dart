import 'package:crypto_app/utils/kTextStyle.dart';
import 'package:flutter/material.dart';

AppBar coinAppBar({required String image, required String name, required String ticker, required int rank}) {
  return AppBar(
    titleSpacing: 1,
    foregroundColor: Colors.green[500],
    backgroundColor: Colors.white,
    elevation: 0,
    title: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 12,
          child: Image.network(image)
          ),
          const SizedBox(width: 5),
        Text(name),
        const SizedBox(width: 5),
        Text("#$rank", style: kTextStyle(size: 14, color: Colors.grey[500]!),),
      ],
    ),
  );
}
