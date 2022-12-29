import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:price_tracker/models/active_symbols.dart';
import 'package:price_tracker/repository/remote_repository/price_tracker.dart';
import 'package:price_tracker/screens/price_tracker/controller/active_symbols/active_symbols_controller_state.dart';


@injectable
class PriceTrackerControllerCubit extends Cubit<PriceTrackerControllerState> {
  IPriceTracker trackerRepository;

  PriceTrackerControllerCubit(this.trackerRepository)
      : super(PriceTrackerControllerInitial());

  ActiveSymbol? _selectedActiveSymbols;
  ActiveSymbol? get selectedActiveSymbols => _selectedActiveSymbols;
  void setSelectedActiveSymbols(ActiveSymbol? activeSymbol) {
    _selectedActiveSymbols=activeSymbol;
  }

  Future<void> getActiveSymbolsGroup() async {
    emit(MarketSpinnerLoading());
    final markets = await trackerRepository.getAllActiveSymbols();
    if (markets.isError) {
      emit(PriceTrackerError("Couldn't fetch Data !!!??"));
      return;
    }
    emit(MarketSpinnerLoaded(markets.asValue!.value));
  }

}
