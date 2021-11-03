
import 'package:ezhyper/Bloc/Payment_Bloc/payment_bloc.dart';
import 'package:ezhyper/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:ezhyper/Model/PaymentModel/credit_card_pay_model.dart';
import 'package:ezhyper/Model/WalletModel/wallet_charge_model.dart';
import 'package:ezhyper/Screens/Wallet/walletScreen.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_bar/rating_bar.dart';

import 'error_dialog.dart';

class CvvDialog extends StatefulWidget {
  final String route;
  final int amount;
  final   BuildContext context;
  CvvDialog({this.route,this.amount,this.context});

  @override
  State<StatefulWidget> createState() {
    print("---amount --- : ${amount}");
    // TODO: implement createState
    return CvvDialogState();
  }
}

class CvvDialogState extends State<CvvDialog> with TickerProviderStateMixin{
  TextEditingController cvv_controller;
  String cvv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cvv_controller = new TextEditingController();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }
  AnimationController _loginButtonController;
  bool isLoading = false;

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<PaymentBloc, AppState>(
      bloc: paymentBloc,
      listener: (context,state){

        if(state is Loading){
          _playAnimation();
        }else if(state is Done){
          _stopAnimation();
          if(state.indicator == 'wallet_charge'){
            Navigator.pop(context);
            errorDialog(
                context: context,
                text: 'Congraulations, your Credit Charge through Credit Card occured Successfully ',

            );
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return Wallet();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 10),
              ),
            );


            sharedPreferenceManager.removeData(CachingKey.RECHARGE_AMOUNT);
            sharedPreferenceManager.removeData(CachingKey.CVV);
            sharedPreferenceManager.removeData(CachingKey.CARD_ID);


          }else if(state.indicator == 'credit_card'){
            var data= state.model as CreditCardPayModel;
            Navigator.pop(context);
            errorDialog(
                context: context,
                text: 'Congraulations, your payment process through '
                    'Credit Card occured Successfully \n #transaction_id : ${data.data.transactionId}',
            );
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return MyOrdersHistory();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 10),
              ),
            );
            sharedPreferenceManager.removeData(CachingKey.CARD_ID);
            sharedPreferenceManager.removeData(CachingKey.ORDER_ID);
            sharedPreferenceManager.removeData(CachingKey.PAYMENT_METHOD);
            sharedPreferenceManager.removeData(CachingKey.CVV);



          }

        }else if(state is ErrorLoading){
          _stopAnimation();
          if(state.indicator == 'wallet_charge'){
            var data = state.model as ChargeWalletModel;
            Navigator.pop(context);
            errorDialog(
                context: context,
                text: '${data.msg}',

            );
        /*    Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return Wallet();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 10),
              ),
            );*/
          }else{
            var data = state.model as CreditCardPayModel;
            Navigator.pop(context);
            errorDialog(
                context: context,
                text: '${data.msg}',
            );
           /* Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return CheckOutScreen();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 10),
              ),
            );*/
          }


        }
      },
      child: StatefulBuilder(
        builder: (context, setState) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Container(
            width: width,
            height: height / 2.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height*.1)
            ),
            child: AlertDialog(
              contentPadding: EdgeInsets.all(0.0),
              content:  SafeArea(
                child: SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: width,
                      height: height / 2.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.1)
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: width * 0.05),
                            alignment: Alignment.center,
                            child: Image.asset('assets/images/popup_cvv.png'),
                            width: width * 0.15,
                            height:  width * 0.15,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: width * 0.01),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: cvvTextField(),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: width * 0.05),
                                        child:  StaggerAnimation(
                                          titleButton: translator.translate("CONFIRM"),
                                          buttonController: _loginButtonController.view,
                                          onTap: () async{
                                            cvv = cvv_controller.text;
                                            if(cvv.isEmpty){
                                              Fluttertoast.showToast(
                                                  msg:
                                                  'Please Enter CVV ',
                                                  toastLength: Toast
                                                      .LENGTH_SHORT,
                                                  gravity:
                                                  ToastGravity
                                                      .BOTTOM,
                                                  timeInSecForIosWeb:
                                                  1,
                                                  backgroundColor:
                                                  Colors
                                                      .grey,
                                                  textColor:
                                                  Colors
                                                      .white,
                                                  fontSize:
                                                  16.0);
                                            }else{
                                              if(widget.route == 'checkOut'){
                                                sharedPreferenceManager.writeData(CachingKey.CVV, cvv);
                                                paymentBloc.add(PayByCreditCardEvent(
                                                  card_id: await sharedPreferenceManager.readInteger(CachingKey.CARD_ID),
                                                  order_id: await sharedPreferenceManager.readInteger(CachingKey.ORDER_ID),
                                                  amount: widget.amount.toString(),
                                                  cvv: await sharedPreferenceManager.readString(CachingKey.CVV),
                                                ));
                                              }else{
                                                sharedPreferenceManager.writeData(CachingKey.CVV, cvv);
                                                paymentBloc.add(
                                                    ChargeWalletEvent(
                                                    card_id: await sharedPreferenceManager.readInteger(CachingKey.CARD_ID),
                                                    amount: await sharedPreferenceManager.readString(CachingKey.RECHARGE_AMOUNT),
                                                  cvv: await sharedPreferenceManager.readString(CachingKey.CVV),
                                            ));

                                          }

                                          }
                                          },
                                        ),



                                      /*  CustomSubmitAndSaveButton(
                                          buttonText: translator.translate("CONFIRM"),
                                          btn_width: width * .55,
                                          onPressButton: ()async{
                                            cvv = cvv_controller.text;
                                            if(cvv.isEmpty){
                                              Fluttertoast.showToast(
                                                  msg:
                                                  'Please Enter CVV ',
                                                  toastLength: Toast
                                                      .LENGTH_SHORT,
                                                  gravity:
                                                  ToastGravity
                                                      .BOTTOM,
                                                  timeInSecForIosWeb:
                                                  1,
                                                  backgroundColor:
                                                  Colors
                                                      .grey,
                                                  textColor:
                                                  Colors
                                                      .white,
                                                  fontSize:
                                                  16.0);
                                            }else{
                                              if(widget.route == 'checkOut'){
                                                sharedPreferenceManager.writeData(CachingKey.CVV, cvv);
                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                    builder: (context)=> CheckOutScreen()
                                                ));
                                              }else{
                                                sharedPreferenceManager.writeData(CachingKey.CVV, cvv);
                                                walletBloc.add(ChargeWalletEvent(
                                                  card_id: await sharedPreferenceManager.readString(CachingKey.CARD_ID),
                                                  amount: await sharedPreferenceManager.readString(CachingKey.RECHARGE_AMOUNT),
                                                  cvv: await sharedPreferenceManager.readString(CachingKey.CVV),
                                                ));

                                              }

                                            }

                                          },
                                        )*/
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: width * 0.02),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: MyText(text: translator.translate("DISCARD"), size: height*.02,color: Colors.red.shade900,),
                                      ),
                                    )

                                  ],
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          );
        },
      ),
    );
  }

  Widget cvvTextField(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height*.07,
          width: width*.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height*.1)
          ),
          child: TextFormField(
            controller: cvv_controller,
            keyboardType: TextInputType.number,
            style: TextStyle(color:greyColor,fontSize: EzhyperFont.primary_font_size),
            obscureText: false,
            textAlign: translator.currentLanguage=='ar'? TextAlign.right : TextAlign.left,
            cursorColor: greyColor,
            decoration: InputDecoration(
              hintText: "Enter CVV *",
              hintStyle: TextStyle(color: Color(0xffA0AEC0).withOpacity(.8,),fontSize: height*.018,),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(height*.1),
                  borderSide: BorderSide(color: greyColor,width: height*.002)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height*.1),
                  borderSide: BorderSide(color:greyColor,width: height*.002)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height*.1),
                  borderSide: BorderSide(color: greenColor,width:height*.002)),),),),
      ],
    );
  }
}
