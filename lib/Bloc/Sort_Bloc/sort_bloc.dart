import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Model/SortModel/sort_model.dart';
import 'package:ezhyper/Repository/FilterRepo/filter_repository.dart';
import 'package:ezhyper/Repository/SortRepo/sort_repository.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class SortBloc extends Bloc<AppEvent,AppState>{
  SortBloc(AppState initialState) : super(initialState);
  BehaviorSubject<SortModel> _sort_products_subject = new BehaviorSubject<SortModel>();
  get sort_products_subject {
    return _sort_products_subject;
  }


  void drainStream() {
    _sort_products_subject.value = null;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is SortProductsEvent){
      var response;
      yield Loading(indicator: 'sort');
      switch(event.type){
        case 'Top Rated':
          response = await sort_repository.sort_products_fun(
              rate: event.rate,
          );
          break;
        case 'Most Selling':
          response = await sort_repository.sort_products_fun(
              most_selling: event.most_selling
          );
          break;
        case 'price : low to high':
          response = await sort_repository.sort_products_fun(
              price: event.price,
          );
          break;
        case 'price : high to low':
          response = await sort_repository.sort_products_fun(
            price: event.price,
          );
          break;
        case 'unit_price : low to high':
          response = await sort_repository.sort_products_fun(
            price: event.unit_price,
          );
          break;
        case 'unit_price : high to low':
          response = await sort_repository.sort_products_fun(
            price: event.unit_price,
          );
          break;

      }

      if(response.status == true){
        _sort_products_subject.sink.add(response);

        yield Done(model: response,indicator: 'sort');
      }else{
        yield ErrorLoading(response,indicator: 'sort');
      }
    }
  }

}

final sort_bloc = SortBloc(null);