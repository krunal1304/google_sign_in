
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'api_response_model.dart';
import 'package:http/http.dart' as http;

Future<ApiResponseModel> postApiCall(String url,Map<String, dynamic> body,BuildContext context) async {


  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No internet connection')),
    );
    return ApiResponseModel();
  }else{
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(body),
          headers: {'Content-Type': "application/json"});
      if (response.statusCode == 201) {
        return ApiResponseModel.fromJson(jsonDecode(response.body));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')),
        );
      }
      return ApiResponseModel();
    } catch (e) {
      return ApiResponseModel();
    }
  }



}
