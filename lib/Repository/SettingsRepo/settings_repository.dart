

import 'package:ezhyper/Model/SettingsModel/settings_model.dart';
import 'package:ezhyper/fileExport.dart';

class SettingsRepository{

  Future<SettingsModel> get_app_settings() async{
    print("tok settings : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");
    Map<String, String> header={
      //'token' :  await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9yZWZyZXNoIiwiaWF0IjoxNjIxNzk0NzEzLCJuYmYiOjE2MjE3OTU3NjYsImp0aSI6Imx2UEJadWt1cmVwc0hQakIiLCJzdWIiOjUsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.RaZj3RGPbYHZ92hSKyXG584EFb2x1KBlQLCV-9_IcZc'

    };
    return NetworkUtil.internal().get(SettingsModel(), Urls.GET_APP_SETTINGS, headers: header);
  }
}
SettingsRepository settingsRepository = new SettingsRepository();