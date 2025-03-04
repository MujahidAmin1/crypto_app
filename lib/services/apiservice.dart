import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:crypto_app/models/coins.dart';

Future<List<Crypto>?> fetchGlobalData() async {
  String url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd";
  var headers = {
    "accept": "application/json",
    "x-cg-demo-api-key": "CG-3JApk2NBV9euWsFDhcMei4GG",
  };

  try {
    var response = await http.get(Uri.parse(url), headers: headers);
    log("API Response Status: ${response.statusCode}");
    log("API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Crypto> cryptos = jsonData.map((crypto) => Crypto.fromJson(crypto)).toList();
      return cryptos;
        
    } else {
      log("API Error: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    log("Exception caught: $e");
    return null;
  }
}
