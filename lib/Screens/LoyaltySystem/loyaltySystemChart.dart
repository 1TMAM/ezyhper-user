import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:ezhyper/fileExport.dart';

import 'loyaltySystemPromoCode.dart';
class LayoutSystemChart extends StatefulWidget {
  final int reward_point;
  LayoutSystemChart({this.reward_point});
  @override
  _LayoutSystemChartState createState() => _LayoutSystemChartState();
}

class _LayoutSystemChartState extends State<LayoutSystemChart> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
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
                        child: translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) : Image.asset(
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
                          size:EzhyperFont.primary_font_size,
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
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(children: [
          Container(
            child: Center(
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:  Rabbet(
                      cutLength: 8,
                      child: Container(
                          color: Colors.white,
                          width: width*.85,
                          height: height*.7,
                          child: Column(
                            children: [
                              SizedBox(height: height*.01,),
                              dashedContainer(),
                              SizedBox(height: height*.08,),
                              MyText(text: translator.translate("You will get points when you constantly rating your purchases, and these points will help you get a discount on your next purchase"),size: height*.021),



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
  Widget promoCodeButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: whiteColor,
      onTap:
        (){
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return LoyaltySystemPromoCode();
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
          MyText(text: translator.translate("Promo Code" ) ,color: greyColor,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color:whiteColor,height: height*.002,)
        ],),),
    );
  }
  Widget pointsButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(splashColor: Colors.white,
      onTap: (){},
      child: Container(width: width*.4,
        child: Column(children: [
          MyText(text: translator.translate("Points") ,color: greenColor ,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color: greenColor,height: height*.002,)
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
  Widget dashedContainer(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DashedContainer(
      child: Container(
        child:  customChart(),
        height:height*.3,
        width:width*.8,
        decoration: BoxDecoration(color: whiteColor
            , borderRadius: BorderRadius.circular(10.0)),
      ),
      dashColor: greyColor,
      borderRadius: 10.0,
      dashedLength: 5.0,
      blankLength: 5.0,
      strokeWidth: 5.0,
    );

  }

  Widget customChart(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  PieChart(
      dataMap: {"e" : widget.reward_point.toDouble(), "c":  100.0 - widget.reward_point.toDouble()},
      animationDuration: Duration(milliseconds: 2000
         ),
      chartLegendSpacing: 10,
      chartRadius: MediaQuery.of(context).size.width / 2.0,
      colorList: [  greenColor, greenColor.withOpacity(.2)],
      initialAngleInDegree: 90,
      chartType: ChartType.ring,
      ringStrokeWidth: 12,
      centerText: translator.translate("Your Points"),
      legendOptions: LegendOptions(
        showLegendsInRow: false ,
        legendPosition: LegendPosition.right,
        showLegends: false ,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false ,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false ,
      ),
    ) ;

  }
}
