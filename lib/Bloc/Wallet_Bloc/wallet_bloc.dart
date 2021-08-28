import 'package:ezhyper/Model/WalletModel/wallet_model.dart';
import 'package:ezhyper/Repository/WalletRepo/wallet_repository.dart';
import 'package:ezhyper/fileExport.dart';

import 'package:rxdart/rxdart.dart';

class WalletBloc extends Bloc<AppEvent,AppState> with Validator{
  WalletBloc(AppState initialState) : super(initialState);


  BehaviorSubject<WalletModel> _wallet_orders_history_subject = new BehaviorSubject<WalletModel>();
  get wallet_orders_history_subject {
    return _wallet_orders_history_subject;
  }

  final recharge_amount_controller = BehaviorSubject<String>();
  Function(String) get recharge_amount_change => recharge_amount_controller.sink.add;
  Stream<String> get recharge_amount => recharge_amount_controller.stream.transform(input_text_validator);

  void dispose(){
    _wallet_orders_history_subject.value =null;
  }
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is getWalletHistoryOrdersEvent) {
      yield Loading();
      final response = await walletRepository.get_wallet_orders_history();
      if (response.status == true) {
        _wallet_orders_history_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.status == false) {
        yield ErrorLoading(response);
      }
    }
    /*else  if (event is ChargeWalletEvent) {
      yield Loading(indicator: 'wallet_charge');
      final response = await walletRepository.charge_wallet(
        card_id: event.card_id,
        cvv: event.cvv,
        amount: event.amount

      );
      if (response.status == true) {
        yield Done(model: response,indicator: 'wallet_charge');
      } else if (response.status == false) {
        yield ErrorLoading(response,indicator: 'wallet_charge');
      }
    }*/

  }

}

WalletBloc walletBloc = new WalletBloc(null);