import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:get/get.dart' as get_it;
import 'package:http_client_helper/http_client_helper.dart';
import 'package:price_tracker/constants/constant_strings.dart';
import 'package:price_tracker/models/asset.dart';
import 'package:price_tracker/models/error_handler.dart';
import 'package:price_tracker/models/market.dart';
import 'package:price_tracker/models/price.dart';
import '../../constants/api_urls.dart';
abstract class IPriceTracker{
  Future<Result<List<Market>>> getAllMarkets();
  Future<Result<List<Assets>>> getAllAssetsByMarketId(int marketId);
  Future<Result<Price>> getPriceDetails({required int marketId,required int assetsId});

}
@Singleton(as: IPriceTracker)
class FavouriteRepository implements IPriceTracker {
  @override
  Future<Result<List<Assets>>> getAllAssetsByMarketId(int marketId)async{
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
        return  Result.value([]);
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

  @override
  Future<Result<List<Market>>> getAllMarkets() async{
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
        return  Result.value([]);
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