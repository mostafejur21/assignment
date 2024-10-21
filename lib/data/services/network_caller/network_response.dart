class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;

  NetworkResponse(this.isSuccess, this.statusCode, this.responseData);
}