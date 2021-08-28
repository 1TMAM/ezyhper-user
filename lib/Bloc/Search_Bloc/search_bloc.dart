import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Model/SearchModel/search_model.dart';
import 'package:ezhyper/Repository/FilterRepo/filter_repository.dart';
import 'package:ezhyper/Repository/Search_Repo/search_repository.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<AppEvent,AppState>{
  SearchBloc(AppState initialState) : super(initialState);
  BehaviorSubject<SearchModel> _search_products_subject = new BehaviorSubject<SearchModel>();
  get search_products_subject {
    return _search_products_subject;
  }


  void drainStream() {
    _search_products_subject.value = null;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is SearchProductsEvent){
      yield Loading(indicator: 'search');
      var response = await search_repository.search_products_fun(
          columns: event.columns,
          operand: event.operand,
          column_values: event.columns_values,
      );
      if(response.status == true){
        _search_products_subject.sink.add(response);

        yield Done(model: response,indicator: 'search');
      }else{
        yield ErrorLoading(response,indicator: 'search');
      }
    }
  }

}

final search_bloc = SearchBloc(null);