import 'dart:math';

import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/services/apiservice.dart';
import 'package:crypto_app/views/widgets/crypto_tile.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<GlobalData?> fetchCoinData;
  @override
  void initState() {
    fetchCoinData = fetchGlobalData();
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
        future: fetchCoinData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          ;
          var coindata = snapshot.data!;
          return ListView(children: [
            Text(
                "Active Crypto Currencies: ${coindata.activeCryptocurrencies}"),
            ...coindata.totalMarketCap.entries
                .toList()
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key; // Get index
              MapEntry<String, dynamic> data =
                  entry.value; // Get key-value pair

              return ListTile(
                leading:
                    Text("${index + 1}", style: const TextStyle(fontSize: 20)), // Show index
                title: Text(data.key.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(data.value.toStringAsFixed(1)),
              );
            }).toList(),
          ]);
        },
      ),
    );
  }
}
