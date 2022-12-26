import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
abstract class IConnectionService {
  Future<bool> checkConnection();
}

@Singleton(as:IConnectionService)
class ConnectionService implements IConnectionService {
 @override
  Future<bool> checkConnection() async {
    var state = await Connectivity().checkConnectivity();
    if(state == ConnectivityResult.mobile || state == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('www.google.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }
}