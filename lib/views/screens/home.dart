import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/services/apiservice.dart';
import 'package:crypto_app/views/screens/coin_details.dart';
import 'package:crypto_app/views/widgets/crypto_tile.dart';
import 'package:crypto_app/views/widgets/headers.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[400],
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Crypto>>(
        stream: fetchCrypto.dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          List<Crypto> coindata = snapshot.data ?? [];

          return Column(
            children: [
              const SizedBox(height: 20),
              Row(children: [
                const SizedBox(width: 5),
                Headers(text: 'S/N'),
                const SizedBox(width: 20),
                Headers(text: 'Coin'),
                const SizedBox(width: 55),
                Headers(text: 'Price(usd)'),
                const SizedBox(width: 25),
                Headers(text: '24hchange(%)'),
                const SizedBox(width: 40),
                Headers(text: 'Market Cap(usd)'),
              ]),
              Expanded(
                child: ListView.builder(
                  itemCount: coindata.length,
                  itemBuilder: (context, index) {
                    final crypto = coindata[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CoinDetails(coindata: crypto),
                          ),
                        );
                      },
                      child: CryptoTile(
                        leading: Text("${index + 1}"),
                        price: crypto.currentPrice,
                        image: crypto.image,
                        symbol: crypto.symbol,
                        v24hrPercentagechange: crypto.priceChangePercentage24h,
                        marketCap: crypto.marketCap,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
