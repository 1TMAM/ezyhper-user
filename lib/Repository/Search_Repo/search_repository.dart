import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Model/ProfileModel/profile_model.dart';
import 'package:ezhyper/Model/SearchModel/search_model.dart';
import 'package:ezhyper/fileExport.dart';


class SearchRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<SearchModel> search_products_fun(
      {List<String> columns, List<String> operand  , List<String> column_values}) async{
    print("columns :  ${columns}");
    print("operand :  ${operand}");
    print("column_values :  ${column_values}");
    print("token :  ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");
    Map<String, String> headers = {
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      'columns[]' : columns.join(','),
      "operand[]": operand.join(','),
      "column_values[]": column_values.join(','),
    };
    return NetworkUtil.internal().get(
        SearchModel(), Urls.SEARCH_URL, headers: headers);
  }


}
final search_repository = SearchRepository();