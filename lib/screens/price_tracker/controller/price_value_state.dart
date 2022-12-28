part of 'price_value_cubit.dart';

@immutable
abstract class PriceValueState {}

class PriceValueInitial extends PriceValueState {}
class PriceDataLoading extends PriceValueState {}

class PriceDataLoaded extends PriceValueState {
  final Stream price;
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
class PriceDataError extends PriceValueState {
  final String message;
  PriceDataError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PriceDataError &&
              runtimeType == other.runtimeType &&
              message == other.message;

  @override
  int get hashCode => message.hashCode;
}
