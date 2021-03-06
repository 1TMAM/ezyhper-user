

import 'package:ezhyper/Model/SettingsModel/settings_model.dart';
import 'package:ezhyper/fileExport.dart';

class SettingsRepository {

  Future<SettingsModel> get_app_settings() async {
    print("tok settings : ${await sharedPreferenceManager.readString(
        CachingKey.AUTH_TOKEN)}");
    Map<String, String> header = {
      'token': await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
    };
    return NetworkUtil.internal().get(
        SettingsModel(), Urls.GET_APP_SETTINGS, headers: header);
  }

}
SettingsRepository settingsRepository = new SettingsRepository();