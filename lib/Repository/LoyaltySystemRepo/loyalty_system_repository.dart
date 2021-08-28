
import 'package:dio/dio.dart';
import 'package:ezhyper/Model/LoyaltySystemModel/loyalty_system_model.dart';
import 'package:ezhyper/fileExport.dart';

class LoyaltySystemRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<LoyaltySystemModel> getLoyaltySystem() async{
    FormData formData = FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),

    });

    return NetworkUtil.internal().post(LoyaltySystemModel(), Urls.LOYALTY_SYSTEM, body: formData);
  }
}
LoyaltySystemRepository loyaltySystemRepository = new LoyaltySystemRepository();