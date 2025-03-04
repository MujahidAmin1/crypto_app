import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:crypto_app/models/coins.dart';

Future<GlobalData?> fetchGlobalData() async {
  String url = "https://api.coingecko.com/api/v3/global";
  var headers = {
    "accept": "application/json",
    "x-cg-demo-api-key": "CG-3JApk2NBV9euWsFDhcMei4GG",
  };

  try {
    var response = await http.get(Uri.parse(url), headers: headers);
    log("API Response Status: ${response.statusCode}");
    log("API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
       Map<String, dynamic> marketCapData = jsonData["data"]["total_market_cap"];
      // Ensure `data` key exists
      if (jsonData.containsKey('data') && jsonData['data'] != null) {
        return GlobalData.fromJson(jsonData);
      } 
      else {
        log("Error: 'data' key is missing or null in JSON response");
        return null;
      }
    } else {
      log("API Error: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    log("Exception caught: $e");
    return null;
  }
}
