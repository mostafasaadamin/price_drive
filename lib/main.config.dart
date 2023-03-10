// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'repository/remote_repository/price_tracker.dart' as _i5;
import 'screens/price_tracker/controller/active_symbols/active_symbols_controller_cubit.dart'
    as _i6;
import 'screens/price_tracker/controller/price_tracker/price_value_cubit.dart'
    as _i7;
import 'screens/price_tracker/controller/symbols_contract/symbols_contract_cubit.dart'
    as _i8;
import 'services/connection_service.dart' as _i3;
import 'services/message_service.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.IConnectionService>(_i3.ConnectionService());
  gh.singleton<_i4.IMessageService>(_i4.MessageService());
  gh.singleton<_i5.IPriceTracker>(_i5.FavouriteRepository());
  gh.factory<_i6.PriceTrackerControllerCubit>(
      () => _i6.PriceTrackerControllerCubit(get<_i5.IPriceTracker>()));
  gh.factory<_i7.PriceValueCubit>(
      () => _i7.PriceValueCubit(get<_i5.IPriceTracker>()));
  gh.factory<_i8.SymbolsContractCubit>(
      () => _i8.SymbolsContractCubit(get<_i5.IPriceTracker>()));
  return get;
}
