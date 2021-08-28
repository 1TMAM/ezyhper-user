import 'package:ezhyper/Model/ProductModel/product_model.dart';
import 'package:ezhyper/Model/ProductModel/product_model.dart' as product_model;
import 'package:ezhyper/Repository/CategoryRepo/category_repository.dart';
import 'package:ezhyper/Repository/FilterRepo/filter_repository.dart';
import 'package:ezhyper/Repository/ProductRepo/product_repository.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends Bloc<AppEvent, AppState> {
  ProductBloc(AppState initialState) : super(initialState);

  BehaviorSubject<List<product_model.Products>> _products_subject = new BehaviorSubject<List<product_model.Products>>();
  get products_subject {
    return _products_subject;
  }

  BehaviorSubject<List<product_model.Products>> _cat_products_subject = new BehaviorSubject<List<product_model.Products>>();
  get cat_products_subject {
    return _cat_products_subject;
  }

  BehaviorSubject<List<product_model.Products>> _purchased_products_subject = new BehaviorSubject<List<product_model.Products>>();
  get purchased_products_subject {
    return _purchased_products_subject;
  }
  BehaviorSubject<List<product_model.Products>> _related_products_subject = new BehaviorSubject<List<product_model.Products>>();
  get related_products_subject {
    return _related_products_subject;
  }
  BehaviorSubject<List<product_model.Products>> _most_sellingproducts_subject = new BehaviorSubject<List<product_model.Products>>();
  get most_sellingproducts_subject {
    return _most_sellingproducts_subject;
  }
  BehaviorSubject<List<product_model.Products>> _filter_products_subject = new BehaviorSubject<List<product_model.Products>>();
  get filter_products_subject {
    return _filter_products_subject;
  }
  BehaviorSubject<List<product_model.Products>> _recomended_products_subject = new BehaviorSubject<List<product_model.Products>>();
  get recomended_products_subject {
    return _recomended_products_subject;
  }

  @override
  void dispose() {
    // TODO: implement dispose
/*    _products_subject?.close();
    _recomended_products_subject?.close();
    _filter_products_subject?.close();
    _most_sellingproducts_subject?.close();
    _related_products_subject?.close();
    _purchased_products_subject?.close();
    _cat_products_subject?.close();

    _recommendedProducts_list?.clear();
    _purchasedProducts_list?.clear();
    _relatedProducts_list?.clear();
    _categoryProducts_list?.clear();
    _filterProducts_list?.clear();
    _mostSellingProducts_list?.clear();*/

  }
  final _recommendedProducts_list = <product_model.Products>[];
  final _purchasedProducts_list = <product_model.Products>[];
  final _relatedProducts_list = <product_model.Products>[];
  final _categoryProducts_list = <product_model.Products>[];
 List<product_model.Products>  _filterProducts_list = <product_model.Products>[];
  final _mostSellingProducts_list = <product_model.Products>[];
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is rateAndReview_click) {
      yield Loading();
      var response = await product_repository.productRateAndReviewFunc(
          value: event.value,
          product_id: event.product_id,
          using_experiences: event.using_experiences,
          product_quality: event.product_quality,
          delivery_time: event.delivery_time,
          comment: event.comment);
      if (response.status == true) {
        yield Done(model: response);
      } else {
        yield ErrorLoading(response);
      }
    }
    else if (event is getRecommendedProduct_click) {
      yield Loading();
      var response = await product_repository.getRecommendedProductList(
        offset: event.offset
      );
      if (response.status == true) {
        _recommendedProducts_list.addAll(response.data.products);

        _recomended_products_subject.sink.add(_recommendedProducts_list);
        print(
            "_recommended_products : ${_products_subject}");
        yield Done(model: response);
      } else {
        yield ErrorLoading(response);
      }
    }
    else if (event is getPurchasedProduct_click) {
      yield Loading();
      var response = await product_repository.get_purchase_list(
        offset: event.offset
      );
      if (response.status == true) {
        if(response.data==null){
        }else{
    _purchasedProducts_list.addAll(response.data.products);

    }

        _purchased_products_subject.sink.add(_purchasedProducts_list);
        print(
            "_purchased_products_subject : ${_purchased_products_subject}");
        yield Done(model: response);
      } else {
        yield ErrorLoading(response);
      }
    }
    else if (event is getRelatedProduct_click) {
      yield Loading();
      var response =
          await product_repository.get_releated_products(
            product_id: event.product_id,
            offset: event.offset
          );
      if (response.status == true) {
        _relatedProducts_list.addAll(response.data.products);

        _related_products_subject.sink.add(_relatedProducts_list);
        print(
            "_related_products_subject : ${_related_products_subject}");
        yield Done(model: response);
      } else {
        yield ErrorLoading(response);
      }
    }
    else if (event is getCategoryProducts) {
      print("1");
      yield Loading();
      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
        offset: event.offset
      );
      if (response.status == true) {
        _categoryProducts_list.addAll(response.data.products);
        _cat_products_subject.sink.add(_categoryProducts_list);
        print("_cat_products_subject: ${_cat_products_subject}");
        yield Done(model: response);
      } else if (response.status == false) {
        print("4");
        yield ErrorLoading(response);
      }
    }
    else if (event is FilterProductsEvent) {
      yield Loading(indicator: 'filter');
      List<int> category = new List<int>();
      category.add(event.categories_id);

      List<int> brand = new List<int>();
      brand.add(event.brand_id);

      List<int> size = new List<int>();
      size.add(event.size_id);

      var response = await filter_repository.filter_products_fun(
          price_from: event.price_from,
          price_to: event.price_to,
          rate: event.rate,
          categories_id: category,
          brand_id: brand,
          size_id: size,
        offset: event.offset
      );

      if (response.status == true) {
        if(response.data==null) {
          _filterProducts_list = [];
        }else {
          _filterProducts_list.addAll(response.data.products);
        }

          _filter_products_subject.sink.add(_filterProducts_list);
          yield Done(model: response, indicator: 'filter');
        
      } else {
        yield ErrorLoading(response, indicator: 'filter');
      }
    }

    else if (event is getMostSellingProduct_click) {
      yield Loading();
      var response = await product_repository.getMostSellingList(
          offset: event.offset
      );
      if (response.status == true) {
        _mostSellingProducts_list.addAll(response.data.products);
        _most_sellingproducts_subject.sink.add(_mostSellingProducts_list);
        print("_most_sellingproducts_subject : ${_most_sellingproducts_subject}");
        yield Done(model: response);
      } else {
        yield ErrorLoading(response);
      }
    }

  }
}

final product_bloc = ProductBloc(null);
