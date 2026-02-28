import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:crypto_app/models/coins.dart';
import 'package:riverpod/riverpod.dart';

var apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  Future<List<Crypto>> fetchData() async {
    const String url =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd";
    const headers = {
      "accept": "application/json",
      "x-cg-demo-api-key": "CG-3JApk2NBV9euWsFDhcMei4GG",
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      log("API Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((crypto) => Crypto.fromJson(crypto)).toList();
      } else {
        log("API Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      log("Exception caught: $e");
      return [];
    }
  }
}
