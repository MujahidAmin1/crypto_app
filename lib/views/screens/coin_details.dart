import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/utils/kTextStyle.dart';
import 'package:crypto_app/views/widgets/coindetails_appbar.dart';
import 'package:crypto_app/views/widgets/stats_container.dart';
import 'package:flutter/material.dart';

class CoinDetails extends StatefulWidget {
  Crypto? coindata;
  CoinDetails({super.key, this.coindata});

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coinAppBar(
        image: widget.coindata!.image,
        name: widget.coindata!.name,
        ticker: widget.coindata!.symbol,
        rank: widget.coindata!.marketCapRank,
      ),
      body: ListView(
        padding: const EdgeInsets.all(9),
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                " ${widget.coindata!.currentPrice}",
                style: kTextStyle(size: 40),
              ),
              Text(
                " ${widget.coindata!.priceChangePercentage24h.toStringAsFixed(1)}%",
                style: kTextStyle(
                    size: 15,
                    color: widget.coindata!.priceChangePercentage24h < 0
                        ? Colors.red
                        : Colors.green),
              ),
            ],
          ),
          Card(
            elevation: 30,
            child: StatsContainer(
              marketCap: widget.coindata!.marketCap,
              fdv: widget.coindata!.fullyDilutedValuation,
              volume: widget.coindata!.totalVolume,
              circSupply: widget.coindata!.circulatingSupply,
              maxSupply: widget.coindata!.maxSupply ?? 00,
              totalSupply: widget.coindata!.totalSupply,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 30,
            child: StatsContainer2(
              ath: widget.coindata!.ath,
              atl: widget.coindata!.atl,
              athChangePercentage: widget.coindata!.athChangePercentage,
              athDate: widget.coindata!.athDate,
              atlChangePercentage: widget.coindata!.atlChangePercentage,
              atlDate: widget.coindata!.atlDate,
            ),
          ),
        ],
      ),
    );
  }
}
