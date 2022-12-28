import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'symbols_contract_state.dart';

class SymbolsContractCubit extends Cubit<SymbolsContractState> {
  SymbolsContractCubit() : super(SymbolsContractInitial());
}
