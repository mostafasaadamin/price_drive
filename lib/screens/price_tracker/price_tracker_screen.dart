import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:price_tracker/main.dart';
import 'package:price_tracker/models/symbol_contract.dart';
import 'package:price_tracker/screens/price_tracker/controller/price_tracker_controller_cubit.dart';
import 'package:price_tracker/screens/price_tracker/controller/price_value_cubit.dart';
import 'package:price_tracker/screens/price_tracker/controller/symbols_contract_cubit.dart';
import 'package:price_tracker/theme/app_theme.dart';
import 'package:price_tracker/theme/colors.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/active_symbols.dart';
import '../../models/price.dart';

class ScreenTracker extends StatelessWidget {
  const ScreenTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PriceTrackerControllerCubit>(),
        ),

        BlocProvider(
          create: (context) => getIt<SymbolsContractCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PriceValueCubit>(),
        ),
      ],
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _ScreenTrackerState();
}

class _ScreenTrackerState extends State<_Body> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final priceTrackerCubit = context.read<PriceTrackerControllerCubit>();
      priceTrackerCubit.getActiveSymbolsGroup();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          title: const Text("Price Tracker"),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(

            child: Column(
              children: [
                BlocBuilder<PriceTrackerControllerCubit,
                    PriceTrackerControllerState>(
                  builder: (context, state) {
                    if (state is MarketSpinnerLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MarketSpinnerLoaded) {
                      return  _MarketDropDownWidget(state.symbolsListener);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),

                const SizedBox(height: 25,),

                BlocBuilder<SymbolsContractCubit,
                    SymbolsContractState>(
                  builder: (context, state) {
                    if (state is ContractSymbolsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ContractSymbolsLoaded) {
                      return _SymbolContractsDropDownWidget(state.contractListener);
                    } else {
                      return  Center(
                        child: Container(),
                      );
                    }
                  },
                ),



                BlocBuilder<PriceValueCubit,
                    PriceValueState>(
                  builder: (context, state) {
                    if (state is PriceDataLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PriceDataLoaded) {
                      return _PriceStreamWidget(state.price);
                    } else {
                      return  Center(
                        child: Container(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MarketDropDownWidget extends StatelessWidget {
  Stream stream;

  _MarketDropDownWidget(this.stream);

  TextEditingController marketController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          List<ActiveSymbol> symbols = [];

          if (snapshot.hasData) {
            final response = jsonDecode(snapshot.data.toString());
            print("Symbols${response}");
            if (response!['active_symbols'] != null) {
              response['active_symbols'].forEach((v) {
             print("IsContains${symbols.contains(ActiveSymbol.fromJson(v))}");
               if(!symbols.contains(ActiveSymbol.fromJson(v))) {
                 symbols.add(ActiveSymbol.fromJson(v));
               }
              });
            }
          }
          return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: DropdownButtonFormField<ActiveSymbol>(
                value: context
                    .read<PriceTrackerControllerCubit>()
                    .selectedActiveSymbols,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
               style: AppTheme.lookUpTextStyle,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                hintText:"Symbol",
                label: Text("Symbol",
                  style: AppTheme.lookUpTextStyle,
                ),
              ),
                onChanged: (ActiveSymbol? newValue) {
                  context
                  .read<PriceTrackerControllerCubit>()
                  .setSelectedActiveSymbols(newValue);

                  context
                      .read<SymbolsContractCubit>()
                      .getContractForSymbol(newValue!);
                },
                items:symbols
                    .map<DropdownMenuItem<ActiveSymbol>>((ActiveSymbol value) {
                  return DropdownMenuItem<ActiveSymbol>(
                    value: value,
                    child: Text(value.marketDisplayName??""),
                  );
                }).toList(),
              ));
        });
  }
}

class _PriceStreamWidget extends StatelessWidget {
  Stream stream;

  _PriceStreamWidget(this.stream);

  TextEditingController marketController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          PriceProposal model;
          if (snapshot.hasData) {
            final response = jsonDecode(snapshot.data.toString());
             model=PriceProposal.fromJson(response["echo_req"]);
            return  Text("Current Price Is payout: \n ${model.payout} :\n askPrice: ${model.askPrice} Spot : \n ${model.spot}", style: const TextStyle(fontSize: 18));
          }else{
            return Container();
          }

        });
  }
}

class _SymbolContractsDropDownWidget extends StatelessWidget {
  Stream stream;

  _SymbolContractsDropDownWidget(this.stream);

  TextEditingController marketController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contractBloc=context
        .read<SymbolsContractCubit>();
     return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final response = jsonDecode(snapshot.data.toString());
            debugPrint("ResponseIS${response}");
            if (response!['contracts_for']['available'] != null) {
              response['contracts_for']['available'].forEach((v) {
               if(!contractBloc.symbolsContracts.contains(AvailableContract.fromJson(v))) {
                 contractBloc.symbolsContracts.add(AvailableContract.fromJson(v));
               }
              });
            }
          }
          return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: DropdownButtonFormField<AvailableContract>(
                value: context
                    .read<SymbolsContractCubit>()
                    .selectedSymbolContract,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
               style: AppTheme.lookUpTextStyle,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                hintText:"contract",
                label: Text("contract",
                  style: AppTheme.lookUpTextStyle,
                ),
              ),
                onChanged: (AvailableContract? newValue) {
                  context
                  .read<SymbolsContractCubit>()
                  .setSelectedSymbolContract(newValue);

                  context
                  .read<PriceValueCubit>()
                  .getPriceDetails(contract:newValue);
                },
                items:context
                    .read<SymbolsContractCubit>().symbolsContracts
                    .map<DropdownMenuItem<AvailableContract>>((AvailableContract value) {
                  return DropdownMenuItem<AvailableContract>(
                    value: value,
                    child: Text('${value.contractDisplay}, ${value.contractType}'),
                  );
                }).toList(),
              ));
        });
  }
}
