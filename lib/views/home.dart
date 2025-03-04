import 'dart:math';

import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/services/apiservice.dart';
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
  late Future<List<Crypto>?> fetchcrypto;
  @override
  void initState() {
    fetchcrypto = fetchGlobalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: fetchcrypto,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          List<Crypto> coindata = snapshot.data!;
          return Column(
            children: [
              Row(
                children: [
                  Headers(text: 'S/N'),
                  Headers(text: 'Price(usd)'),
                  Headers(text: '24hchange(%)'),
                  Headers(text: 'Market Cap(usd)'),
                ]
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: coindata.length,
                  itemBuilder: (context, index){
                    final crypto = coindata[index];
                    return CryptoTile(leading: Text("${index+=1}"), price: crypto.currentPrice, image: crypto.image, symbol: crypto.symbol, v24hrPercentagechange: crypto.priceChangePercentage24h, marketCap: crypto.marketCap);
                  }
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
