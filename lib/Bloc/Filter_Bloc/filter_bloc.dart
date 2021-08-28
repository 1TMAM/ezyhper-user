import 'package:ezhyper/Model/FilterModel/brand_model.dart';
import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Model/FilterModel/size_model.dart';
import 'package:ezhyper/Repository/FilterRepo/filter_repository.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class FilterBloc extends Bloc<AppEvent,AppState>{
  FilterBloc(AppState initialState) : super(initialState);
  BehaviorSubject<FilterModel> _filter_products_subject = new BehaviorSubject<FilterModel>();
  get filter_products_subject {
    return _filter_products_subject;
  }

  BehaviorSubject<BrandModel> _btand_subject = new BehaviorSubject<BrandModel>();
  get brand_subject {
    return _btand_subject;
  }
  BehaviorSubject<SizeModel> _size_subject = new BehaviorSubject<SizeModel>();
  get size_subject {
    return _size_subject;
  }

  void drainStream() {
    _filter_products_subject.value = null;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
/*    if(event is FilterProductsEvent){
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
        size_id: size
      );
      if(response.status == true){
        _filter_products_subject.sink.add(response);
        yield Done(model: response,indicator: 'filter');
      }else{
        yield ErrorLoading(response,indicator: 'filter');
      }
    }
    else*/

if(event is FilterBrandEvent){
      yield Loading();
      final response = await filter_repository.getBrandList();
      if (response.status == true) {
        print("brand_response : ${response}");
        _btand_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.status == false) {
        yield ErrorLoading(response);
      }
    }else if(event is FilterSizeEvent){
      yield Loading();
      final response = await filter_repository.getSizeList();
      if (response.status == true) {
        print("size_response : ${response}");
        _size_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.status == false) {
        yield ErrorLoading(response);
      }
    }
  }

}

final filter_bloc = FilterBloc(null);