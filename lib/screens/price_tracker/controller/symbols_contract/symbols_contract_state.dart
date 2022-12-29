
abstract class SymbolsContractState {}

class SymbolsContractInitial extends SymbolsContractState {}

class ContractSymbolsLoading extends SymbolsContractState {
   ContractSymbolsLoading();

   @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractSymbolsLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
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