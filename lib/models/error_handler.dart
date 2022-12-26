class ErrorHandler {
  String? message;
  String? errors;

  ErrorHandler({this.message, this.errors});

  ErrorHandler.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['errors'] != null) {
      errors =null; ///json['errors'].toString();
    } else {
      errors = null;
    }
  }
}
