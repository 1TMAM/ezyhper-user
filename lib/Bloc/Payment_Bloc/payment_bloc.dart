import 'package:ezhyper/Model/WalletModel/wallet_model.dart';
import 'package:ezhyper/Repository/PaymentRepo/payment_repository.dart';
import 'package:ezhyper/Repository/WalletRepo/wallet_repository.dart';
import 'package:ezhyper/fileExport.dart';

import 'package:rxdart/rxdart.dart';

class PaymentBloc extends Bloc<AppEvent,AppState> with Validator{
  PaymentBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is PayByCreditCardEvent) {
      yield Loading(indicator: 'credit_card');
      final response = await paymentRepository.pay_by_credit_card(
         order_id: event.order_id,
        card_id: event.card_id,
        cvv: event.cvv,
        amount: event.amount,
      );
      if (response.status == true) {
        yield Done(model: response,indicator: 'credit_card');
      } else if (response.status == false) {
        yield ErrorLoading(response,indicator: 'credit_card');
      }
    }

    else if (event is PayByWalletEvent) {
      yield Loading(indicator: 'wallet_pay');
      final response = await paymentRepository.pay_by_wallet(
        order_id: event.order_id,
        amount: event.amount,
      );
      if (response.status == true) {
        yield Done(model: response,indicator: 'wallet_pay');
      } else if (response.status == false) {
        yield ErrorLoading(response,indicator: 'wallet_pay');
      }
    }else  if (event is ChargeWalletEvent) {
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
    }

  }

}

PaymentBloc paymentBloc = new PaymentBloc(null);