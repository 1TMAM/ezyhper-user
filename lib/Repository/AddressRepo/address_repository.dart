import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ezhyper/Model/AddressModel/address_list_model.dart';
import 'package:ezhyper/Model/AddressModel/address_model.dart';
import 'package:ezhyper/fileExport.dart';

class AddressRepository {
   Future<AddressModel> add_user_location_func({String address, int default_address , String descriptions})async{
     print("default_address : ${default_address}");
    FormData formData=FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      //'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxNjMxNTkwNSwiZXhwIjoxNjE2MzQxMTA1LCJuYmYiOjE2MTYzMTU5MDUsImp0aSI6IlBGMEFTNG1lY2xHMnRGTksiLCJzdWIiOjI0LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.-KkJ6DDX6ZFgmSphsn8dQxo5GuVTum02A8l1eLAQagA',
      "address" : address,
      "default_address" : default_address,
      "longitude" :  await sharedPreferenceManager.readDouble(CachingKey.Maps_lang),
      "latitude" :  await sharedPreferenceManager.readDouble(CachingKey.MAPS_LAT),
      "descriptions" : descriptions,

    });

    return NetworkUtil.internal().post(AddressModel(), Urls.ADD_USER_LOCATION,body: formData);
  }

   Future<AddressListModel> getAddressList() async{

      Map<String, String> headers = {
        'token': await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
       // 'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxNjMxNTkwNSwiZXhwIjoxNjE2MzQxMTA1LCJuYmYiOjE2MTYzMTU5MDUsImp0aSI6IlBGMEFTNG1lY2xHMnRGTksiLCJzdWIiOjI0LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.-KkJ6DDX6ZFgmSphsn8dQxo5GuVTum02A8l1eLAQagA',
      };
      return NetworkUtil.internal().get(AddressListModel(), Urls.GET_ADDRESS_LIST, headers: headers);
  }

   Future<AddressModel> delete_user_location_func({List<int> id})async{
    FormData formData=FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      //'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxNjMxNTkwNSwiZXhwIjoxNjE2MzQxMTA1LCJuYmYiOjE2MTYzMTU5MDUsImp0aSI6IlBGMEFTNG1lY2xHMnRGTksiLCJzdWIiOjI0LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.-KkJ6DDX6ZFgmSphsn8dQxo5GuVTum02A8l1eLAQagA',
      "ids" : json.encode(id),

    });

    return NetworkUtil.internal().post(AddressModel(), Urls.DELETE_USER_LOCATION,body: formData);
  }

   Future<AddressModel> update_user_location_func({String location_id,String address, int default_address , String descriptions})async{
    FormData formData=FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      //'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxNjMxNTkwNSwiZXhwIjoxNjE2MzQxMTA1LCJuYmYiOjE2MTYzMTU5MDUsImp0aSI6IlBGMEFTNG1lY2xHMnRGTksiLCJzdWIiOjI0LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.-KkJ6DDX6ZFgmSphsn8dQxo5GuVTum02A8l1eLAQagA',
      "address" : address,
      "default_address" : default_address,
      "longitude" :  await sharedPreferenceManager.readDouble(CachingKey.Maps_lang),
      "latitude" :  await sharedPreferenceManager.readDouble(CachingKey.Maps_lang),
      "descriptions" : descriptions,

    });

    return NetworkUtil.internal().post(AddressModel(), Urls.UPDATE_USER_LOCATION + '/${location_id}',body: formData);
  }
}
final address_repository = AddressRepository();