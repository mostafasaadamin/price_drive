import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:price_tracker/models/symbol_contract.dart';
import 'package:price_tracker/repository/remote_repository/price_tracker.dart';
import 'package:price_tracker/screens/price_tracker/controller/price_tracker/price_value_state.dart';

@injectable
class PriceValueCubit extends Cubit<PriceValueState> {
  IPriceTracker trackerRepository;

  PriceValueCubit(this.trackerRepository) : super(PriceValueInitial());


  Future<void> getPriceDetails({AvailableContract? contract}) async {
   emit(PriceDataLoading());
  final priceDetails = await trackerRepository.getPriceDetails(contract: contract,);
  if (priceDetails.isError) {
    emit(PriceDataError("Couldn't fetch Data !!!??"));
    return;
  }
   emit(PriceDataLoaded(priceDetails.asValue!.value));
}

}
