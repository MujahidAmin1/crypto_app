import 'package:crypto_app/utils/kTextStyle.dart';
import 'package:flutter/material.dart';

class CryptoTile extends StatelessWidget {
  Widget leading;
  String image;
  double price;
  String symbol;
  double v24hrPercentagechange;
  double marketCap;
  Text? subtitle;

  CryptoTile({
    super.key,
    required this.leading,
    required this.price,
    this.subtitle,
    required this.image,
    required this.symbol,
    required this.v24hrPercentagechange,
    required this.marketCap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              leading,
              const SizedBox(width: 14),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 8,
                backgroundImage: NetworkImage(image),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Text(
                  symbol.toUpperCase(),
                  style: kTextStyle(size: 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "\$${price.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Text(
                  "${v24hrPercentagechange.toStringAsFixed(2)}%",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: v24hrPercentagechange >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Text(
                  "\$${marketCap.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
      
    );
  }
}
