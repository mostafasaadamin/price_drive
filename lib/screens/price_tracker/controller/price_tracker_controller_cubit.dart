import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:price_tracker/models/asset.dart';
import 'package:price_tracker/models/market.dart';
import 'package:price_tracker/models/price.dart';
import 'package:price_tracker/repository/remote_repository/price_tracker.dart';

part 'price_tracker_controller_state.dart';

@injectable
class PriceTrackerControllerCubit extends Cubit<PriceTrackerControllerState> {
  IPriceTracker trackerRepository;
  PriceTrackerControllerCubit(this.trackerRepository) : super(PriceTrackerControllerInitial());

  Future<void> getMarketsGroup() async {
      emit(MarketSpinnerLoading());
      final markets = await trackerRepository.getAllMarkets();
      if(markets.isError){
        emit(PriceTrackerError("Couldn't fetch Data !!!??"));
        return;
      }
      emit(MarketSpinnerLoaded(markets.asValue!.value));
  }

  Future<void> getAssetsGroup(int marketId) async {
      emit(AssetsSpinnerLoading());
      final assets = await trackerRepository.getAllAssetsByMarketId(marketId);
      if(assets.isError){
        emit(PriceTrackerError("Couldn't fetch Data !!!??"));
        return;
      }
      emit(AssetsSpinnerLoaded(assets.asValue!.value));
  }


  Future<void> getPriceDetails(int marketId,int assetsId) async {
      emit(PriceDataLoading());
      final priceDetails = await trackerRepository.getPriceDetails(marketId: marketId,assetsId: assetsId);
      if(priceDetails.isError){
        emit(PriceTrackerError("Couldn't fetch Data !!!??"));
        return;
      }
      emit(PriceDataLoaded(priceDetails.asValue!.value));
  }

}
