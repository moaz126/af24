/* import 'dart:convert';
import 'package:af24/api/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:streaming_plug/Models/SearchPageModel.dart';
import 'package:streaming_plug/api_services/urls.dart';

import '../Models/HomePageModel.dart';
import '../Screens/Widget/global_variable.dart';

class DataApiService {
  DataApiService._();

  static final DataApiService _instance = DataApiService._();

  static DataApiService get instance => _instance;

  Future getHomeContent() async {
    String url = baseUrl + url_login;
    print(url);
    print(CUSTOMER_TOKEN.value);
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (result['success']) {
        homePageContent = HomePageModel.fromJson(result['data']);
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getSearchContent(String userName) async {
    String url = baseUrl + searchContent;
    print(url);
    print(userName);
    print(CUSTOMER_TOKEN.value);
    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'value': userName,
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      final result = jsonDecode(response.body);
      if (result['success']) {
        searchModelContent = List<SearchPageModel>.from(
            result['data'].map((x) => SearchPageModel.fromJson(x)));
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
 */