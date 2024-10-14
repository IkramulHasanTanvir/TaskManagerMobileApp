class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  dynamic responseBody;
  String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseBody,
    this.errorMessage = 'Something went wrong',
  });
}
