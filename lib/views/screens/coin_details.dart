import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crypto_app/models/coins.dart';

import '../widgets/glasscard.dart';
import '../widgets/statrow.dart';

class CoinDetails extends StatelessWidget {
  final Crypto coindata;
  const CoinDetails({super.key, required this.coindata});

  @override
  Widget build(BuildContext context) {
    final priceChange = coindata.priceChangePercentage24h;
    final priceChangeColor = priceChange < 0 ? Colors.red : Colors.green;
    final formatter = NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header Section
              _CoinHeader(coindata: coindata, priceChangeColor: priceChangeColor),

              const SizedBox(height: 30),

              // Price Display
              Text(
                '\$${coindata.currentPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${priceChange.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 18,
                  color: priceChangeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 32),

              // Market Stats
              GlassCard(
                title: 'Market Overview',
                children: [
                  StatRow(label: "Market Cap", value: formatter.format(coindata.marketCap)),
                  StatRow(label: "Volume (24h)", value: formatter.format(coindata.totalVolume)),
                  StatRow(label: "FDV", value: formatter.format(coindata.fullyDilutedValuation)),
                  StatRow(label: "Circulating Supply", value: coindata.circulatingSupply.toStringAsFixed(0)),
                  StatRow(label: "Total Supply", value: coindata.totalSupply.toStringAsFixed(0)),
                  StatRow(label: "Max Supply", value: coindata.maxSupply?.toStringAsFixed(0) ?? '∞'),
                ],
              ),

              const SizedBox(height: 20),

              // ATH/ATL Stats
              GlassCard(
                title: 'All-Time Stats',
                children: [
                  StatRow(label: "ATH", value: formatter.format(coindata.ath)),
                  StatRow(label: "ATH Change", value: '${coindata.athChangePercentage.toStringAsFixed(2)}%'),
                  StatRow(label: "ATH Date", value: _formatDate(coindata.athDate)),
                  const Divider(color: Colors.white10),
                  StatRow(label: "ATL", value: formatter.format(coindata.atl)),
                  StatRow(label: "ATL Change", value: '${coindata.atlChangePercentage.toStringAsFixed(2)}%'),
                  StatRow(label: "ATL Date", value: _formatDate(coindata.atlDate)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat.yMMM().format(parsedDate);
    } catch (_) {
      return date;
    }
  }
}

class _CoinHeader extends StatelessWidget {
  final Crypto coindata;
  final Color priceChangeColor;

  const _CoinHeader({required this.coindata, required this.priceChangeColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white12,
          backgroundImage: NetworkImage(coindata.image),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(coindata.name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(coindata.symbol.toUpperCase(),
                style: const TextStyle(fontSize: 14, color: Colors.white54)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Rank #${coindata.marketCapRank}",
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
