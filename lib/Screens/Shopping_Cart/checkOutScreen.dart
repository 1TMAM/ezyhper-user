import 'package:clippy_flutter/triangle.dart';
import 'package:ezhyper/Base/Database/DB_Helper.dart';
import 'package:ezhyper/Base/Database/Product.dart';
import 'package:ezhyper/Bloc/CreditCard_Bloc/creditCard_bloc.dart';
import 'package:ezhyper/Bloc/LoyaltySystemBloc/loyalty_system_bloc.dart';
import 'package:ezhyper/Bloc/Order_Bloc/order_bloc.dart';
import 'package:ezhyper/Bloc/Payment_Bloc/payment_bloc.dart';
import 'package:ezhyper/Model/AddressModel/address_model.dart';
import 'package:ezhyper/Model/OrdersModel/coupon_model.dart';
import 'package:ezhyper/Model/OrdersModel/make_order_model.dart';
import 'package:ezhyper/Model/PaymentModel/credit_card_pay_model.dart';
import 'package:ezhyper/Repository/PaymentRepo/payment_repository.dart';
import 'package:ezhyper/Widgets/cvv_dialog.dart';
import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ezhyper/Model/CreditCardModel/credit_card_list_model.dart' as card_list;
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;

class CheckOutScreen extends StatefulWidget {
  final String route;
  CheckOutScreen({this.route});
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen>
    with TickerProviderStateMixin {
  bool radioValue = false;
  bool show_location_confirmation = false;
  TextEditingController cupon_controller = TextEditingController();
  Future<List<Product>> cart_products;
  List<Product> product_Data;
  String group_value = 'Wallet';
  List<String> time;
  String selected_delivery_time;
  String selected_delivery_date;
  List<String> day_name;
  int day;
  String date;
  String week_day;
  String payment_type;
  List<int> product_ids;
  List<int> products_quantity;
  var cupon;
  GoogleMapController mapController;
  final LatLng _center = const LatLng(24.7241503,46.262039);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  @override
  void initState() {
    creditCard_bloc.add(getAllCreditCard_click());
    product_ids = [];
    products_quantity = [];
    payment_type = 'wallet';
    day_name = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];
    time = [
      "08:00 Am - 12:00 Am",
      "12:00 Pm - 04:00 Pm",
      "04:00 Pm - 08:00 Pm",
      "08:00 Pm - 12:00 Am"
    ];
    cart_products = DB_Helper.get_cart_products();
    product_Data = [];
    cart_products_data();

    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    super.initState();
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  var card_id;
  int select_time;
  int select_day;
  _onSelected_day(int index) {
    setState(() {
      select_day = index;
    });
  }

  _onSelected_time(int index) {
    setState(() {
      select_time = index;
    });
  }

  void cart_products_data() async {
    await cart_products.then((value) {
      //collect all IDs of cart products
      value.forEach((element) {
        product_ids.add(int.parse(element.prod_id));
      });
      //collect all quantity of cart products
      value.forEach((element) {
        products_quantity.add(element.prod_chossed_quantity);
      });
    });

    // get Invoice Summery frist time
    orderBloc.add(ApplyCouponEvent(
      cupon: "1",
      product_ids: product_ids,
      products_quantity: products_quantity,
    ));
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
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CustomCircleNavigationBar(
                      page_index: 3,
                    )));
      },
      child: NetworkIndicator(
          child: PageContainer(
              child: Scaffold(
        key: _drawerKey,
        backgroundColor: whiteColor,
        body: Container(
            child: Column(children: [
          topPart(),
          SizedBox(
            height: height * .0,
          ),
          Expanded(
              child: Container(
            color: backgroundColor,
            child: _buildBody(),
          ))
        ])),
      ))),
    );
  }

  _buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocListener<OrderBloc, AppState>(
        bloc: orderBloc,
        listener: (context, state) {
          if (state is Loading) {
            if (state.indicator == 'make_order') {
              _playAnimation();
            } else if (state.indicator == 'apply_coupon') {}
          } else if (state is Done) {
            if (state.indicator == 'make_order') {
              var data = state.model as MakeOrderModel;
              _stopAnimation();
              sharedPreferenceManager.writeData(
                  CachingKey.ORDER_ID, data.data.id);
              product_ids.forEach((element) {
                DB_Helper.delete_product(element);
              });
              if (payment_type == 'credit' || payment_type == 'mada') {
                // use apter make order for paying through credit card
                paymentRepository.hyperpay_payment(
                    order_id: data.data.id,
                    amount: data.data.total,
                    user_id: data.data.user.id,
                    context: context);
                /*         showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CvvDialog(
                        route: 'checkOut',
                        amount: data.data.total ,
                        context: context,
                      );
                    });*/

              } else {
                // use to make order for paying through Wallet
                paymentBloc.add(PayByWalletEvent(
                  //order_id: await sharedPreferenceManager.readInteger(CachingKey.ORDER_ID),
                  order_id: data.data.id,
                  amount: data.data.total.toString(), //order total
                ));
                _stopAnimation();
                Navigator.pop(context);
                errorDialog(
                  context: context,
                  text:
                      'Congraulations, your payment process through wallet occured Successfully ',
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
              }
            }
          } else if (state is ErrorLoading) {
            if (state.indicator == 'make_order') {
              if (payment_type == 'credit' || payment_type == 'mada') {
                var data = state.model as MakeOrderModel;
                _stopAnimation();
                errorDialog(
                    context: context,
                    text: '${data.msg}',
                    function: () {
                      Navigator.push(
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
                    });
              } else {
                _stopAnimation();
                var data = state.model as MakeOrderModel;
                errorDialog(
                    context: context,
                    text: '${data.errors}',
                    function: () {
                      Navigator.push(
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
                    });
              }
            }
            else if (state.indicator == 'apply_coupon') {
              _stopAnimation();
              var data = state.model as CouponModel;
              errorDialog(
                  context: context,
                  text: '${data.msg}',
                  function: () {
                    Navigator.push(
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
                  });
            }
          }
        },
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(left: width * .0, right: width * .0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(height * .05),
                    topLeft: Radius.circular(height * .05)),
                color: backgroundColor),
            child: Directionality(
                textDirection: translator.currentLanguage == 'ar'
                    ? ui.TextDirection.rtl
                    : ui.TextDirection.ltr,
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: height * .01,
                      ),

                      listOffCheckoutItems(),
                      SizedBox(
                        height: height * .01,
                      ),
                widget.route == 'guest_account'?      detect_guest_location(
                          name: 'islam',
                          lang: _center.longitude,
                          lat: _center.latitude
                                              ) : Container() ,
                      SizedBox(
                        height: height * .01,
                      ),
                      textSelectPaymentMethod(),
                      SizedBox(
                        height: height * .01,
                      ),

                      paymentMethodOptions(),
                      SizedBox(
                        height: height * .01,
                      ),

                      textChooseDeliveryDate(),
                      SizedBox(
                        height: height * .01,
                      ),

                      deliveryDateOptionsOptions(),
                      SizedBox(
                        height: height * .01,
                      ),

                      textChooseDeliveryTime(),
                      SizedBox(
                        height: height * .01,
                      ),

                      deliveryTimeOptionsOptions(),
                      SizedBox(
                        height: height * .01,
                      ),

                      textHaveADiscount(),
                      SizedBox(
                        height: height * .01,
                      ),

                      discountTextField(),
                      SizedBox(
                        height: height * .01,
                      ),
                      textInvoiceSummary(),
                      SizedBox(
                        height: height * .01,
                      ),
                      invoiceSummaryCard(),
                      paintZigZagShapeWithTriangles(),
                      SizedBox(
                        height: height * .01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: width * .1, left: width * .1),
                        child: StaggerAnimation(
                          titleButton: translator.translate("PAY NOW"),
                          buttonController: _loginButtonController.view,
                          onTap: () async {
                            int payment_method_id =
                                payment_type == 'credit' ? 1 : 2;
                            cupon = cupon_controller.text;
                            if (product_ids.isNotEmpty &&
                                products_quantity.isNotEmpty &&
                                selected_delivery_date != null &&
                                selected_delivery_time != null) {
                              orderBloc.add(MakeOrderEvent(
                                  location_id:
                                      await sharedPreferenceManager.readInteger(
                                          CachingKey.USER_DEFAULT_LOCATION_ID),
                                  cupon: cupon,
                                  payment_method_id: payment_method_id,
                                  product_ids: product_ids,
                                  products_quantity: products_quantity,
                                  selected_delivery_date:
                                      selected_delivery_date,
                                  selected_delivery_time:
                                      selected_delivery_time));
                            } else {
                              errorDialog(
                                  context: context,
                                  text: translator.translate(
                                      "please complete all require data"));
                            }
                          },
                        ),
                      ),

                      SizedBox(
                        height: height * .01,
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }

  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: translator.currentLanguage == 'ar'
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr,
        child: Container(
            child: Container(
          height: height * .10,
          color: whiteColor,
          padding: EdgeInsets.only(
            left: width * .03,
            right: width * .03,
          ),
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
                              return CustomCircleNavigationBar(
                                page_index: 3,
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
                      child: Container(
                        child: translator.currentLanguage == 'ar'
                            ? Image.asset(
                                "assets/images/arrow_right.png",
                                height: height * .03,
                              )
                            : Image.asset(
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
                      text: translator.translate("CHECKOUT"),
                      size: EzhyperFont.primary_font_size,
                      weight: FontWeight.bold,
                    )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return CustomCircleNavigationBar(
                          page_index: 3,
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
                child: Container(
                  child: Image.asset(
                    "assets/images/cart.png",
                    height: height * .03,
                  ),
                ),
              ),
            ],
          ),
        )));
  }

  Widget listOffCheckoutItems() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        width: width * .85,
        padding: EdgeInsets.only(left: width * .0, right: width * .0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height * .05)),
            color: whiteColor
        ),
        //  height: height * .4,
        child: FutureBuilder(
            future: cart_products,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) return new Container();
              product_Data = snapshot.data;
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: width * .075,
                        left: width * .075,
                        top: height * .02,
                        bottom: height * .02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(height * .05),
                            topRight: Radius.circular(height * .05)),
                        color: backgroundColor),
                    child: Container(
                      height: height * .035,
                      child: textItems(items: product_Data.length),
                    ),
                  ),
                  Container(
                    height: product_Data.length > 2 ? height * .4 : null,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: product_Data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {},
                              child:
                                  checkoutItem(product: product_Data[index]));
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget checkoutItem({Product product}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {},
            child: FittedBox(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(height * .1)),
                    color: whiteColor
                ),
                width: width * .85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        product.prod_pricture == null
                            ? Image.asset(
                                "assets/images/food5.png",
                                height: height * .1,
                                width: width * .22,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                product.prod_pricture,
                                height: height * .1,
                                width: width * .22,
                                fit: BoxFit.fill,
                              ),
                        Container(
                          margin: EdgeInsets.only(left: width * .01,right: width * .01),
                          height: height * .13,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                  child: Container(
                                width: StaticData.get_width(context) * 0.6,
                                child:      Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    children: [
                                Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                    alignment : translator.currentLanguage == 'ar' ?  Alignment.centerRight : Alignment.centerLeft,
                                    child: MyText(
                                    text: product.prod_name == null
                                        ? ''
                                        : product.prod_name,
                                    size: height * .02),
                        )])
                              )),
                              SizedBox(
                                height: height * .01,
                              ),
                              Container(
                                width: width * .55,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText(
                                        text: "${product.prod_chossed_quantity}    ×    ${product.prod_price_after_discount} ",
                                        size: height * .02
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: height * .02,
                      color: greyColor,
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget textItems({int items}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .03, left: width * .03),
          child: MyText(
              text: translator.currentLanguage == 'ar'
                  ? "${translator.translate("Items")} : (${items})   "
                  : "${translator.translate("Items")} : (${items})"),
        ),
      ],
    );
  }

  Widget textSelectPaymentMethod() {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .03, left: width * .03),
          child: MyText(text: translator.translate("Choose Payment Method")),
        ),
      ],
    );
  }

  Widget paymentMethodOptions() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FittedBox(
      child: Container(
        padding: EdgeInsets.only(right: width * .03, left: width * .03),
        color: whiteColor,
        width: width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Wallet',
                        groupValue: group_value,
                        onChanged: (value) {
                          group_value = value;
                          setState(() {
                            payment_type = value;
                            sharedPreferenceManager.writeData(
                                CachingKey.PAYMENT_METHOD, value);
                          });
                        },
                      ),
                      MyText(
                          text: translator.translate("Wallet Balance"),
                          size: height * .02,
                          color: greyColor),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'credit',
                        groupValue: group_value,
                        onChanged: (value) {
                          group_value = value;
                          setState(() {
                            sharedPreferenceManager.writeData(
                                CachingKey.PAYMENT_METHOD, value);
                            payment_type = value;

                            /*         showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.all(0.0),
                                    content:  show_credit_cards(),
                                  );
                                });*/
                          });
                        },
                      ),
                      MyText(
                          text: translator.translate("Credit Card"),
                          size: height * .02,
                          color: greyColor),
                    ],
                  ),
                ),
                MyText(
                  text: "*****123",
                  size: height * .015,
                  color: greyColor,
                )
              ],
            ),
     /*       Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'mada',
                        groupValue: group_value,
                        onChanged: (value) {
                          group_value = value;
                          setState(() {
                            sharedPreferenceManager.writeData(
                                CachingKey.PAYMENT_METHOD, value);
                            payment_type = value;

                            */
            /*          showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.all(0.0),
                                    content:  show_credit_cards(),
                                  );
                                });*/

            /*
                          });
                        },
                      ),
                      MyText(
                          text: translator.translate("mada"),
                          size: height * .02,
                          color: greyColor),
                    ],
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  Widget show_credit_cards() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.only(right: width * .075, left: width * .075),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(height * .05),
                topLeft: Radius.circular(height * .05)),
            color: backgroundColor),
        child: Padding(
          padding: EdgeInsets.only(top: width * 0.06),
          child: BlocBuilder(
            bloc: creditCard_bloc,
            builder: (context, state) {
              if (state is Loading) {
                return Center(
                  child: SpinKitFadingCircle(color: greenColor),
                );
              } else if (state is Done) {
                return StreamBuilder<card_list.CreditCardListModel>(
                    stream: creditCard_bloc.credit_card_list_subject,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.data == null) {
                          return NoData(
                            message: snapshot.data.msg,
                          );
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
                                            data: snapshot.data.data),
                                      ],
                                    ),
                                  )));
                        }
                      } else {
                        return NoData(
                          message: snapshot.data.msg,
                        );
                      }
                    });
              } else if (state is ErrorLoading) {
                return NoData(
                  message: state.message,
                );
              }
            },
          ),
        ));
  }

  Widget singlePaymentCard({card_list.Data cardModel, int index}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String newNumber = cardModel.number;

    String replaceCharAt(String oldString, int index, String newChar) {
      return oldString.substring(0, index) +
          newChar +
          oldString.substring(index + 1);
    }

    for (int i = 4; i < cardModel.number.length; i++) {
      newNumber = replaceCharAt(newNumber, i, "*");
    }
    // print("----------checked[index] : ${checked[index]}");

    return Container(
      child: Container(
        child: FittedBox(
          child: Container(
            margin: EdgeInsets.only(bottom: height * .015),
            width: width * .85,
            padding: EdgeInsets.only(
                right: width * .04, left: width * .02, top: height * .01),
            decoration: BoxDecoration(
              color:
              card_id == index ? Colors.green.withOpacity(.2) : whiteColor,
              border: Border.all(
                  color: card_id == index ? greenColor : backgroundColor),
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
                        child: card_id == index
                            ? Image.asset(
                          "assets/images/check_circle.png",
                          height: height * .04,
                        )
                            : SizedBox()),
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

  Widget listViewOfPaymentCards({List<card_list.Data> data}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return (Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: width * 0.02),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        card_id = data[index].id;
                        sharedPreferenceManager.writeData(
                            CachingKey.CARD_ID, card_id);
                        print("card_id : ${card_id}");
                        Navigator.pop(context);
                      });
                    },
                    child: singlePaymentCard(
                        cardModel: data[index], index: data[index].id)),
              );
            })));
  }

  Widget textChooseDeliveryDate() {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .03, left: width * .03),
          child: MyText(text: translator.translate("Choose Delivery Date")),
        ),
      ],
    );
  }

  Widget deliveryDateOptionsOptions() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    date = formatter.format(now);

    week_day = intl.DateFormat('EEEE').format(now);
    day = now.day;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    switch (week_day) {
      case 'Saturday':
        day_name = [
         translator.currentLanguage == 'ar'? 'السبت' :  'Saturday',
          translator.currentLanguage == 'ar'? 'الاحد' :  'Sunday',
          translator.currentLanguage == 'ar'? 'الاثنين' :  'Monday',
          translator.currentLanguage == 'ar'? 'الثلاثاء' :  'Tuesday',
          translator.currentLanguage == 'ar'? 'الاربعاء' :   'Wednesday',
          translator.currentLanguage == 'ar'? 'الخميس' :   'Thursday',
          translator.currentLanguage == 'ar'? 'الجمعة' :   'Friday'
        ];
        break;
      case 'Sunday':
        day_name = [
          translator.currentLanguage == 'ar'? 'الاحد' :   'Sunday',
          translator.currentLanguage == 'ar'? 'الاثنين' :    'Monday',
          translator.currentLanguage == 'ar'? 'الثلاثاء' :    'Tuesday',
          translator.currentLanguage == 'ar'? 'الاربعاء' :   'Wednesday',
          translator.currentLanguage == 'ar'? 'الخميس' :   'Thursday',
          translator.currentLanguage == 'ar'? 'الجمعة' :   'Friday',
          translator.currentLanguage == 'ar'? 'السبت' :   'Saturday'
        ];
        break;
      case 'Monday':
        day_name = [
          translator.currentLanguage == 'ar'? 'الاثنين' :   'Monday',
          translator.currentLanguage == 'ar'? 'الثلاثاء' :   'Tuesday',
          translator.currentLanguage == 'ar'? 'الاربعاء' :  'Wednesday',
          translator.currentLanguage == 'ar'? 'الخميس' :    'Thursday',
          translator.currentLanguage == 'ar'? 'الجمعة' :   'Friday',
          translator.currentLanguage == 'ar'? 'السبت' :   'Saturday',
          translator.currentLanguage == 'ar'? 'الاحد' :   'Sunday'
        ];
        break;
      case 'Tuesday':
        day_name = [
          translator.currentLanguage == 'ar'? 'الثلاثاء' :   'Tuesday',
          translator.currentLanguage == 'ar'? 'الاربعاء' :   'Wednesday',
          translator.currentLanguage == 'ar'? 'الخميس' :   'Thursday',
          translator.currentLanguage == 'ar'? 'الجمعة' :    'Friday',
          translator.currentLanguage == 'ar'? 'السبت' :    'Saturday',
          translator.currentLanguage == 'ar'? 'الاحد' :   'Sunday',
          translator.currentLanguage == 'ar'? 'الاثنين' :    'Monday'
        ];
        break;
      case 'Wednesday':
        day_name = [
          translator.currentLanguage == 'ar'? 'الاربعاء' :   'Wednesday',
          translator.currentLanguage == 'ar'? 'الخميس' :    'Thursday',
          translator.currentLanguage == 'ar'? 'الجمعة' :   'Friday',
          translator.currentLanguage == 'ar'? 'السبت' :   'Saturday',
          translator.currentLanguage == 'ar'? 'الاحد' :   'Sunday',
          translator.currentLanguage == 'ar'? 'الاثنين' :    'Monday',
          translator.currentLanguage == 'ar'? 'الثلاثاء' :   'Tuesday'
        ];
        break;
      case 'Thursday':
        day_name = [
          translator.currentLanguage == 'ar'? 'الخميس' :   'Thursday',
          translator.currentLanguage == 'ar'? 'الجمعة' :   'Friday',
          translator.currentLanguage == 'ar'? 'السبت' :   'Saturday',
          translator.currentLanguage == 'ar'? 'الاحد' :   'Sunday',
          translator.currentLanguage == 'ar'? 'الاثنين' :   'Monday',
          translator.currentLanguage == 'ar'? 'الثلاثاء' :   'Tuesday',
          translator.currentLanguage == 'ar'? 'الاربعاء' :   'Wednesday'
        ];
        break;
      case 'Friday':
        day_name = [
          translator.currentLanguage == 'ar'? 'الجمعة' :   'Friday',
          translator.currentLanguage == 'ar'? 'السبت' :   'Saturday',
          translator.currentLanguage == 'ar'? 'الاحد' :    'Sunday',
          translator.currentLanguage == 'ar'? 'الاثنين' :    'Monday',
          translator.currentLanguage == 'ar'? 'الثلاثاء' :   'Tuesday',
          translator.currentLanguage == 'ar'? 'الاربعاء' :  'Wednesday',
          translator.currentLanguage == 'ar'? 'الخميس' :   'Thursday',
        ];
        break;
    }

    return Container(
        padding: EdgeInsets.only(right: width * .03, left: width * .03),
        color: whiteColor,
        width: width,
        height: height * .15,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: day_name.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String next_day;
              next_day = index == 0 ? day.toString() : (day + index).toString();

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _onSelected_day(index);
                      selected_delivery_date =
                          formatter.format(now.add(Duration(days: index)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            text: "${day_name[index]}",
                            size: height * .018,
                            color: select_day == index ? greenColor : greyColor,
                            weight: FontWeight.bold,
                          ),
                          MyText(
                            text: '${next_day}',
                            size: height * .018,
                            color: select_day == index ? greenColor : greyColor,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      height: height * .1,
                      width: width * .2,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  select_day == index ? greenColor : greyColor,
                              width: height * .002),
                          color: whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(height * .01),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width * .02,
                  ),
                ],
              );
            }));
  }

  Widget detect_guest_location({String name, double lat, double lang}) {
    double width = MediaQuery.of(context).size.width;
    return BlocListener<AddressBloc, AppState>(
        bloc: address_bloc,
        listener: (context, state) async {
          var data = state.model as AddressModel;
          if (state is Loading) {
            _playAnimation();
          } else if (state is Done) {
            _stopAnimation();
            setState(() {
              show_location_confirmation = false;
            });
            sharedPreferenceManager.removeData(CachingKey.Maps_lang);
            sharedPreferenceManager.removeData(CachingKey.MAPS_LAT);
            loyaltySystemBloc.add(LoyaltySystemEvent()); // get all user data

          } else if (state is ErrorLoading) {
            _stopAnimation();
            var error;
            if (data.errors.address != null) {
              error = data.errors.address[0];
            } else if (data.errors.latitude != null) {
              error = data.errors.latitude[0];
            } else if (data.errors.longitude != null) {
              error = data.errors.longitude[0];
            }
            Flushbar(
              messageText: Row(
                children: [
                  Text(
                    '${error}',
                    textDirection: ui.TextDirection.rtl,
                    style: TextStyle(color: whiteColor),
                  ),
                  Spacer(),
                  Text(
                    translator.translate("Try Again"),
                    textDirection: ui.TextDirection.rtl,
                    style: TextStyle(color: whiteColor),
                  ),
                ],
              ),
              flushbarPosition: FlushbarPosition.BOTTOM,
              backgroundColor: redColor,
              flushbarStyle: FlushbarStyle.FLOATING,
              duration: Duration(seconds: 6),
            )..show(_drawerKey.currentState.context);
          }
        },
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.only(right: width * .03, left: width * .03),
                child: MyText(text: "Choose Delivery Location"),
              ),
            ]),
            Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 1.5,
                      color: whiteColor,
                      child: GoogleMap(
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        onMapCreated: _onMapCreated,
                        markers: Set<Marker>.of(markers.values),
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, lang),
                          zoom: 7.0,
                        ),
                        onTap: (latLng) async {
                          sharedPreferenceManager.writeData(
                              CachingKey.MAPS_LAT, latLng.latitude);
                          sharedPreferenceManager.writeData(
                              CachingKey.Maps_lang, latLng.longitude);
                          final coordinates = new Coordinates(
                              latLng.latitude, latLng.longitude);
                          var addresses = await Geocoder.local
                              .findAddressesFromCoordinates(coordinates);
                          var address = addresses.first;
                          sharedPreferenceManager.writeData(CachingKey.MAP_ADDRESS, address.addressLine);

                          _add(
                              lat: latLng.latitude,
                              lng: latLng.longitude,
                              address: address.addressLine);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: width * 0.2,
                      left: width * 0.2,
                      child: show_location_confirmation
                          ? StaggerAnimation(
                              titleButton: translator.translate("Confirm"),
                              buttonController: _loginButtonController.view,
                              //   btn_width: width * 0.4,
                              btn_height: width * 0.1,
                              onTap: () async {
                                address_bloc.add(click());
                              },
                            )
                          : Container(),
                    )
                  ],
                ))
          ],
        ));
  }

  void _add({double lat, double lng, String address}) {
    final MarkerId markerId = MarkerId('ezhyper');
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: MarkerId(address),
      infoWindow: InfoWindow(
        title: address,
      ),
      position: LatLng(
        lat,
        lng,
      ),
      onTap: () {},
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
      address_bloc.address_controller.add(address);
      show_location_confirmation = true;
    });
  }

  Widget textChooseDeliveryTime() {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .03, left: width * .03),
          child: MyText(text: translator.translate("Choose Delivery Time ")),
        ),
      ],
    );
  }

  Widget deliveryTimeOptionsOptions() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FittedBox(
        child: Row(
      children: [
        Container(
            padding: EdgeInsets.only(right: width * .03, left: width * .03),
            color: whiteColor,
            width: width,
            height: height * .07,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: time.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      _onSelected_time(index);
                      selected_delivery_time = time[index];
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * .02,
                        ),
                        Container(
                          child: Center(
                            child: MyText(
                              text: time[index],
                              size: height * .018,
                              color:
                                  select_time == index ? greenColor : greyColor,
                            ),
                          ),
                          height: height * .1,
                          width: width * .4,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: select_time == index
                                      ? greenColor
                                      : greyColor,
                                  width: height * .002),
                              color: whiteColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(height * .01),
                              )),
                        ),
                      ],
                    ),
                  );
                })),
      ],
    ));
  }

  Widget textHaveADiscount() {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .03, left: width * .03),
          child: MyText(text: translator.translate("Have A Discount Coupon?")),
        ),
      ],
    );
  }

  Widget discountTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * .07,
          width: width * .85,
          child: TextFormField(
            controller: cupon_controller,
            keyboardType: TextInputType.number,
            style: TextStyle(
                color: greyColor, fontSize: EzhyperFont.primary_font_size),
            obscureText: false,
            cursorColor: greyColor,
            decoration: InputDecoration(
              suffixIcon: Container(
                  padding: EdgeInsets.all(height * .014),
                  child: Container(
                      width: width * .3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: height * .03,
                            width: width * .008,
                            color: greyColor,
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                          InkWell(
                            onTap: () {
                              // get Invoice Summery
                              orderBloc.add(ApplyCouponEvent(
                                cupon: cupon_controller.text,
                                product_ids: product_ids,
                                products_quantity: products_quantity,
                              ));
                            },
                            child: MyText(
                              text: translator.translate("Apply"),
                              color: greenColor,
                              weight: FontWeight.bold,
                            ),
                          )
                        ],
                      ))),
              hintText: "enter Discount Coupon",
              hintStyle: TextStyle(
                color: Color(0xffA0AEC0).withOpacity(
                  .8,
                ),
                fontSize: height * .018,
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height * .1),
                  borderSide:
                      BorderSide(color: greyColor, width: height * .002)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height * .1),
                  borderSide:
                      BorderSide(color: greyColor, width: height * .002)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height * .1),
                  borderSide:
                      BorderSide(color: greenColor, width: height * .002)),
            ),
          ),
        ),
      ],
    );
  }

  Widget textInvoiceSummary() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .03, left: width * .03),
          child: MyText(text: translator.translate("Invoice Summary")),
        ),
      ],
    );
  }

  Widget invoiceSummaryCard() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder(
      bloc: orderBloc,
      builder: (context, state) {
        if (state is Loading) {
          if (state.indicator == 'apply_coupon') {
            return Center(
              child: SpinKitFadingCircle(color: greenColor),
            );
          } else {
            return Container();
          }
        } else if (state is Done) {
          if (state.indicator == 'apply_coupon') {
            var data = state.model as CouponModel;
            if (data.data == null) {
              return NoData(
                message: data.msg,
              );
            } else {
              return StreamBuilder<CouponModel>(
                stream: orderBloc.invoice_summery_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.data == null) {
                      return Container();
                    } else {
                      return FittedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(height * .02),
                                  topLeft: Radius.circular(height * .02))),
                          padding: EdgeInsets.only(
                              right: width * .075, left: width * .075),
                          width: width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                      text: translator.translate("Sub Total"),
                                      size: height * .02),
                                  Column(
                                    children: [
                                      MyText(
                                          text: translator.currentLanguage ==
                                                  'ar'
                                              ? "${translator.translate("SAR")} ${snapshot.data.data.subTotal} "
                                              : "${snapshot.data.data.subTotal} ${translator.translate("SAR")}",
                                          size: height * .02),
                                      MyText(
                                        text:
                                            " ( ${translator.translate("inclusive of vat")} )",
                                        size: height * .01,
                                        color: greyColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                      text: translator.translate("Saving"),
                                      size: height * .02),
                                  MyText(
                                      text:
                                          "${snapshot.data.data.savingAmount} ${translator.translate("SAR")}",
                                      size: height * .02),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                      text: translator
                                          .translate("Points Discount"),
                                      size: height * .02),
                                  MyText(
                                      text:
                                          "(${snapshot.data.data.rewardPoint} ${translator.translate("SAR")})",
                                      size: height * .02),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                      text: translator
                                          .translate("Delivery Charges"),
                                      size: height * .02),
                                  MyText(
                                      text:
                                          "${snapshot.data.data.deliveryCharge} ${translator.translate("SAR")}",
                                      size: height * .02),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: translator.translate("Order Total"),
                                    size: height * .02,
                                    color: greenColor,
                                  ),
                                  MyText(
                                    text:
                                        "${snapshot.data.data.total} ${translator.translate("SAR")} ",
                                    size: height * .02,
                                    color: greenColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Container(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: SpinKitFadingCircle(color: greenColor),
                    );
                    ;
                  }
                },
              );
            }
          } else {
            return Container();
          }
        }
        else if (state is ErrorLoading) {
          if (state.indicator == 'apply_coupon') {
            return NoData(
              message: 'There is Error',
            );
          }
        } else {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        }
      },
    );
  }

  Widget paintZigZagShapeWithTriangles() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.only(top: height * .01),
            width: width,
            color: Colors.white,
            height: height * .04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape(),
                singleTriangleForZigZagShape()
              ],
            )),
      ],
    );
  }

  Widget singleTriangleForZigZagShape() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Triangle.isosceles(
      edge: Edge.TOP,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/triangle_demo'),
        child: Container(
          color: backgroundColor,
          width: width * .1,
          height: 25,
          child: Center(),
        ),
      ),
    );
  }

  Widget triangle() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Triangle.isosceles(
      edge: Edge.TOP,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/triangle_demo'),
        child: Container(
          color: backgroundColor,
          width: width * .1,
          height: 25,
          child: Center(),
        ),
      ),
    );
  }
}
