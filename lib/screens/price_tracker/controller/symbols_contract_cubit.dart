import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:price_tracker/models/active_symbols.dart';
import 'package:price_tracker/models/symbol_contract.dart';
import 'package:price_tracker/repository/remote_repository/price_tracker.dart';

part 'symbols_contract_state.dart';

@injectable
class SymbolsContractCubit extends Cubit<SymbolsContractState> {
  IPriceTracker trackerRepository;

  SymbolsContractCubit(this.trackerRepository)
      : super(SymbolsContractInitial());

  AvailableContract? _selectedSymbolContract;
  AvailableContract? get selectedSymbolContract => _selectedSymbolContract;
  void setSelectedSymbolContract(AvailableContract? availableContract) {
    _selectedSymbolContract=availableContract;
  }
  List<AvailableContract> _symbolsContracts = [];
  List<AvailableContract> get symbolsContracts => _symbolsContracts;

  Future<void> getContractForSymbol(ActiveSymbol symbol) async {
    _symbolsContracts.clear();
    emit(ContractSymbolsLoading());
    final assets = await trackerRepository.getAllContractsForSymbol(symbol);
    if (assets.isError) {
      emit(ContractSymbolsTrackerError("Couldn't fetch Data !!!??"));
      return;
    }
    emit(ContractSymbolsLoaded(assets.asValue!.value));
  }
}
