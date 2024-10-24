import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todoapp/app.dart';
import 'package:todoapp/data/models/network_response.dart';
import 'package:todoapp/features/authentication/controller/auth_controller.dart';
import 'package:todoapp/features/todo/screens/LoginScreen/login_screen.dart';

class NetworkCall {
  static Future<NetworkResponse> getRequest({required url}) async {
    try {
      Uri uri = Uri.parse(url);
   
       Map<String,String>headers={

          'token': AuthController.accessTokenKey.toString()
      };
printRequest(url, null,headers );
      final Response response = await get(uri,headers: headers);

      printResponse(url, response);
      debugPrint(
          "URL: $url\nRESPONSE CODE: ${response.statusCode}\nBody: ${response.body}");

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          responseData: decodeData,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String,String>headers={
'Content-Type': 'application/json',
          'token': AuthController.accessTokenKey.toString()
      };
      // debugPrint(url);
printRequest(url, body,headers );
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
    
      );
      printRequest(url, body, response.headers);


      printResponse(url, response);
      debugPrint(
          "URL: $url\nRESPONSE CODE: ${response.statusCode}\nBody: ${response.body}");

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
              isSuccess: false,
              statusCode: response.statusCode,
              errorMessage: decodeData['data']);
        }
        return NetworkResponse(
          isSuccess: true,
          responseData: decodeData,
          statusCode: response.statusCode,
        );
      } 
      else if(response.statusCode==401){
        _moveToLogin();
         return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode,
            errorMessage: 'Unauthenticated'
            );
      }
      
      else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static void printRequest(
      String url, Map<String, dynamic>? body, Map<String, dynamic>? headers) {
    debugPrint(
        'REQUEST:\nURL: $url\nBODY: $body\nHEADERS: $headers');
  }

  static void printResponse(String url, Response response) {
    debugPrint(
        'URL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}');
  }
  static Future< void> _moveToLogin()async{
  await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(MyApp.navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>const LoginScreen()),(p)=>false,);
  }
}
