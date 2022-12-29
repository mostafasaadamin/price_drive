



import 'package:price_tracker/models/active_symbols.dart';

abstract class PriceTrackerControllerState {}

class PriceTrackerControllerInitial extends PriceTrackerControllerState {}

class MarketSpinnerLoading extends PriceTrackerControllerState {
  MarketSpinnerLoading();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketSpinnerLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class MarketSpinnerLoaded extends PriceTrackerControllerState {
  final Stream symbolsListener;
  MarketSpinnerLoaded(this.symbolsListener);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketSpinnerLoaded &&
          runtimeType == other.runtimeType &&
          symbolsListener == other.symbolsListener;

  @override
  int get hashCode => symbolsListener.hashCode;
}

class SelectedActiveSymbol extends PriceTrackerControllerState {
  final ActiveSymbol? activeSymbol;
  SelectedActiveSymbol(this.activeSymbol);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedActiveSymbol &&
          runtimeType == other.runtimeType &&
          activeSymbol == other.activeSymbol;

  @override
  int get hashCode => activeSymbol.hashCode;
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