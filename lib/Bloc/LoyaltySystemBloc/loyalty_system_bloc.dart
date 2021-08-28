import 'package:ezhyper/Model/LoyaltySystemModel/loyalty_system_model.dart';
import 'package:ezhyper/Repository/LoyaltySystemRepo/loyalty_system_repository.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class LoyaltySystemBloc extends Bloc<AppEvent,AppState>{
  LoyaltySystemBloc(AppState initialState) : super(initialState);

  BehaviorSubject<LoyaltySystemModel> _loyalty_system_subject = BehaviorSubject<LoyaltySystemModel>();
  get loyalty_system_subject{
    return _loyalty_system_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is LoyaltySystemEvent){
      yield Loading(model: null,);
      final response = await loyaltySystemRepository.getLoyaltySystem();
      print("loyalty response : $response");
      if(response.status == true){
        _loyalty_system_subject.sink.add(response);
        sharedPreferenceManager.writeData(CachingKey.COUPON_IS_FRIST, response.data.isFirst);
        sharedPreferenceManager.writeData(CachingKey.USER_DEFAULT_LOCATION_ID, response.data.locations[0].id);

        yield Done(model:response,);
      }else if (response.status == false){
        yield ErrorLoading(response,);
      }

    }
  }

}
LoyaltySystemBloc loyaltySystemBloc = LoyaltySystemBloc(null);
