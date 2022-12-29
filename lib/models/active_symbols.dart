class ActiveSymbol {
  int? allowForwardStarting;
  String? displayName;
  int? displayOrder;
  int? exchangeIsOpen;
  int? isTradingSuspended;
  String? market;
  String? marketDisplayName;
  double? pip;
  String? subgroup;
  String? subgroupDisplayName;
  String? submarket;
  String? submarketDisplayName;
  String? symbol;
  String? symbolType;

  ActiveSymbol(
      {this.allowForwardStarting,
        this.displayName,
        this.displayOrder,
        this.exchangeIsOpen,
        this.isTradingSuspended,
        this.market,
        this.marketDisplayName,
        this.pip,
        this.subgroup,
        this.subgroupDisplayName,
        this.submarket,
        this.submarketDisplayName,
        this.symbol,
        this.symbolType});

  ActiveSymbol.fromJson(Map<String, dynamic> json) {
    allowForwardStarting = json['allow_forward_starting'];
    displayName = json['display_name'];
    displayOrder = json['display_order'];
    exchangeIsOpen = json['exchange_is_open'];
    isTradingSuspended = json['is_trading_suspended'];
    market = json['market'];
    marketDisplayName = json['market_display_name'];
    pip = json['pip'];
    subgroup = json['subgroup'];
    subgroupDisplayName = json['subgroup_display_name'];
    submarket = json['submarket'];
    submarketDisplayName = json['submarket_display_name'];
    symbol = json['symbol'];
    symbolType = json['symbol_type'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveSymbol &&
          runtimeType == other.runtimeType &&
          allowForwardStarting == other.allowForwardStarting &&
          displayName == other.displayName &&
          displayOrder == other.displayOrder &&
          exchangeIsOpen == other.exchangeIsOpen &&
          isTradingSuspended == other.isTradingSuspended &&
          market == other.market &&
          marketDisplayName == other.marketDisplayName &&
          pip == other.pip &&
          subgroup == other.subgroup &&
          subgroupDisplayName == other.subgroupDisplayName &&
          submarket == other.submarket &&
          submarketDisplayName == other.submarketDisplayName &&
          symbol == other.symbol &&
          symbolType == other.symbolType;

  @override
  int get hashCode =>
      allowForwardStarting.hashCode ^
      displayName.hashCode ^
      displayOrder.hashCode ^
      exchangeIsOpen.hashCode ^
      isTradingSuspended.hashCode ^
      market.hashCode ^
      marketDisplayName.hashCode ^
      pip.hashCode ^
      subgroup.hashCode ^
      subgroupDisplayName.hashCode ^
      submarket.hashCode ^
      submarketDisplayName.hashCode ^
      symbol.hashCode ^
      symbolType.hashCode;
}
