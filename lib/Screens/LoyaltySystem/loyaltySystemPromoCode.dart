//import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:clipboard/clipboard.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:ezhyper/Bloc/LoyaltySystemBloc/loyalty_system_bloc.dart';
import 'package:ezhyper/Model/LoyaltySystemModel/loyalty_system_model.dart';
import 'package:ezhyper/Widgets/Shimmer/slider_shimmer.dart';
import 'package:ezhyper/Widgets/coupon_dialog.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';

import 'loyaltySystemChart.dart';



class LoyaltySystemPromoCode extends StatefulWidget {
  @override
  _LoyaltySystemPromoCodeState createState() => _LoyaltySystemPromoCodeState();
}

class _LoyaltySystemPromoCodeState extends State<LoyaltySystemPromoCode> {
  int reward_point;
  @override
  void initState() {
    reward_point = 0;
    loyaltySystemBloc.add(LoyaltySystemEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
        child:   Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:Container(
        child: Column(
          children: [
            topPart(),
            pointsAndPromoCodeRow(),SizedBox(height: height*.02),
            Expanded(child: buildBody())],
        ),
      ),)

    )));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(height * .05),
                topLeft: Radius.circular(height * .05)),
            color: backgroundColor),
        child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height*.05,),


                 mainContainer(),

                ],
              ),
            )
//

        ));
  }
  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child:  Container(
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
                          text: translator.translate("Loyalty System").toUpperCase(),
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
    )
   ;
  }
  Widget mainContainer(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder(
      cubit: loyaltySystemBloc,
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        } else if (state is Done) {
          var data = state .model as LoyaltySystemModel;
          if(data.data ==null){
            return NoData(
              message: data.msg,
            );
          }else {
          return StreamBuilder<LoyaltySystemModel>(
              stream: loyaltySystemBloc.loyalty_system_subject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data == null) {
                    return NoData();
                  } else {
                   reward_point = snapshot.data.data.rewardPoint;
                    if(reward_point >= 100){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CouponDialog(
                                  text: "Congratulations, you have earned more than 100 points, so you will get a 5% discount on your next purchase"
                              );
                            });
                      });
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(children: [
                          Container(
                            child: Center(
                              child: Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Rabbet(
                                      cutLength: 8,
                                      child: Container(
                                          color: Colors.white,
                                          width: width * .85,
                                          height: height * .7,
                                          child: Column(
                                            children: [
                                              SizedBox(height: height * .05,),
                                              Container(
                                                  child: Image.asset(
                                                      "assets/images/promo_code.png",
                                                      height: height * .15)),
                                              SizedBox(height: height * .03,),
                                              Container(
                                                height: width * 0.3,
                                                child: MyText(
                                                    text: translator.translate(
                                                        "Share the coupon and get 5% off your next purchase"),
                                                    size: 18),

                                              ),
                                              SizedBox(height: height * .03,),
                                              MyText(text: translator.translate(
                                                  "coupon code"),
                                                size: height * .025,
                                                color: greyColor,),
                                              SizedBox(height: height * .03,),
                                              MyText(text: "${snapshot.data.data
                                                  .promoCode ?? 0}",
                                                size: height * .04,
                                                weight: FontWeight.bold,),
                                              SizedBox(height: height * .03,),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    CustomButton(
                                                      givenHeight: height * .07,
                                                      givenWidth: width * .7,
                                                      onTapFunction: () {
                                                        WidgetsBinding.instance.addPostFrameCallback((_) async{
                                                          Clipboard.setData(
                                                              ClipboardData(
                                                                  text: snapshot.data.data.promoCode??'0')).then((value) {
                                                            final snackBar = SnackBar(
                                                              content: Text(
                                                                  translator.translate("Copied to Clipboard")),
                                                              backgroundColor: greenColor,

                                                            );
                                                            Scaffold.of(context).showSnackBar(snackBar);
                                                          });
                                                        });

                                                      },
                                                      text: translator
                                                          .translate("COPY"),
                                                      fontSize:
                                                          EzhyperFont
                                                              .header_font_size,
                                                      radius: height * .05,
                                                    ),
                                                  ],
                                                ),
                                              ),


                                            ],
                                          )),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          )

                        ],)


                      ],
                    );
                  }
                } else {
                  return Center(
                    child: SpinKitFadingCircle(color: greenColor),
                  );
                }
              });
        }
        } else if (state is ErrorLoading) {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        }else{
          return Container();
        }
      },
    );

  }
  Widget promoCodeButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(splashColor:whiteColor,
      onTap: (){

    },
      child: Container(width: width*.4,
      child: Column(children: [
        MyText(text: translator.translate("Promo Code") ,color: greenColor,size: height*.02,weight: FontWeight.bold,),
        Container(width: width*.4,color: greenColor,height: height*.002,)
      ],),),
    );
  }
  Widget pointsButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(splashColor: whiteColor,
      onTap: (){
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return LayoutSystemChart(
              reward_point: reward_point,
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
      child: Container(width: width*.4,
        child: Column(children: [
          MyText(text: translator.translate("Points") ,color: greyColor ,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color: whiteColor,height: height*.002,)
        ],),),
    );
  }
  Widget pointsAndPromoCodeRow(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(padding: EdgeInsets.only(left: width*.075,right: width*.075),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        promoCodeButton(),
       pointsButton()
      ],),
    );

  }
}
