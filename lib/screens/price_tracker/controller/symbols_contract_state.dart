part of 'symbols_contract_cubit.dart';

@immutable
abstract class SymbolsContractState {}

class SymbolsContractInitial extends SymbolsContractState {}

class ContractSymbolsLoading extends SymbolsContractState {
   ContractSymbolsLoading();
}

class ContractSymbolsLoaded extends SymbolsContractState {
  final Stream contractListener;
  ContractSymbolsLoaded(this.contractListener);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ContractSymbolsLoaded &&
              runtimeType == other.runtimeType &&
              contractListener == other.contractListener;

  @override
  int get hashCode => contractListener.hashCode;
}

class ContractSymbolsTrackerError extends SymbolsContractState {
  final String message;
  ContractSymbolsTrackerError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ContractSymbolsTrackerError &&
              runtimeType == other.runtimeType &&
              message == other.message;

  @override
  int get hashCode => message.hashCode;
}