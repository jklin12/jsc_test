import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:jsc_test/services/api_exeption.dart';
import 'package:jsc_test/services/base_api_service.dart';

import 'package:http/http.dart' as http;

class NewskApiService extends BaseApiService {
  @override
  Future getHeadlinesNewsResponse(String url) async {
    dynamic responseJson;
    try {
      var query = {"apiKey": apiKey, "country": "id"};
      var uri = Uri.http(baseUrl, url, query);
      if (kDebugMode) {
        print(uri.toString());
        print(uri.queryParametersAll.toString());
      }
      final response = await http.get(uri);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }
  @override
  Future getEverythingNewsResponse(String url) async {
    dynamic responseJson;
    try {
      var query = {"apiKey": apiKey, "q": "indonesia"};
      var uri = Uri.http(baseUrl, url, query);
      if (kDebugMode) {
        print(uri.toString());
        print(uri.queryParametersAll.toString());
      }
      final response = await http.get(uri);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }

   
}
