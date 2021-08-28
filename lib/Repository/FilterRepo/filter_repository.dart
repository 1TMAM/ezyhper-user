import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ezhyper/Model/FilterModel/brand_model.dart';
import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Model/FilterModel/size_model.dart';
import 'package:ezhyper/Model/ProductModel/product_model.dart';
import 'package:ezhyper/Model/ProfileModel/profile_model.dart';
import 'package:ezhyper/fileExport.dart';


class FilterRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<ProductModel> filter_products_fun(
      {double price_from, double price_to , int rate , List<int> categories_id,List<int> brand_id,List<int> size_id,int offset}) async{

    print("categories_id : ${categories_id}");
    print("brand_id : ${brand_id}");
    print("size_id : ${size_id}");
    print("price_from : ${price_from}");
    print("price_to : ${price_to}");
    print("rate : ${rate}");
    Map<String, String> headers;
     headers = {
      'price_from' : price_from.toString(),
      "price_to": price_to.toString(),
      "rate": rate.toString(),
      "category_ids[]": categories_id.join(','),
      "brands_ids[]" :brand_id.join(','),
      "sizes_ids[]" : size_id.join(','),
       "offset" : offset.toString()
    };

    categories_id[0]==0? headers.remove("category_ids[]"): null;
    brand_id[0]==0? headers.remove("brands_ids[]"): null;
    size_id[0]==0? headers.remove("sizes_ids[]"): null;
    rate ==0? headers.remove("rate"): null;
    price_to==0? headers.remove("price_to"): null;
    price_from==0? headers.remove("price_from"): null;

    return NetworkUtil.internal().get(
        ProductModel(), Urls.FILTER_URL, headers: headers);
  }

  Future<BrandModel> getBrandList() async{

    Map<String, String> headers = {
      'lang': translator.currentLanguage,

    };
    return NetworkUtil.internal().get(BrandModel(), Urls.GET_ALL_BRANDS, headers: headers);
  }

  Future<SizeModel> getSizeList() async{

    Map<String, String> headers = {
      'lang': translator.currentLanguage,

    };
    return NetworkUtil.internal().get(SizeModel(), Urls.GET_ALL_SIZE, headers: headers);
  }
}
final filter_repository = FilterRepository();