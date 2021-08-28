
import 'package:dio/dio.dart';
import 'package:ezhyper/Model/WalletModel/wallet_charge_model.dart';
import 'package:ezhyper/Model/WalletModel/wallet_model.dart';
import 'package:ezhyper/fileExport.dart';


class WalletRepository{
  Future<WalletModel> get_wallet_orders_history() async{
    Map<String, String> header={
      'token' :  await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
    };
    return NetworkUtil.internal().get(WalletModel(), Urls.GET_WALLET_ORDERS_HISTORY, headers: header);
  }


   Future<ChargeWalletModel> charge_wallet({int card_id, String cvv, String amount, })async{
    FormData formData=FormData.fromMap({
      'token' :  await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "card_id" : card_id,
      "cvv" : cvv,
      "amount":amount,
    });

    return NetworkUtil.internal().post(ChargeWalletModel(), Urls.CHARGE_WALLET,body: formData);
  }



}

WalletRepository walletRepository = new WalletRepository();