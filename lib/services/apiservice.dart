import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:crypto_app/models/coins.dart';

class ApiService {
  final StreamController<List<Crypto>> _controller = StreamController.broadcast();
  late Timer _timer;

  ApiService() {
    _fetchData(); // Fetch initially
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _fetchData());
  }

  Stream<List<Crypto>> get dataStream => _controller.stream;

  Future<void> _fetchData() async {
    String url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd";
    var headers = {
      "accept": "application/json",
      "x-cg-demo-api-key": "CG-3JApk2NBV9euWsFDhcMei4GG",
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      log("API Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Crypto> cryptos = jsonData.map((crypto) => Crypto.fromJson(crypto)).toList();
        
        _controller.add(cryptos);
      } else {
        log("API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
  }

  void dispose() {
    _timer.cancel();
    _controller.close();
  }
}
