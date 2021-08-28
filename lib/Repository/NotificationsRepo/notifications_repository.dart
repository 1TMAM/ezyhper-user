
import 'dart:convert';

import 'package:ezhyper/Model/NotificationsModel/notifications_model.dart';
import 'package:ezhyper/Model/OffersModel/offer_model.dart';
import 'package:ezhyper/fileExport.dart';

class NotificationsRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<NotificationsModel> getAllNotifications() async{
print("token ########: ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");
    Map<String, String> headers = {
      'lang': translator.currentLanguage,
         'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      //'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9yZWZyZXNoIiwiaWF0IjoxNjIxNzk0NzEzLCJuYmYiOjE2MjE3OTU3NjYsImp0aSI6Imx2UEJadWt1cmVwc0hQakIiLCJzdWIiOjUsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.RaZj3RGPbYHZ92hSKyXG584EFb2x1KBlQLCV-9_IcZc'
    };
    return NetworkUtil.internal().get(NotificationsModel(), Urls.GET_ALL_NOTIFICATIONS, headers: headers);
  }

  Future<NotificationsModel> remove_notification(List<int> id) async{

    Map<String, String> headers = {
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      // 'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9yZWZyZXNoIiwiaWF0IjoxNjIxNzk0NzEzLCJuYmYiOjE2MjE3OTU3NjYsImp0aSI6Imx2UEJadWt1cmVwc0hQakIiLCJzdWIiOjUsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.RaZj3RGPbYHZ92hSKyXG584EFb2x1KBlQLCV-9_IcZc',
    "ids" : id.join(','),
    };
    return NetworkUtil.internal().delete(NotificationsModel(), Urls.REMOVE_NOTIFICATIONS, headers: headers);
  }
}
NotificationsRepository notificationsRepository = new NotificationsRepository();