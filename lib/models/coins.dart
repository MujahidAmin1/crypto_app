class GlobalData {
  final int activeCryptocurrencies;
  final int upcomingIcos;
  final int ongoingIcos;
  final int endedIcos;
  final int markets;
  final Map<String, double> totalMarketCap;
  final Map<String, double> totalVolume;
  final Map<String, double> marketCapPercentage;
  final double marketCapChangePercentage24hUsd;
  final int updatedAt;

  GlobalData({
    required this.activeCryptocurrencies,
    required this.upcomingIcos,
    required this.ongoingIcos,
    required this.endedIcos,
    required this.markets,
    required this.totalMarketCap,
    required this.totalVolume,
    required this.marketCapPercentage,
    required this.marketCapChangePercentage24hUsd,
    required this.updatedAt,
  });

  factory GlobalData.fromJson(Map<String, dynamic> json) {
    // Ensure 'data' exists
    final data = json['data'] as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("Invalid JSON: Missing 'data' key");
    }

    return GlobalData(
      activeCryptocurrencies: data['active_cryptocurrencies'] ?? 0,
      upcomingIcos: data['upcoming_icos'] ?? 0,
      ongoingIcos: data['ongoing_icos'] ?? 0,
      endedIcos: data['ended_icos'] ?? 0,
      markets: data['markets'] ?? 0,
      totalMarketCap: _convertToDoubleMap(data['total_market_cap']),
      totalVolume: _convertToDoubleMap(data['total_volume']),
      marketCapPercentage: _convertToDoubleMap(data['market_cap_percentage']),
      marketCapChangePercentage24hUsd:
          (data['market_cap_change_percentage_24h_usd'] as num?)?.toDouble() ?? 0.0,
      updatedAt: data['updated_at'] ?? 0,
    );
  }

  /// Helper function to safely convert a JSON map to `Map<String, double>`
  static Map<String, double> _convertToDoubleMap(Map<dynamic, dynamic>? jsonMap) {
    if (jsonMap == null) return {};

    return jsonMap.map((key, value) {
      return MapEntry(key.toString(), (value as num?)?.toDouble() ?? 0.0);
    });
  }
}
