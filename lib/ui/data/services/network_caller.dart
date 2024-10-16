import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_mobile_app/app.dart';
import 'package:task_manager_mobile_app/ui/controller/auth_controller.dart';
import 'package:task_manager_mobile_app/ui/data/models/network_response.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);

      final Response response = await get(uri);

      responsePrint(url, response);

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodeData['data'],
          );
        }
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodeData,
        );
      } else if (response.statusCode == 401) {
        _moveToSingIn();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Unauthorized user please sing in again');
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      responsePrint(url, response);
      requestBody(url, body!, headers);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodeData['data'],
          );
        }
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodeData,
        );
      } else if (response.statusCode == 401) {
        _moveToSingIn();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Unauthorized user please sing in again');
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void responsePrint(url, response) {
    debugPrint(
        'URL: $url BODY: ${response.body} STATUS CODE: ${response.statusCode}');
  }

  static void requestBody(url, Map<String, dynamic> body, Map<String, dynamic> headers) {
    debugPrint('REQUEST:\nURL: $url \nBODY: $body \n HEADERS: $headers');
  }

  static void _moveToSingIn() {
    Navigator.pushAndRemoveUntil(
      TaskManagerMobileApp.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const SingInScreen(),
      ),
      (p) => false,
    );
  }
}
