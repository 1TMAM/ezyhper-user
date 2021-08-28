

import 'package:ezhyper/Bloc/Order_Bloc/order_bloc.dart';
import 'package:ezhyper/Bloc/Sort_Bloc/sort_bloc.dart';
import 'package:ezhyper/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:ezhyper/Screens/Authentication/Guest/guest_verification_code.dart';
import 'file:///D:/Wothoq%20Tech/ezhyper/code/ezhyper/lib/Screens/Authentication/Guest/guest_registeration.dart';
import 'package:ezhyper/Screens/SortResultScreen/sort_result_screen.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';

class CustomComponents{

  static Future<bool> isFirstTime() async {
    bool isFirstTime = await sharedPreferenceManager.readBoolean(CachingKey.FRIST_TIME);
    if (isFirstTime != null && !isFirstTime) {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, true);
      return false;
    } else {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, false);
      return true;
    }
  }
  static Future<bool> isFirstLogin() async {
    bool isFirstLogin = await sharedPreferenceManager.readBoolean(CachingKey.FRIST_LOGIN);
    print("--- isFirstLogin ---- : ${isFirstLogin}");
    if (isFirstLogin != null && !isFirstLogin) {
      sharedPreferenceManager.writeData(CachingKey.FRIST_LOGIN, true);
      return true;
    } else {
      sharedPreferenceManager.writeData(CachingKey.FRIST_LOGIN, false);
      return false;
    }
  }

  static Future<bool> isLogout() async {
    bool is_Logout = await sharedPreferenceManager.readBoolean(CachingKey.LOGOUT);
    if (is_Logout != null &&  !is_Logout ) {
      sharedPreferenceManager.writeData(CachingKey.LOGOUT, true);
      return true;
    } else {
      sharedPreferenceManager.writeData(CachingKey.LOGOUT, false);
      return false;
    }
  }

  static Widget buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor:
                new AlwaysStoppedAnimation<Color>(greenColor),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }

  static Widget buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  static Widget buildEmptyListWidget(BuildContext context,String message) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/Splash_Screen/splash_screen.png'),
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              fit: BoxFit.fill,
            ),
            Text("$message",style: TextStyle(color: greenColor),),
          ],
        ));
  }

  static void filterByStatusBottomSheet({BuildContext context, List data,}) {
    String status = 'canceled';
    showModalBottomSheet<void>(
      context: context,
      shape: OutlineInputBorder(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StreamBuilder<String>(
          stream: orderBloc.radio_value,
          builder: (context,snapshot){
            return  Directionality(
                textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
                child:Container(
                height: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.only(top: 10),
                child:  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          RadioListTile(
                            value:data[index],
                            groupValue: orderBloc.radio_choosed_value.value,
                            onChanged: (value) {
                              if(value == translator.translate('all')){
                                orderBloc.selectRadioValue(null);
                              }else{
                                orderBloc.selectRadioValue(value);
                              }

                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>MyOrdersHistory()
                              ));

                            },
                            title: Text("${data[index]}",
                              textDirection: TextDirection.rtl,),
                            activeColor: greenColor,

                          ),

                          Divider(
                            color: Color(0xFFDADADA),
                          )
                        ],
                      );
                    }
                )));
          },
        );
        }

    );
  }
  static void walletAmountBottomSheet({BuildContext context, }) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width ;
    TextEditingController amount_controller = new TextEditingController();
    String amount ;
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return  Directionality(
              textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
              child:Container(
                height: width * 0.6,
                child:  Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
                        alignment: translator.currentLanguage =='ar'?Alignment.centerRight : Alignment.centerLeft,
                        child: Text(translator.translate("Recharge Wallet" ),style: TextStyle( fontSize: height * .020,
                          fontWeight: FontWeight.bold,),),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height*.07,
                              width: width*.85,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(height*.1)
                              ),
                              child: TextFormField(
                                controller: amount_controller,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color:greyColor,fontSize: EzhyperFont.primary_font_size),
                                obscureText: false,
                                textAlign: translator.currentLanguage=='ar'? TextAlign.right : TextAlign.left,
                                cursorColor: greyColor,
                                decoration: InputDecoration(
                                  hintText: "Enter Amount Of Charge *",
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
                        )

                /*        StreamBuilder<String>(
                          stream: walletBloc.recharge_amount,
                          builder: (context, snapshot) {
                            return CustomTextField(
                              secure: false,
                              onchange: walletBloc.recharge_amount_change,
                              hint: "Amount of Charge *",
                              inputType: TextInputType.name,
                              suffixIcon: null,
                              errorText: snapshot.error,
                            );
                          },
                        ),*/
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              givenHeight: height * .07,
                              givenWidth: width * .35,
                              onTapFunction:(){
                                Navigator.pop(context);
                              },
                              text: translator.translate("DISCARD"),
                              textColor: greenColor,
                              fontSize:EzhyperFont.header_font_size,
                              radius: height * .05,
                              buttonColor: whiteColor,
                            ),
                            SizedBox(
                              width: width * 0.2,
                            ),
                            CustomButton(
                              givenHeight: height * .07,
                              givenWidth: width * .35,
                              onTapFunction:(){
                                amount = amount_controller.text;
                                if(amount.isEmpty){
                                  Fluttertoast.showToast(
                                      msg:
                                      'Please Enter amount of charge  ',
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
                                  sharedPreferenceManager.writeData(CachingKey.RECHARGE_AMOUNT, amount);
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) {
                                        return ChoosePaymentMethod(
                                            route :'wallet'
                                        )
                                        ;
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
                                }


                              },
                              text: translator.translate("RECHARGE"),
                              fontSize:EzhyperFont.header_font_size,
                              radius: height * .05,
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }

    );
  }


  static void filterProductInfoBottomSheet({BuildContext context, List data,String page}) {
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return StreamBuilder<String>(
            stream: orderBloc.radio_value,
            builder: (context,snapshot){
              return  Directionality(
                  textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
                  child:Container(
                      height: MediaQuery.of(context).size.width ,
                      padding: EdgeInsets.only(top: 10),
                      child:  ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                RadioListTile(
                                  value:data[index],
                                  groupValue: orderBloc.radio_choosed_value.value,
                                  onChanged: (value) {
                                    print("value--- :${value}");
                                 switch(value){
                                      case 'Top Rated':
                                        sort_bloc.add(SortProductsEvent(
                                          rate: 'desc',
                                          type: 'Top Rated',
                                        ));
                                        break;
                                   case 'أعلى التقييمات':
                                     sort_bloc.add(SortProductsEvent(
                                       rate: 'desc',
                                       type: 'Top Rated',
                                     ));
                                     break ;
                                   case 'Most Selling':
                                        sort_bloc.add(SortProductsEvent(
                                          most_selling: 'desc',
                                          type: 'Most Selling',
                                        ));
                                        break;
                                   case 'الأكثر مبيعًا':
                                     sort_bloc.add(SortProductsEvent(
                                       most_selling: 'desc',
                                       type: 'Most Selling',
                                     ));
                                     break ;
                                   case 'price : low to high':
                                        sort_bloc.add(SortProductsEvent(
                                          price: 'asc',
                                          type: 'price : low to high',
                                        ));
                                        break;
                                   case 'السعر من الادنى للاعلى':
                                   sort_bloc.add(SortProductsEvent(
                                     price: 'asc',
                                     type: 'price : low to high',
                                   ));
                                   break ;
                                   case 'price : high to low':
                                     sort_bloc.add(SortProductsEvent(
                                       price: 'desc',
                                       type: 'price : high to low',
                                     ));
                                     break;
                                   case 'السعر الاعلى الى الادنى':
                                     sort_bloc.add(SortProductsEvent(
                                       price: 'desc',
                                       type: 'price : high to low',
                                     ));
                                     break ;


                                   case 'unit price : low to high':
                                     sort_bloc.add(SortProductsEvent(
                                       unit_price: 'asc',
                                       type: 'unit_price : low to high',
                                     ));
                                     break;
                                   case 'سعر الوحدة من الادنى للاعلى':
                                     sort_bloc.add(SortProductsEvent(
                                       price: 'asc',
                                       type: 'unit_price : low to high',
                                     ));
                                     break ;


                                   case 'unit price : high to low':
                                     sort_bloc.add(SortProductsEvent(
                                       price: 'desc',
                                       type: 'unit_price : high to low',
                                     ));
                                     break;
                                   case 'سعر الوحدة الاعلى الى الادنى':
                                     sort_bloc.add(SortProductsEvent(
                                       price: 'desc',
                                       type: 'unit_price : high to low',
                                     ));
                                     break ;


                                    }
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context)=>SortResultScreen()
                                    ));

                                  },
                                  title: Text("${data[index]}",
                                    textDirection: TextDirection.rtl,),
                                  activeColor: greenColor,

                                ),

                                Divider(
                                  color: Color(0xFFDADADA),
                                )
                              ],
                            );
                          }
                      )));
            },
          );
        }

    );
  }

  static void guestRegisterationBottomSheet({BuildContext context,GlobalKey<ScaffoldState> drawerKey}) {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0)
        ),
        ),
        builder: (BuildContext context) {
          return GuestRegisteration(
            drawerKey: drawerKey,
          );
        }

    );
  }

  static void guestVerificationCodenBottomSheet({BuildContext context,GlobalKey<ScaffoldState> drawerKey,String route}) {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0)
          ),
        ),
        builder: (BuildContext context) {
          return GuestVerificationCode(
            drawerKey: drawerKey,
            route: route,

          );
        }

    );
  }
}