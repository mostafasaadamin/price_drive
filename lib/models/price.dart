class PriceProposal  {
  double? askPrice;
      double? commission;
  DateTime? dateExpiry;
      DateTime? dateStart;
  String? displayValue;
      String? id;
  String? longCode;
      int? multiplier;
  double? payout;
      double? spot;
  DateTime? spotTime;
  PriceProposal({
    double? askPrice,
    double? commission,
    DateTime? dateExpiry,
    DateTime? dateStart,
    String? displayValue,
    String? id,
    String? longCode,
    int? multiplier,
    double? payout,
    double? spot,
    DateTime? spotTime,
  });

  factory PriceProposal.fromJson(
      Map<String, dynamic> json, {
        Map<String, dynamic>? subscriptionJson,
      }) =>
      PriceProposal(
        askPrice: json['ask_price']?.toDouble(),
        commission: json['commission']?.toDouble(),
        displayValue: json['display_value'],
        id: json['id'],
        longCode: json['longcode'],
        multiplier: json['multiplier'],
        payout: json['payout']?.toDouble(),
        spot: json['spot']?.toDouble(),
      );
}