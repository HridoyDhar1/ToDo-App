import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todoapp/data/models/network_response.dart';

class NetworkCall {
  static Future<NetworkResponse> getRequest({required  url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);

      final Response response = await get(uri);

      printResponse(url, response);
      debugPrint("URL: $url\nRESPONSE CODE: ${response.statusCode}\nBody: ${response.body}");
      
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          responseData: decodeData,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest( {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);

      final Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      printResponse(url, response);
      debugPrint("URL: $url\nRESPONSE CODE: ${response.statusCode}\nBody: ${response.body}");

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if(decodeData['status']=='fail'){
          return NetworkResponse(isSuccess: false, statusCode: response.statusCode,errorMessage: decodeData['data']);
        }
        return NetworkResponse(
          isSuccess: true,
          responseData: decodeData,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static void printResponse(String url, Response response) {
    debugPrint('URL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}');
  }
}
