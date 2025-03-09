import 'package:intl/intl.dart';
import 'package:crypto_app/utils/kTextStyle.dart';
import 'package:flutter/material.dart';

class StatsContainer extends StatefulWidget {
  double? marketCap, fdv, volume, circSupply, totalSupply, maxSupply;
  StatsContainer({
    super.key,
    required this.marketCap,
    required this.fdv,
    required this.volume,
    required this.circSupply,
    required this.maxSupply,
    required this.totalSupply,
  });

  @override
  State<StatsContainer> createState() => _StatsContainerState();
}

class _StatsContainerState extends State<StatsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Market Cap", style: kTextStyle(size: 20, color: Colors.grey[600]!)),
                Text("${widget.marketCap}"),
                Text("FDV", style: kTextStyle(size: 20, color: Colors.grey[600]!)),
                Text("${widget.fdv}"),
                Text("Volume", style: kTextStyle(size: 20, color: Colors.grey[600]!)),
                Text("${widget.volume}"),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Circulating supply", style: kTextStyle(size: 20, color: Colors.grey[600]!)),
                Text("${widget.circSupply}"),
                Text("Total Supply", style: kTextStyle(size: 20, color: Colors.grey[600]!)),
                Text("${widget.totalSupply}"),
                Text("Max Supply", style: kTextStyle(size: 20, color: Colors.grey[600]!)),
                Text("${widget.maxSupply}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatsContainer2 extends StatefulWidget {
  double ath, atl, athChangePercentage, atlChangePercentage;
  String athDate, atlDate;
  StatsContainer2({super.key, required this.ath, required this.atl, required this.athChangePercentage, required this.athDate, required this.atlChangePercentage, required this.atlDate,});

  @override
  State<StatsContainer2> createState() => _StatsContainer2State();
}

class _StatsContainer2State extends State<StatsContainer2> {
  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("All-time high", style: kTextStyle(size: 20, color: Colors.grey[600]!)),
                Text.rich(
                  TextSpan(
                    text: "${widget.ath} ",
                    children: [
                      TextSpan(
                        text: "${widget.athChangePercentage}",
                        style: kTextStyle(color: widget.athChangePercentage < 0 ? Colors.red : Colors.green, size: 10),
                      )
                    ]
                  )
                  
                  ),
                Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.athDate))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("All-time Low", style: kTextStyle(size: 20, color: Colors.grey[600]!)),
                Text.rich(
                  TextSpan(
                    text: "${widget.atl} ",
                    children: [
                      TextSpan(
                        text: "${widget.atlChangePercentage}",
                        style: kTextStyle(color: widget.atlChangePercentage < 0 ? Colors.red : Colors.green, size: 10),
                      )
                    ]
                  )
                  
                  ),
                Text(DateFormat('dd-MM-yyyy').format((DateTime.parse(widget.athDate))),
            ),]
            ),
          ),
        ],
      ),
    );
  }
}