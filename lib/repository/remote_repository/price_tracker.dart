import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:price_tracker/models/active_symbols.dart';
import 'package:price_tracker/models/symbol_contract.dart';
import 'package:web_socket_channel/io.dart';

abstract class IPriceTracker {
  Future<Result<Stream>> getAllActiveSymbols();

  Future<Result<Stream>> getAllContractsForSymbol(ActiveSymbol activeSymbol);

  Future<Result<Stream>> getPriceDetails({AvailableContract? contract});
}

@Singleton(as: IPriceTracker)
class FavouriteRepository implements IPriceTracker {
  @override
  Future<Result<Stream>> getAllContractsForSymbol(
      ActiveSymbol activeSymbol) async {
    final Uri uri = Uri(
      scheme: 'wss',
      host: 'frontend.binaryws.com',
      path: '/websockets/v3',
      queryParameters: <String, dynamic>{
        'app_id': '1089',
        'l': 'en',
        'brand': 'binary',
      },
    );
    IOWebSocketChannel _webSocketChannel = IOWebSocketChannel.connect(
      uri.toString(),
      pingInterval: const Duration(seconds: 3000),
    );

    final contractsForSymbolRequest = {
      "contracts_for": activeSymbol.symbol,
      "currency": "USD",
      "landing_company": "svg",
      "product_type": "basic"
    };

    _webSocketChannel.sink
        .add(utf8.encode(jsonEncode(contractsForSymbolRequest)));

    return Result.value(_webSocketChannel.stream);
  }

  @override
  Future<Result<Stream>> getAllActiveSymbols() async {
    final Uri uri = Uri(
      scheme: 'wss',
      host: 'frontend.binaryws.com',
      path: '/websockets/v3',
      queryParameters: <String, dynamic>{
        'app_id': '1089',
        'l': 'en',
        'brand': 'binary',
      },
    );
    IOWebSocketChannel _webSocketChannel = IOWebSocketChannel.connect(
      uri.toString(),
      pingInterval: const Duration(seconds: 3000),
    );
    _webSocketChannel.sink.add(utf8.encode(
        jsonEncode({"active_symbols": "brief", "product_type": "basic"})));

    return Result.value(_webSocketChannel.stream);
  }

  @override
  Future<Result<Stream>> getPriceDetails({AvailableContract? contract}) async {
    final Uri uri = Uri(
      scheme: 'wss',
      host: 'frontend.binaryws.com',
      path: '/websockets/v3',
      queryParameters: <String, dynamic>{
        'app_id': '1089',
        'l': 'en',
        'brand': 'binary',
      },
    );
    IOWebSocketChannel _webSocketChannel = IOWebSocketChannel.connect(
      uri.toString(),
      pingInterval: const Duration(seconds: 3000),
    );
    print("contractType${contract?.contractType}");
    print("underlyingSymbol${contract?.underlyingSymbol}");
    final proposalRequest = {
      "proposal": 1,
      "subscribe": 1,
      "amount": 100,
      "basis": "payout",
      "contract_type": contract?.contractType,
      "currency": "USD",
      "duration": 1,
      "duration_unit": "m",
      "symbol": contract?.underlyingSymbol,
      "barrier": "+0.1"
    };

    _webSocketChannel.sink.add(utf8.encode(jsonEncode(proposalRequest)));

    return Result.value(_webSocketChannel.stream);
  }
}
