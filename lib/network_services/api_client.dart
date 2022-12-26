import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import 'package:flutter/material.dart';
class CallAPI {
  dynamic get(String url, BuildContext context, {dynamic headers}) async {
    final ioc =  HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http =  IOClient(ioc);
    try{
     Response response = await http
        .get(Uri.parse(url), headers: {HttpHeaders.authorizationHeader: headers}).timeout(const Duration(seconds: 6000));
      if (response.statusCode == 401 ) {
    }
    return response;
    }
    catch(e)
    {
      debugPrint("${e.toString()}");
    }
  }
  dynamic post(String url, dynamic data, BuildContext context, dynamic headers) async {
    final ioc =  HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http =  IOClient(ioc);
    try{
      Response response = await http.post(Uri.parse(url),
          body: data, headers: {HttpHeaders.authorizationHeader: headers,
      }).timeout(const Duration(seconds: 6000));
      if (response.statusCode == 401  )  {
      }
      return response;
    }
    catch(e)
    {
      debugPrint("${e.toString()}");

    }

  }


}
