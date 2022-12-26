import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

abstract class IMessageService {
  void snackBarAlert<T>({required String? message, Color color = Colors.red});

  void noInternetConnectionAlert();
}

@Singleton(as: IMessageService)
class MessageService implements IMessageService {
  @override
  void snackBarAlert<T>({required String? message, Color color = Colors.red}) {
    final snackBar = SnackBar(
      content: Text(
        message ?? "",
        style: const TextStyle(color: Colors.white, fontFamily: "din"),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  @override
  void noInternetConnectionAlert() {
    Get.snackbar(
      "No Internet Connection",
      "Please check your internet connection",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }

}
