import 'package:ezhyper/Model/CategoryModel/category_model.dart';
import 'package:ezhyper/Model/CategoryModel/category_products_model.dart';
import 'package:ezhyper/Model/CategoryModel/second_lvel_subcategory_model.dart';
import 'package:ezhyper/Model/OffersModel/offer_model.dart';
import 'package:ezhyper/Repository/CategoryRepo/category_repository.dart';
import 'package:ezhyper/Repository/OfferRepo/offer_repository.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends Bloc<AppEvent, AppState> with Validator{
  CategoryBloc(AppState initialState) : super(initialState);

  BehaviorSubject<String> category_search_controller = BehaviorSubject<String>();
  Function(String) get category_search_change => category_search_controller.sink.add;
  Stream<String> get category_search => category_search_controller.stream.transform(input_text_validator);

  BehaviorSubject<CategoryModel> _category_subject = new BehaviorSubject<CategoryModel>();
  get categories_subject {
    return _category_subject;
  }

  BehaviorSubject<CategoryProductsModel> _category_product_subject = new BehaviorSubject<CategoryProductsModel>();
  get category_product_subject {
    return _category_product_subject;
  }
  BehaviorSubject<String> categories_search_value = new BehaviorSubject<String>();
  get get_categories_search_value{
    return categories_search_value;
  }

  BehaviorSubject<SecondLevelSubcategoryModel> _second_level_subcategory_subject = new BehaviorSubject<SecondLevelSubcategoryModel>();
  get second_level_subcategory_subject {
    return _second_level_subcategory_subject;
  }

  void drainStream() {
   // _category_subject.value = null;
   // _category_product_subject.value = null;
  }

  void dispose(){
   // categoryBloc.drainStream();
    //categoryBloc.dispose();

  }
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is getAllCategories) {
      print("1");
      yield Loading();
      final response = await categoryRepository.getCategoriesList();
      print("2");
      if (response.status == true) {
        print("3");
        print("cat_response : ${response}");
        _category_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.status == false) {
        print("4");
        yield ErrorLoading(response);
      }
    }
    else if(event is getSecondLevelSubcategoryEvent) {
      print("second_sub_category 1");
      yield Loading();
      final response = await categoryRepository.getSecondLevelSubcategoryList(
        subcategory_id: event.subcategory_id
      );
      print("second_sub_category 2");
      if (response.status == true) {
        print("second_sub_category 3");
        print("second_sub_category _response : ${response}");
        _second_level_subcategory_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.status == false) {
        print("second_sub_category 4");
        yield ErrorLoading(response);
      }
    }


  }

}

CategoryBloc categoryBloc = new CategoryBloc(null);
