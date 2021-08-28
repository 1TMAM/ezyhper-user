import 'package:ezhyper/Bloc/CreditCard_Bloc/creditCard_bloc.dart';
import 'package:ezhyper/Model/CreditCardModel/credit_card_list_model.dart' as card_list;
import 'package:ezhyper/Model/CreditCardModel/credit_card_list_model.dart';
import 'package:ezhyper/Model/CreditCardModel/credit_card_model.dart';
import 'package:ezhyper/Repository/CreditCardRepo/credit_card_repository.dart';
import 'package:ezhyper/Screens/CreditCard/updatePaymentCard.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';

class AllAPaymentMethodsScreen extends StatefulWidget {
  @override
  _AllAPaymentMethodsScreenState createState() => _AllAPaymentMethodsScreenState();
}

class _AllAPaymentMethodsScreenState extends State<AllAPaymentMethodsScreen> {
  bool isSwitched = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    creditCard_bloc.add(getAllCreditCard_click());
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  NetworkIndicator(
        child: PageContainer(
            child:  WillPopScope(
              onWillPop: (){
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return CustomCircleNavigationBar(page_index: 4,);                    },
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
              child: Directionality(
              textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
    child:Scaffold(
                backgroundColor: whiteColor,
                body: Container(
                  child: Column(
                    children: [
                     topPart(),
                      Expanded(child: buildBody())],
                  ),
                ),
              ),
              ))
        ));
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
          padding: EdgeInsets.only(
            left: width * .075, right: width * .025, ),
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
                              return CustomCircleNavigationBar(page_index: 4,);                            },
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
                        child:  translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) :Image.asset(
                          translator.currentLanguage =='ar'? "assets/images/arrow_right.png" : "assets/images/arrow_left.png",                        height: height * .03,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: translator.translate( "payment_methods").toUpperCase(),
                          size: height * .016,
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
    )
    ;
  }



  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  BlocBuilder(
      cubit: creditCard_bloc,
      builder: (context,state){
        if(state is Loading){
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        }else if(state is Done){
          var data = state .model as CreditCardListModel;
          if(data.data ==null){
            return NoData(
              message: data.msg,
            );
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
                              padding: EdgeInsets.only(right: width * .075,
                                  left: width * .075),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    textSwipeLeft(),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    divider(),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    Container(
                                        child: swiper(
                                            data: snapshot.data.data)
                                    ),
                                    SizedBox(
                                      height: height * .04,
                                    ),
                                    addNewCreditCardButton(),
                                    SizedBox(
                                      height: height * .02,
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
    );
  }


  Widget divider() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * .003,
          width: width * .85,
          color: greyColor,
        ),
      ],
    );
  }

  Widget textSwipeLeft() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/swipe.png",
            height: height * .03,
          ),
          MyText(
              text: translator.translate('swipe'),
              size: height * .015,weight: FontWeight.bold,
              color: greyColor
          ),
        ],
      ),
    );
  }


  Widget swiper({List<card_list.Data> data}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  ListView.builder(
      itemCount: data.length,
      physics: NeverScrollableScrollPhysics(),

      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = data[index].id.toString();
        return Dismissible(

            key: Key(item),
            onDismissed: (direction) {
              setState(() {
                List<String> mList =  List<String>();
                mList.add(item);
                List<int> services_ids =
                mList.map((i) => int.parse(i)).toList();
                data.removeAt(index);
                creditCard_repository.delete_user_credit_card(
                  id: services_ids,
                );
              });

            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            child: Padding(
        padding: EdgeInsets.only(top: 5,bottom: 5),
        child:   singleAddressCard(
                cardModel: data[index],
            )));
      },

    );


  }


  Widget singleAddressCard({card_list.Data cardModel}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String newNumber=cardModel.number;

    String replaceCharAt(String oldString, int index, String newChar) {
      return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
    }
    for(int i=4; i<cardModel.number.length;i++){
      newNumber = replaceCharAt(newNumber, i, "*") ;
    }
    return Container(
      child: FittedBox(
        child: Container(
          width: width * .85,
          padding: EdgeInsets.only(right: width * .02, left: width * .02),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(height * .02),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: cardModel.holderName,
                    size: height * .02,
                    color: greenColor,
                    weight: FontWeight.bold,
                  ),
                  InkWell(
                    child:  Image.asset(
                      "assets/images/edit.png",
                      height: height * .04,
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return UpdatePaymentCard(
                             card: cardModel,
                            );
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
                  )
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
                    width: height * .01,
                  ),
                  MyText(
                    text: newNumber,
                    size: height * .0147,
                    color: greyColor,
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget addNewCreditCardButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            givenHeight: height * .07,

            givenWidth: width * .85,
            onTapFunction: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return
                      AddPaymentCard();
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
            text: translator.translate('add_payment_method'),
            fontSize:EzhyperFont.header_font_size,
            radius: height * .05,
          ),
        ],
      ),
    );
  }


}
