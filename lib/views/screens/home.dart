import 'package:flutter/material.dart';
import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/services/apiservice.dart';
import 'package:crypto_app/views/screens/coin_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

var cryptoDataListenerProvider =
    FutureProvider.autoDispose<List<Crypto>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchData();
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cryptoDataRef = ref.watch(cryptoDataListenerProvider);
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: Text("Crypto"),
        backgroundColor: Colors.black38,
        foregroundColor: Colors.white,
      ),
      body: cryptoDataRef.when(
        data: (crypto) {
          return ListView.builder(
              itemCount: cryptoDataRef.value!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CoinDetails(coindata: crypto[index]);
                          },
                        ),
                      );
                    },
                    child: _CoinListTile(index: index, coin: crypto[index]));
              });
        },
        error: (err, _) {
          return Text('Error: $err');
        },
        loading: () {
          return CircularProgressIndicator();
        },
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
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
    final priceColor =
        coin.priceChangePercentage24h < 0 ? Colors.red : Colors.green;
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
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                Text(coin.symbol.toUpperCase(),
                    style:
                        const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(formatter.format(coin.currentPrice),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              Text("${coin.priceChangePercentage24h.toStringAsFixed(2)}%",
                  style: TextStyle(color: priceColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
