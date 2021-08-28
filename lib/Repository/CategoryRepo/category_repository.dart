import 'package:ezhyper/Model/CategoryModel/category_model.dart';
import 'package:ezhyper/Model/CategoryModel/category_products_model.dart';
import 'package:ezhyper/Model/ProductModel/product_model.dart';
import 'package:ezhyper/fileExport.dart';

class CategoryRepository {

  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<CategoryModel> getCategoriesList() async{

    Map<String, String> headers = {
      'lang': translator.currentLanguage,

    };
    return NetworkUtil.internal().get(CategoryModel(), Urls.GET_ALL_CATEGORIES, headers: headers);
  }



  Future<ProductModel> getCategoryProducts({String category_id,int offset}) async{

    Map<String, String> headers = {
      'lang': translator.currentLanguage,
      'category_id' : category_id,
      'offset':offset.toString()
    };
    return NetworkUtil.internal().get(ProductModel(), Urls.GET_CATEGORy_PRODUCTS, headers: headers);
  }
}
CategoryRepository categoryRepository = new CategoryRepository();