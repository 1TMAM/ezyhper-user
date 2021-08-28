
import 'package:ezhyper/Model/OffersModel/offer_model.dart';
import 'package:ezhyper/fileExport.dart';

class OfferRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<OfferModel> getOffersList() async{

    Map<String, String> headers = {
      'lang': translator.currentLanguage,
    };
    return NetworkUtil.internal().get(OfferModel(), Urls.GET_ALL_OFFERS, headers: headers);
  }
}
OfferRepository offerRepository = new OfferRepository();