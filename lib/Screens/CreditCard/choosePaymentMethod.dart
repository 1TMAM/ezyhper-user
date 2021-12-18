import 'package:ezhyper/Bloc/CreditCard_Bloc/creditCard_bloc.dart';
import 'package:ezhyper/Model/CreditCardModel/credit_card_list_model.dart';
import 'package:ezhyper/Screens/Wallet/walletScreen.dart';
import 'package:ezhyper/Widgets/cvv_dialog.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/cupertino.dart';
import 'package:ezhyper/Model/CreditCardModel/credit_card_list_model.dart' as card_list;

class ChoosePaymentMethod extends StatefulWidget {
  final String  route;
  ChoosePaymentMethod({this.route});
  @override
  _ChoosePaymentMethodState createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {

  var card_id;
  @override
  void initState() {
    creditCard_bloc.add(getAllCreditCard_click());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  WillPopScope(
              onWillPop: (){
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return widget.route == 'checkOut' ? CheckOutScreen():Wallet();
                    },
                    transitionsBuilder:
                        (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 0),
                  ),
                );
              },
              child: Directionality(
              textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
    child:Scaffold(
                backgroundColor: whiteColor,
                body: Container(
                  child: Column(
                    children: [topPart(),
                      Expanded(child: buildBody())],
                  ),
                ),
              ),
            ))));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(padding: EdgeInsets.only(right: width*.075,left: width*.075),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(height * .05),
                topLeft: Radius.circular(height * .05)),
            color: backgroundColor),
        child:   Padding(
          padding: EdgeInsets.only(top: width * 0.06),
          child:  BlocBuilder(
            bloc: creditCard_bloc,
            builder: (context,state){
              if(state is Loading){
                return Center(
                  child: SpinKitFadingCircle(color: greenColor),
                );
              }else if(state is Done){
                var data = state .model as CreditCardListModel;
                if(data.data ==null){
                  //return NoData(message: data.msg??'',);
                  return YouDontHavePaymentMethod();
                }else {
                  return StreamBuilder<card_list.CreditCardListModel>(
                      stream: creditCard_bloc.credit_card_list_subject,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.data == null) {
                            return YouDontHavePaymentMethod();
                          } else {
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(height * .05),
                                        topLeft: Radius.circular(height * .05)),
                                    color: backgroundColor),
                                child: Container(
                                  // padding: EdgeInsets.only(right: width * .075, left: width * .075),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          listViewOfPaymentCards(
                                              data: snapshot.data.data
                                          ),
                                        ],
                                      ),
                                    )));
                          }
                        } else {
                          return YouDontHavePaymentMethod();
                        }
                      });
                }
              }else if(state is ErrorLoading){
                return NoData(
                  message: state.message,
                );
              }

            },
          ),
        )


       );
  }
  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child: Container(
        child: Container(
          height: height * .10,
          color: whiteColor,
          padding: EdgeInsets.only(left: width * .03, right: width * .03, ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return widget.route == 'checkOut' ? CheckOutScreen():Wallet();
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
                      },
                      child: Container(
                        child: translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) :  Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: translator.translate("CHOOSE PAYMENT METHOD"),
                          size:  EzhyperFont.primary_font_size,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return ShoppingCart();
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
                },
                child: Container(
                  child: Image.asset(
                    "assets/images/cart.png",
                    height: height * .03,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget singlePaymentCard({card_list.Data cardModel , int index}){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String newNumber=cardModel.number;

    String replaceCharAt(String oldString, int index, String newChar) {
      return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
    }
    for(int i=4; i<cardModel.number.length;i++){
      newNumber = replaceCharAt(newNumber, i, "*") ;
    }
   // print("----------checked[index] : ${checked[index]}");

    return Container(
      child: Container(
        child: FittedBox(
          child: Container(margin: EdgeInsets.only(bottom: height*.015),
            width: width * .85,
            padding: EdgeInsets.only(right: width * .04, left: width * .02,top: height*.01),
            decoration: BoxDecoration(
              color:card_id == index?Colors.green.withOpacity(.2): whiteColor,
              border: Border.all(color:card_id == index? greenColor : backgroundColor),
              borderRadius: BorderRadius.all(
                Radius.circular(height * .02),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "${cardModel.holderName}",
                      size: height * .02,
                      color: greenColor,
                      weight: FontWeight.bold,
                    ),
                    Container(
                        child:card_id == index ? Image.asset(
                          "assets/images/check_circle.png",
                          height: height * .04,
                        ): SizedBox()
                    ),

                  ],
                ),
                SizedBox(
                  height: height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/visa_card.png",
                      height: height * .04,
                    ),
                    SizedBox(
                      height: width * .01,
                    ),
                    MyText(
                      text: "$newNumber",
                      size: height * .02,
                      weight: FontWeight.bold,
                    ),

                  ],
                ),


                SizedBox(
                  height: height * .01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget listViewOfPaymentCards({List<card_list.Data> data}){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return (
        Container(
            height: height*.75,
            child: ListView.builder(
            scrollDirection: Axis.vertical,
             physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            itemCount:data.length,
            itemBuilder: (BuildContext context, int index) {

              return Padding(
                padding: EdgeInsets.only(top: width * 0.02),
                child: InkWell(onTap: () {
                //  setState(() {
                     card_id = data[index].id;
                     sharedPreferenceManager.writeData(CachingKey.CARD_ID, card_id);
                    print("card_id : ${card_id}");
                      showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         if(widget.route == 'checkOut'){
                          Navigator.pushReplacement(
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
                           );

                         }else{
                           return CvvDialog(
                             route: widget.route,
                             context: context,
                           );
                         }


                       },
                     );
                   // CvvDialog();
               //   });
                },
                    child: singlePaymentCard(
                        cardModel: data[index],
                        index: data[index].id
                    )),
              );
            })));


  }
}
