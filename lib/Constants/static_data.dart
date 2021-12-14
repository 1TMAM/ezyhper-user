import 'package:ezhyper/Model/ProductModel/product_model.dart';
import 'package:ezhyper/Model/SearchModel/search_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';

class StaticData {
  static String vistor_value;
  static String order_status = 'accepted';
  static var user_wallet_earnings ;
  static Address user_location;
  static String order_address = null;
  static double get_height(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return height;
  }

  static double get_width(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return width;
  }

  static int TOTAL_AMOUNT = 0;
  static int CART_ITEMS_NUMBER = 0;
  static List CART_IDS;
  static List<ProductModel> cartProductList = [];
  static shoppingCart(ProductModel cartProductDetailsHelper) {
    cartProductList.add(cartProductDetailsHelper);
  }


  static void Toast_Short_Message(String x){
    Fluttertoast.showToast(
        msg: x,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}


