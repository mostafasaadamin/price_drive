part of 'price_tracker_controller_cubit.dart';

@immutable
abstract class PriceTrackerControllerState {}

class PriceTrackerControllerInitial extends PriceTrackerControllerState {}

class MarketSpinnerLoading extends PriceTrackerControllerState {}

class MarketSpinnerLoaded extends PriceTrackerControllerState {
  final List<Market> market;
  MarketSpinnerLoaded(this.market);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketSpinnerLoaded &&
          runtimeType == other.runtimeType &&
          market == other.market;

  @override
  int get hashCode => market.hashCode;
}

class AssetsSpinnerLoading extends PriceTrackerControllerState {}

class AssetsSpinnerLoaded extends PriceTrackerControllerState {
  final List<Assets> assets;
  AssetsSpinnerLoaded(this.assets);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetsSpinnerLoaded &&
          runtimeType == other.runtimeType &&
          assets == other.assets;

  @override
  int get hashCode => assets.hashCode;
}

class PriceDataLoading extends PriceTrackerControllerState {}

class PriceDataLoaded extends PriceTrackerControllerState {
  final Price price;
  PriceDataLoaded(this.price);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceDataLoaded &&
          runtimeType == other.runtimeType &&
          price == other.price;

  @override
  int get hashCode => price.hashCode;
}

class PriceTrackerError extends PriceTrackerControllerState {
  final String message;
  PriceTrackerError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceTrackerError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}