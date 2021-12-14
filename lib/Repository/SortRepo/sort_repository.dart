import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Model/ProfileModel/profile_model.dart';
import 'package:ezhyper/Model/SortModel/sort_model.dart';
import 'package:ezhyper/fileExport.dart';


class SortRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<SortModel> sort_products_fun(
      {String price, String rate , String most_selling , String unit_price }) async{
    Map<String, String> headers;
    if(price != null){
      headers = {
        'price' : price,
      };
    }else if(rate != null){
      headers = {
        "rate": rate,
      };
    }else if(most_selling != null){
      headers = {
        "most_selling": most_selling,
      };
    }else if( unit_price != null){
      headers = {
        "unit_price" : unit_price
      };
    }

    return NetworkUtil.internal().get(
        SortModel(), Urls.SORT_URL, headers: headers);
  }


}
final sort_repository = SortRepository();