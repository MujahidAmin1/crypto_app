import 'package:flutter/material.dart';
import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/services/apiservice.dart';
import 'package:crypto_app/views/screens/coin_details.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ApiService fetchCrypto;

  @override
  void initState() {
    super.initState();
    fetchCrypto = ApiService();
  }

  @override
  void dispose() {
    fetchCrypto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: widget.title),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Crypto>>(
                stream: fetchCrypto.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.white)),
                    );
                  }

                  final coindata = snapshot.data ?? [];
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: coindata.length,
                    itemBuilder: (context, index) {
                      final crypto = coindata[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CoinDetails(coindata: crypto),
                          ),
                        ),
                        child: _CoinListTile(index: index + 1, coin: crypto),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _Header extends StatelessWidget {
  final String title;
  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const Icon(Icons.account_circle, size: 30, color: Colors.white54),
        ],
      ),
    );
  }
}
class _CoinListTile extends StatelessWidget {
  final int index;
  final Crypto coin;
  const _CoinListTile({required this.index, required this.coin});

  @override
  Widget build(BuildContext context) {
    final priceColor = coin.priceChangePercentage24h < 0 ? Colors.red : Colors.green;
    final formatter = NumberFormat.compactCurrency(symbol: '\$');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Text(
            "$index",
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white12,
            backgroundImage: NetworkImage(coin.image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coin.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                Text(coin.symbol.toUpperCase(),
                    style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(formatter.format(coin.currentPrice),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              Text("${coin.priceChangePercentage24h.toStringAsFixed(2)}%",
                  style: TextStyle(color: priceColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
