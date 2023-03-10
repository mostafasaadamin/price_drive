
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvailableContract &&
          runtimeType == other.runtimeType &&
          availableBarriers == other.availableBarriers &&
          barrier == other.barrier &&
          barrierCategory == other.barrierCategory &&
          barriers == other.barriers &&
          cancellationRange == other.cancellationRange &&
          contractCategory == other.contractCategory &&
          contractCategoryDisplay == other.contractCategoryDisplay &&
          contractDisplay == other.contractDisplay &&
          contractType == other.contractType &&
          exchangeName == other.exchangeName &&
          expiredBarriers == other.expiredBarriers &&
          expiryType == other.expiryType &&
          market == other.market &&
          maxContractDuration == other.maxContractDuration &&
          minContractDuration == other.minContractDuration &&
          multiplierRange == other.multiplierRange &&
          sentiment == other.sentiment &&
          startType == other.startType &&
          submarket == other.submarket &&
          tradingPeriod == other.tradingPeriod &&
          underlyingSymbol == other.underlyingSymbol;

  @override
  int get hashCode =>
      availableBarriers.hashCode ^
      barrier.hashCode ^
      barrierCategory.hashCode ^
      barriers.hashCode ^
      cancellationRange.hashCode ^
      contractCategory.hashCode ^
      contractCategoryDisplay.hashCode ^
      contractDisplay.hashCode ^
      contractType.hashCode ^
      exchangeName.hashCode ^
      expiredBarriers.hashCode ^
      expiryType.hashCode ^
      market.hashCode ^
      maxContractDuration.hashCode ^
      minContractDuration.hashCode ^
      multiplierRange.hashCode ^
      sentiment.hashCode ^
      startType.hashCode ^
      submarket.hashCode ^
      tradingPeriod.hashCode ^
      underlyingSymbol.hashCode;
}
