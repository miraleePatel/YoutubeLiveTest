import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:async';
import '../Utils/constants.dart';




class APIManager {
  static String baseUrl = 'https://youtube.googleapis.com/youtube/v3/';

  /// Used to call post API method, pass the url and param for api call
  Future<dynamic> postAPICall(String url, Map param, {bool isLoaderShow = true}) async {
    /// print in debug mode
    if (kDebugMode) {
      print("Calling API: $url");
      print("Calling parameters: $param");
    }
    var responseJson;
    try {
      /// Show progress loader
      if (isLoaderShow) {
        showProgressIndicator();
      }
      /// call post api for given url and parameters
      var request = http.MultipartRequest("POST", Uri.parse(url));
      for (var item in param.keys) {
        request.fields[item] = param[item];
      }
      if (kDebugMode) {
        print(request.fields);
      }
      var getResponse = await request.send();
      var responseData = await http.Response.fromStream(getResponse);
      if (kDebugMode) {
        print("------------------------------ POST METHOD RESPONSE ------------------------------");
        print(" ${responseData.body}");
        print("----------------------------------------------------------------------------------");
      }

      /// Check api response and handle exception
      responseJson = _response(responseData);
    } on SocketException {
      /// Show error message on SocketException
      errorSnackBar(message: 'No Internet Connection');


    } on TimeoutException catch (_) {
      /// Throw error message on TimeoutException
      throw  errorSnackBar(message: 'Server Error');

    } finally {
      /// dismiss progress loader
      if (isLoaderShow) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  /// Used to call get API method, pass the url for api call
  ///
  /// `APIManager().getAPICall("https://.....");`
  Future<dynamic> getAPICall({required String url,required String accessToken,bool isLoaderShow = true}) async {
    /// print in debug mode
    if (kDebugMode) {
      print("Calling API: $url");
    }

    var responseJson;
    try {
      /// Show progress loader
      ///
      if (isLoaderShow) {
        showProgressIndicator();
      }
      // String accessToken = GetStorage().read(authToken) ?? "";
      print("auth token: $accessToken");
      /// Set header for send request
      var headers = accessToken == ""
          ? {
        "Accept": "application/json",
      }
          : {"Authorization": accessToken, 'Accept': 'application/json'};

      /// call post api for given url and parameters
      final response = await http
          .get(
        Uri.parse(url),
        headers: headers,
      )
          .timeout(
        const Duration(minutes: 2),
      )
          .onError(
            (error, stackTrace) {
          throw  errorSnackBar(message: 'No Internet Connection');
          // errorSnackBar(message: 'Server Down, Please try after some time!');

        },
      );

      /// print response body of api
      if (kDebugMode) {
        // ignore: prefer_interpolation_to_compose_strings
        print("\n-----------------------------------------------------------------------------------\n");
        print(response.request);
        log("GET METHOD RESPONSE --> ${response.body}\n-----------------------------------------------------------------------------------\n\n\n");
      }

      /// Check api response and handle exception
      responseJson = _response(response);
    } on SocketException {
      /// Show error message on SocketException
      Get.showSnackbar(errorSnackBar(message: 'No Internet Connection'));
      throw errorSnackBar(message :'No Internet Connection');
    } on TimeoutException catch (_) {
      /// Throw error message on TimeoutException
      throw  errorSnackBar(message: 'Server Error');
    } finally {
      /// Hide progress loader
      if (isLoaderShow) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }


  /// Check response status and handle exception
  dynamic _response(http.Response response) {
    print("${response.statusCode}");
    switch (response.statusCode) {

    /// Successfully get api response
      case 200:

        final Map<String, dynamic> responseJson = json.decode(
          response.body,
        );
        return responseJson;

    /// Successfully get api response
      case 201:
        final Map<String, dynamic> responseJson = json.decode(
          response.body,
        );
        return responseJson;


    /// Bad request need to check url
      case 400:
        return errorSnackBar(message: "Invalid request data");

    /// Authorisation token invalid
      case 403:
        return errorSnackBar(message: "Unauthorized access");


    /// Error occured while Communication with Server
      case 500:
        return errorSnackBar(message: "Unauthorized access");

      default:
        return errorSnackBar(message: "An error occurred while Communication with Server with StatusCode: ${response.statusCode}");

    }
  }
}
