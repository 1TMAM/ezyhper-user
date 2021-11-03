import 'package:ezhyper/Model/CategoryModel/category_model.dart';
import 'package:ezhyper/Model/CategoryModel/category_products_model.dart';
import 'package:ezhyper/Model/CategoryModel/second_lvel_subcategory_model.dart';
import 'package:ezhyper/Model/ProductModel/product_model.dart';
import 'package:ezhyper/fileExport.dart';

class CategoryRepository {

  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<CategoryModel> getCategoriesList() async {
    Map<String, String> headers = {
      'lang': translator.currentLanguage,

    };
    return NetworkUtil.internal().get(
        CategoryModel(), Urls.GET_ALL_CATEGORIES, headers: headers);
  }


  Future<ProductModel> getCategoryProducts(
      {String category_id, int offset}) async {
    Map<String, String> headers = {
      'lang': translator.currentLanguage,
      'category_id': category_id,
      'offset': offset.toString()
    };
    return NetworkUtil.internal().get(
        ProductModel(), Urls.GET_CATEGORy_PRODUCTS, headers: headers);
  }

  Future<SecondLevelSubcategoryModel> getSecondLevelSubcategoryList(
      {int subcategory_id}) async {
    Map<String, String> headers = {
      'lang': translator.currentLanguage,
      'subcategory_id': subcategory_id.toString()
    };
    return NetworkUtil.internal().get(
        SecondLevelSubcategoryModel(), Urls.SECOND_LEVEL_SUBCATEGORY,
        headers: headers);
  }


  Future<ProductModel> getSecondLevelSubcategoryProducts(
      {String second_level_subcategory_id, int offset}) async {
    Map<String, String> headers = {
      'lang': translator.currentLanguage,
      'category_id': second_level_subcategory_id,
      'offset': offset.toString()
    };
    return NetworkUtil.internal().get(
        ProductModel(), Urls.GET_SECOND_LEVEL_SUBCATEGORY_PRODUCTS, headers: headers);
  }

}
CategoryRepository categoryRepository = new CategoryRepository();