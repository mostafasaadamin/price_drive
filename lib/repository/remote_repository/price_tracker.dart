import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:get/get.dart' as get_it;
import 'package:http_client_helper/http_client_helper.dart';
import 'package:price_tracker/constants/constant_strings.dart';
import 'package:price_tracker/models/active_symbols.dart';
import 'package:price_tracker/models/symbol_contract.dart';
import 'package:price_tracker/models/error_handler.dart';
import 'package:price_tracker/models/market.dart';
import 'package:price_tracker/models/price.dart';
import 'package:web_socket_channel/io.dart';
import '../../constants/api_urls.dart';
abstract class IPriceTracker{
  Future<Result<Stream>> getAllActiveSymbols();
  Future<Result<Stream>> getAllContractsForSymbol(ActiveSymbol activeSymbol);
  Future<Result<Price>> getPriceDetails({required int marketId,required int assetsId});

}
@Singleton(as: IPriceTracker)
class FavouriteRepository implements IPriceTracker {
  @override
  Future<Result<Stream>> getAllContractsForSymbol(ActiveSymbol activeSymbol)async{
    final Uri uri = Uri(
      scheme: 'wss',
      host:'frontend.binaryws.com',
      path: '/websockets/v3',
      queryParameters: <String, dynamic>{
        'app_id':'1089',
        'l':'en',
        'brand':'binary',
      },
    );
    IOWebSocketChannel  _webSocketChannel = IOWebSocketChannel.connect(
      uri.toString(),
      pingInterval:const Duration(seconds: 3000) ,
    );

    final contractsForSymbolRequest = {
      "contracts_for": activeSymbol.symbol,
      "currency": "USD",
      "landing_company": "svg",
      "product_type": "basic"
    };

    _webSocketChannel.sink.add(utf8.encode(jsonEncode(contractsForSymbolRequest)));

    return Result.value(_webSocketChannel.stream);
  }

  @override
  Future<Result<Stream>> getAllActiveSymbols() async{
    final Uri uri = Uri(
      scheme: 'wss',
      host:'frontend.binaryws.com',
      path: '/websockets/v3',
      queryParameters: <String, dynamic>{
        'app_id':'1089',
        'l':'en',
        'brand':'binary',
      },
    );
    IOWebSocketChannel  _webSocketChannel = IOWebSocketChannel.connect(
      uri.toString(),
      pingInterval:const Duration(seconds: 3000) ,
    );
    _webSocketChannel.sink.add(utf8.encode(jsonEncode({"active_symbols": "brief", "product_type": "basic"})));

    return Result.value(_webSocketChannel.stream);
  }

  @override
  Future<Result<Price>> getPriceDetails({required int marketId,required int assetsId}) async{
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language':get_it.Get.locale==const Locale('ar')?'ar':'en',
      'Authorization':'Bearer '
    };

    Uri url=Uri.parse(Urls.baseURl+Urls.sessionDetails);
    try {
      Response? response= await HttpClientHelper.post(url,
          timeRetry:const Duration(milliseconds: 100),
          retries: 3,
          headers:requestHeaders ,
          timeLimit: const Duration(seconds: 5));

      if(response?.statusCode==ConstStrings.successCode||response?.statusCode==ConstStrings.successCode2){
        return  Result.value(Price());
      }else{
        var errorJson = jsonDecode(response!.body);
        ErrorHandler errorHandler=ErrorHandler.fromJson(errorJson);
        return  Result.error(errorHandler);
      }
    } on TimeoutException catch (_) {
      return  Result.error("Connection Error!!! ");
    }catch (e) {
      return  Result.error(e.toString());
    }
  }


}