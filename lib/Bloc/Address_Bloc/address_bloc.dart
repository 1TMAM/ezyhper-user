import 'package:ezhyper/Model/AddressModel/address_list_model.dart';
import 'file:///D:/Wothoq%20Tech/ezhyper/code/ezhyper/lib/Repository/AddressRepo/address_repository.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class AddressBloc extends Bloc<AppEvent,AppState> with Validator{
  AddressRepository _addressRepository ;
  AddressBloc(this._addressRepository) : super(Start());

  final address_controller = BehaviorSubject<String>();
  final description_controller = BehaviorSubject<String>();


  Function(String) get address_change => address_controller.sink.add;
  Function(String) get description_change  => description_controller.sink.add;


  Stream<String> get address => address_controller.stream.transform(input_text_validator);
  Stream<String> get description => description_controller.stream.transform(input_text_validator);


  final BehaviorSubject<AddressListModel> _address_list_subject = BehaviorSubject<AddressListModel>();
  @override
  get subject {
    return _address_list_subject;
  }



  @override
  void drainStream() {
    _address_list_subject.value = null;
  }


 /* void get_addresses_list() async{
    var response =await address_repository.getAddressList();
    print('------------(response)---- : ${response}');
    _address_list_subject.sink.add(response);
  }*/

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is click){
      yield Loading(model: null);
      var response = await address_repository.add_user_location_func(
        address: address_controller.value,
        descriptions: description_controller.value,
        default_address: await sharedPreferenceManager.readInteger(CachingKey.DEFAULT_SHIPPING_ADDRESS)
      );

      if(response.status ==true){
        if(response.data.defaultAddress == "1"){
          print("guest location 1");
          sharedPreferenceManager.writeData(CachingKey.USER_DEFAULT_LOCATION_ID, response.data.id);
        }else{

        }
        yield Done(model:response);

      }else if (response.status == false){
        yield ErrorLoading(response);
        sharedPreferenceManager.removeData(CachingKey.MAPS_LAT);
        sharedPreferenceManager.removeData(CachingKey.Maps_lang);
      }
    }else if(event is addNewLocation){
      print("new loc id : ${await sharedPreferenceManager.readInteger(CachingKey.DEFAULT_SHIPPING_ADDRESS)}");
      yield Loading(model: null,indicator: 'addNewLocation');
      var response = await address_repository.add_user_location_func(
          address: address_controller.value,
          descriptions: description_controller.value,
          default_address: await sharedPreferenceManager.readInteger(CachingKey.DEFAULT_SHIPPING_ADDRESS)
      );

      if(response.status ==true){
        print("---- 1 --------");
        if(response.data.defaultAddress == "1"){
          print("eeeeeeeeee");
          sharedPreferenceManager.writeData(CachingKey.USER_DEFAULT_LOCATION_ID, response.data.id);
        }else{

        }
        yield Done(model:response,indicator: 'addNewLocation');

      }else if (response.status == false){
        yield ErrorLoading(response, indicator: 'addNewLocation');
        sharedPreferenceManager.removeData(CachingKey.MAPS_LAT);
        sharedPreferenceManager.removeData(CachingKey.Maps_lang);
      }
    }else if(event is updateLocation){
      yield Loading(model: null,indicator: 'updateLocation');
      var response = await address_repository.update_user_location_func(
          location_id: event.location_id,
          address: address_controller.value,
          descriptions: description_controller.value,
          default_address: await sharedPreferenceManager.readInteger(CachingKey.DEFAULT_SHIPPING_ADDRESS)
      );
      if(response.status ==true){
        if(response.data.defaultAddress == "1"){
          sharedPreferenceManager.writeData(CachingKey.USER_DEFAULT_LOCATION_ID, response.data.id);
        }else{

        }
        yield Done(model:response,indicator: 'updateLocation');
      }else if (response.status == false){
        yield ErrorLoading(response,indicator: 'updateLocation');
      }
    }else if(event is getAllAddresses_click){
      yield Loading();
      var response =await address_repository.getAddressList();
      if(response.status==true){
        _address_list_subject.sink.add(response);
        yield  Done(model: response);

      }else{
        yield   ErrorLoading(response);
      }

    }
  }

  @override
  void dispose() async{
    address_controller?.close();
    description_controller?.close();
    await _address_list_subject.drain();
    _address_list_subject.close();
  }


}
final address_bloc = new AddressBloc(null);