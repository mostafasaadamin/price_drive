part of 'price_tracker_controller_cubit.dart';

@immutable
abstract class PriceTrackerControllerState {}

class PriceTrackerControllerInitial extends PriceTrackerControllerState {}

class MarketSpinnerLoading extends PriceTrackerControllerState {}

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


// class PriceDataLoading extends PriceTrackerControllerState {}
//
// class PriceDataLoaded extends PriceTrackerControllerState {
//   final Price price;
//   PriceDataLoaded(this.price);
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is PriceDataLoaded &&
//           runtimeType == other.runtimeType &&
//           price == other.price;
//
//   @override
//   int get hashCode => price.hashCode;
// }
//
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