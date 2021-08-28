import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/widgets/customSubmitAndSaveButton.dart';
import 'package:ezhyper/Screens/OrdersScreen/ordersHistoryDetails.dart';
import 'package:ezhyper/Model/OrdersModel/order_model.dart' as order_model;

class OrderTrackScreen extends StatefulWidget {
  order_model.Data order;
  OrderTrackScreen({this.order});

  @override
  _OrderTrackScreenState createState() => _OrderTrackScreenState();
}

class _OrderTrackScreenState extends State<OrderTrackScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:Container(
        child: Column(
          children: [topPart(), Expanded(child: buildBody())],
        )),
      ),
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
              SizedBox(
                height: height * .02,
              ),
              shippingAddressAndOrderTrackCard(),
              SizedBox(
                height: height * .02,
              ),
              order_description_status()
            ],
          ),
        )
//

            ));
  }

  Widget shippingAddressAndOrderTrackCard() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
       /*     Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return OrderHistoryDetails();
                },
                transitionsBuilder: (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 10),
              ),
            );*/
          },
          child: Container(
            margin: EdgeInsets.only(bottom: height * .015),
            child: FittedBox(
              child: Row(
                children: [
                  Container(
                    width: width * .85,
                    padding:
                        EdgeInsets.only(right: width * .04, left: width * .04),
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
                              text: translator.currentLanguage == 'ar' ? "${widget.order.orderNum} # ${translator.translate("order")} " :
                              "${translator.translate("order")} #${widget.order.orderNum}",
                              size: EzhyperFont.primary_font_size,
                              color: blackColor,
                              weight: FontWeight.bold,
                            ),
//
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: translator.currentLanguage == 'ar'? MainAxisAlignment.start : MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Container(
                                  child: Image.asset(
                                "assets/images/pin.png",
                                height: height * .03,
                              )),
                            ),
                            SizedBox(width: width * 0.05,),
                            FittedBox(
                              child: Container(
                                alignment:  translator.currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
                                child: MyText(
                                  text:
                                      "${widget.order.user.address == null ? translator.translate("address") : widget.order.user.address}",
                                  size: EzhyperFont.primary_font_size,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                         
                            order_status(
                                status: widget.order == null
                                    ? ''
                                    : widget.order.status),
                            MyText(
                              text:
                                  "${widget.order == null ? '' : widget.order.date}",
                              size: EzhyperFont.primary_font_size,
                              color: greyColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget order_description_status() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Container(
            width: width * .85,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(height * .02))),
            child: Column(
              children: [
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * .04,
                    ),
                    Container(
                     // height: height * .55,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * .001,
                          ),
                        order_status_image(
                        status: widget.order == null ? '' : widget.order.status),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * .04,
                    ),
                    FittedBox(
                      child: Container(
                          padding: EdgeInsets.only(top: height * .0),
                       //   height: height * .6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * .03,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:  translator.currentLanguage == 'ar' ?  MainAxisAlignment.start: MainAxisAlignment.start,
                                  children: [
                                    MyText(text: translator.translate( "pending"), size: EzhyperFont.primary_font_size,weight: FontWeight.bold,),
                                  ],
                                ),
                                width: width * .5,
                              ),
                              FittedBox(
                                  child: Container(
                                      width: width * .5,
                                      child: MyText(
                                        text: translator.translate("Your Order is in the first stage, and we are waiting for the sellers to prepare it for you"),
                                        size:
                                            EzhyperFont.secondary_font_size,
                                        color: greyColor,
                                        align: TextAlign.start,
                                      ))),
                              SizedBox(
                                height: height * .03,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:  translator.currentLanguage == 'ar' ?  MainAxisAlignment.start: MainAxisAlignment.start,                              children: [
                                    MyText(
                                        text: translator.translate("prepare"),size: EzhyperFont.primary_font_size,weight: FontWeight.bold,),
                                  ],
                                ),
                                width: width * .5,
                              ),
                              FittedBox(
                                  child: Container(
                                      width: width * .5,
                                      child: MyText(
                                        text: translator.translate("Your Order Is Being Processed By The Seller, And Then It Will Be On The Way To You"),
                                        size:
                                            EzhyperFont.secondary_font_size,
                                        color: greyColor,
                                        align: TextAlign.start,
                                      ))),
                              SizedBox(
                                height: height * .04,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:  translator.currentLanguage == 'ar' ?  MainAxisAlignment.start: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: translator.translate("in_way"),
                                      size: EzhyperFont.primary_font_size,weight: FontWeight.bold,),
                                  ],
                                ),
                                width: width * .5,
                              ),
                              FittedBox(
                                  child: Container(
                                      width: width * .5,
                                      child: MyText(
                                        text:translator.translate( "There Isn't Much Left For You To Get Your Order, It Is On Its Way To You Now"),
                                        size:
                                            EzhyperFont.secondary_font_size,
                                        color: greyColor,
                                        align: TextAlign.start,
                                      ))),
                              SizedBox(
                                height: height * .04,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:  translator.currentLanguage == 'ar' ?  MainAxisAlignment.start: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: translator.translate( "delivered"),   size: EzhyperFont.primary_font_size,weight: FontWeight.bold),
                                  ],
                                ),
                                width: width * .5,
                              ),
                              FittedBox(
                                  child: Container(
                                      width: width * .5,
                                      child: MyText(
                                        text: translator.translate("Finally, Your Order Has Been Successfully Delivered, You Can Return The Order If It Has Any Problem"),
                                        size: EzhyperFont.secondary_font_size,
                                        color: greyColor,
                                        align: TextAlign.start,
                                      ))),
                              SizedBox(height: height * .01),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: width * .02,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .04,
                ),
              ],
            ),
          ),
        )
      ],
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
          padding: EdgeInsets.only(
            left: width * .075, right: width * .075,),
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
                          text:
                          "${translator.translate("ORDER Tracking" )} - #${widget.order == null ? '' : widget.order.orderNum}",
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

  Widget order_status({String status}) {
    double height = MediaQuery.of(context).size.height;

    switch (status) {
      case 'pending':
        return MyText(
          text: translator.translate("pending"),
          size: EzhyperFont.primary_font_size,
          color: Colors.yellow.shade400,
        );
        break;
      case 'accepted':
        return MyText(
          text: translator.translate("accepted"),
          size: EzhyperFont.primary_font_size,
          color: Colors.orange,
        );
        break;
      case 'canceled':
        return MyText(
          text: translator.translate("canceled"),
          size: EzhyperFont.primary_font_size,
          color: Colors.red,
        );
        break;
      case 'prepare':
        return MyText(
          text: translator.translate("prepare"),
          size: EzhyperFont.primary_font_size,
          color: Colors.blue,
        );
        break;
      case 'in_way':
        return MyText(
          text: translator.translate("in_way"),
          size: EzhyperFont.primary_font_size,
          color: Colors.greenAccent,
        );
        break;
      case 'delivered':
        return MyText(
          text: translator.translate("delivered"),
          size: EzhyperFont.primary_font_size,
          color: Colors.green,
        );
        break;
    }
  }

  Widget order_status_image({String status}) {
    double height = MediaQuery.of(context).size.height;

    switch (status) {
      case 'pending':
        return   Container(
          child: Image.asset(
            "assets/images/status_new.png",
            height: height * .59,
          ),
        );
        break;
      case 'accepted':
        return   Container(
          child: Image.asset(
            "assets/images/status_new.png",
            height: height * .59,
          ),
        );
        break;
      case 'canceled':
        return   Container(
          child: Image.asset(
            "assets/images/status_new.png",
            height: height * .59,
          ),
        );
        break;
      case 'prepare':
        return   Container(
          child: Image.asset(
            "assets/images/status_process.png",
            height: height * .59,
          ),
        );
        break;
      case 'in_way':
        return   Container(
          child: Image.asset(
            "assets/images/status_transit.png",
            height: height * .465,
          ),
        );
        break;
      case 'delivered':
        return   Container(
          child: Image.asset(
            "assets/images/status_delivered.png",
            height: height * .465,
          ),
        );
        break;
    }
  }
}
