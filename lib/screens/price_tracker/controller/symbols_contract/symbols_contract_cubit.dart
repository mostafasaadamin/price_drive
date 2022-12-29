import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:price_tracker/models/active_symbols.dart';
import 'package:price_tracker/models/symbol_contract.dart';
import 'package:price_tracker/repository/remote_repository/price_tracker.dart';
import 'package:price_tracker/screens/price_tracker/controller/symbols_contract/symbols_contract_state.dart';


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


  Future<void> getContractForSymbol(ActiveSymbol symbol) async {
    setSelectedSymbolContract(null);
    emit(ContractSymbolsLoading());
    final assets = await trackerRepository.getAllContractsForSymbol(symbol);
    if (assets.isError) {
      emit(ContractSymbolsTrackerError("Couldn't fetch Data !!!??"));
      return;
    }
    emit(ContractSymbolsLoaded(assets.asValue!.value));
  }
}
