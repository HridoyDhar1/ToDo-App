class NetworkResponse {


  final bool isSuccess;
  final int statusCode;
  dynamic responseData;
  String errorMessage;
NetworkResponse({
  required this.isSuccess,
this.errorMessage='Something went worng',
   this.responseData,
  required this.statusCode
});}