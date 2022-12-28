
class AvailableContract {
  final List<int>? availableBarriers;

  final String? barrier;

  final String? barrierCategory;

  final int? barriers;

  final List<String?>? cancellationRange;

  final String? contractCategory;

  final String? contractCategoryDisplay;

  final String? contractDisplay;

  final String? contractType;

  final String? exchangeName;

  final List<String?>? expiredBarriers;

  final String? expiryType;

  final String? market;

  final String? maxContractDuration;

  final String? minContractDuration;

  final List<int?>? multiplierRange;

  final String? sentiment;

  final String? startType;

  final String? submarket;

  final Map<String, dynamic>? tradingPeriod;

  final String? underlyingSymbol;

  AvailableContract(
      {this.availableBarriers,
      this.barrier,
      this.barrierCategory,
      this.barriers,
      this.cancellationRange,
      this.contractCategory,
      this.contractCategoryDisplay,
      this.contractDisplay,
      this.contractType,
      this.exchangeName,
      this.expiredBarriers,
      this.expiryType,
      this.market,
      this.maxContractDuration,
      this.minContractDuration,
      this.multiplierRange,
      this.sentiment,
      this.startType,
      this.submarket,
      this.tradingPeriod,
      this.underlyingSymbol});

  factory AvailableContract.fromJson(Map<String, dynamic> json) =>
      AvailableContract(
        availableBarriers: json['available_barriers'],
        barrier: json['barrier'].toString(),
        barrierCategory: json['barrier_category'],
        barriers: json['barriers'],
        contractCategory: json['contract_category'],
        contractCategoryDisplay: json['contract_category_display'],
        contractDisplay: json['contract_display'],
        contractType: json['contract_type'],
        exchangeName: json['exchange_name'],
        expiryType: json['expiry_type'],
        market: json['market'],
        maxContractDuration: json['max_contract_duration'],
        minContractDuration: json['min_contract_duration'],
        sentiment: json['sentiment'],
        startType: json['start_type'],
        submarket: json['submarket'],
        tradingPeriod: json['trading_period'],
        underlyingSymbol: json['underlying_symbol'],
      );



}
