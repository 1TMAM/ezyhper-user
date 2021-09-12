import 'package:ezhyper/Base/Database/DB_Helper.dart';
import 'package:ezhyper/Base/Database/Product.dart';
import 'package:ezhyper/Bloc/LoyaltySystemBloc/loyalty_system_bloc.dart';
import 'package:ezhyper/Screens/Favourites/youDontHaveFavouriteList.dart';
import 'package:ezhyper/Widgets/coupon_dialog.dart';
import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/Widgets/visitor_message.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int counter = 1;
  Future<List<Product>> cart_products;
  List<Product> product_Data;
  var product_quantity;
  int qty;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    loyaltySystemBloc.add(LoyaltySystemEvent()); // get all user data
    cart_products = DB_Helper.get_cart_products();
    product_Data = [];
    print("cart_products : ${cart_products}");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("------------- cart_offers -----------");
    cart_offers();
    super.didChangeDependencies();
  }

  void cart_offers() async {
    await sharedPreferenceManager.readInteger(CachingKey.FRIST_TIME) == true
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return CouponDialog(
                  text:
                      "This is your first purchase, and if you complete this purchase, you will get a 5% discount on your next purchase");
            })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
      backgroundColor: whiteColor,
      key: _drawerKey,
      body:
          /*(StaticData.vistor_value == 'visitor')
          ? VistorMessage()
          : */
          Directionality(
              textDirection: translator.currentLanguage == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                  child: Column(children: [
                topPart(),
                Expanded(
                  child: _buildBody(),
                )
              ]))),
/*      bottomNavigationBar: CustomBottomNavigationBar2(
        onTapCart: false,
        isActiveIconCart: true,
      ),*/
    )));
  }

  _buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(height * .05),
              topLeft: Radius.circular(height * .05)),
          color: backgroundColor),
      child: FutureBuilder(
          future: cart_products,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return YouDontHaveFavourites(
                  message:
                      translator.translate("There is no items in cart now"),
                  image: 'assets/images/img_slide1.png',
                  width: width * 0.8,
                  height: width * 0.5,
                );
              } else {
                product_Data = snapshot.data;
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: width * .075,
                          left: width * .075,
                          top: height * .0,
                          bottom: height * .0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(height * .05),
                              topRight: Radius.circular(height * .05)),
                          color: backgroundColor),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * .01,
                          ),
                          textSwipeLeft(),
                          SizedBox(
                            height: height * .01,
                          ),
                          divider(),
                        ],
                      ),
                    ),
                    ListView.builder(
                        itemCount: product_Data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Column(children: [
                              SizedBox(
                                height: height * .01,
                              ),
                              shoppingCartItem(product_Data[index]),
                              SizedBox(
                                height: height * .01,
                              ),
                            ]),
                            secondaryActions: [
                              IconSlideAction(
                                caption: translator.translate("Delete"),
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  DB_Helper.delete_product(
                                      int.parse(product_Data[index].prod_id));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomCircleNavigationBar(
                                                  page_index: 3)));
                                },
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    CustomSubmitAndSaveButton(
                      buttonText: translator.translate("CHECKOUT"),
                      onPressButton: () async {
                        if (StaticData.vistor_value == 'visitor') {
                          Navigator.pop(context);
                          CustomComponents.guestRegisterationBottomSheet(
                            context: context,
                            drawerKey: _drawerKey
                          );
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckOutScreen(),
                              ));
                        }
                      },
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                  ],
                ));
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
          }),
    );
  }

  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Container(
        child: Container(
          height: height * .10,
          color: whiteColor,
          padding: EdgeInsets.only(
            left: width * .075,
            right: width * .075,
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
                              return  translator.currentLanguage == 'ar' ?
                              CustomCircleNavigationBar(page_index: 4,) : CustomCircleNavigationBar();
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
                      text: translator.translate("SHOPPING CART").toUpperCase(),
                      size: EzhyperFont.primary_font_size,
                      weight: FontWeight.bold,
                    )),
                  ],
                ),
              ),
//            Container(
//              child: Image.asset(
//                "assets/images/cart.png",
//                height: height * .03,
//              ),
//            ),
            ],
          ),
        ),
      ),
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
      padding: EdgeInsets.only(left: width * .075),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/swipe.png",
            height: height * .03,
          ),
          MyText(
              text: translator.translate("swipe"),
              size: height * .015,
              weight: FontWeight.bold,
              color: greyColor),
        ],
      ),
    );
  }

  Widget shoppingCartItem(Product product) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    qty = product.prod_chossed_quantity;
    product_quantity = product.prod_main_quantity;
    return Directionality(
        textDirection: translator.currentLanguage == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: height * .015),
                child: FittedBox(
                  child: Row(
                    children: [
                      Container(
                        width: width * .90,
                        //  padding: EdgeInsets.only(right: width * .02),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(height * .02),
                            bottomRight: Radius.circular(height * .02),
                            topLeft: Radius.circular(height * .02),
                            bottomLeft: Radius.circular(height * .02),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    child: product.prod_pricture == null
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
                                    borderRadius:
                                        BorderRadius.circular(height * .02),
                                  ),
                                ],
                              ),
                              FittedBox(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FittedBox(
                                              child: Container(
                                                  width: StaticData.get_width(
                                                          context) *
                                                      0.5,
                                                  alignment: translator
                                                              .currentLanguage ==
                                                          'ar'
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  child: MyText(
                                                    text:
                                                        "${product.prod_name}",
                                                    size: height * .02,
                                                    weight: FontWeight.bold,
                                                    align: TextAlign.left,
                                                  )))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FittedBox(
                                              child: Container(
                                                  child: MyText(
                                            text:
                                                "${product.prod_price_after_discount} ${translator.translate("SAR")}",
                                            size: height * .015,
                                            weight: FontWeight.bold,
                                          ))),
                                          SizedBox(
                                            width: width * .02,
                                          ),
                                          FittedBox(
                                              child: Container(
                                                  child: Row(
                                            children: [
                                              Text(
                                                "${product.prod_price} ${translator.translate("SAR")}",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: height * .014,
                                                    fontWeight: FontWeight.bold,
                                                    color: greyColor),
                                              ),
                                              SizedBox(
                                                width: width * .02,
                                              ),
                                              MyText(
                                                  text:
                                                      "${product.prod_discount}%",
                                                  size: height * .014,
                                                  weight: FontWeight.bold,
                                                  color: greenColor),
                                            ],
                                          ))),
                                          MaterialButton(
                                            height: 5,
                                            minWidth:
                                                StaticData.get_width(context) *
                                                    0.15,
                                            onPressed: () {
                                              setState(() {
                                                if (qty <= 1) {
                                                  errorDialog(
                                                    context: context,
                                                    text:
                                                        "لقد نفذت الكمية من هذا المنتج",
                                                  );
                                                } else {
                                                  setState(() {
                                                    qty--;
                                                  });
                                                }
                                              });
                                            },
                                            color: whiteColor,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.remove,
                                              size: 18,
                                              color: blackColor,
                                            ),
                                            padding: EdgeInsets.all(5),
                                            shape: CircleBorder(),
                                          ),
                                          quantity(),
                                          MaterialButton(
                                            height: 5,
                                            minWidth:
                                                StaticData.get_width(context) *
                                                    0.15,
                                            onPressed: () {
                                              setState(() {
                                                print(
                                                    "prod_main_quantity : ${product_quantity}");
                                                if (qty == product_quantity) {
                                                  errorDialog(
                                                    context: context,
                                                    text:
                                                        "لا يمكنك تخطى الكمية المتاحة",
                                                  );
                                                } else {
                                                  setState(() {
                                                    qty++;
                                                  });
                                                }
                                              });
                                            },
                                            color: whiteColor,
                                            textColor: greyColor,
                                            child: Icon(
                                              Icons.add,
                                              size: 18,
                                              color: blackColor,
                                            ),
                                            padding: EdgeInsets.all(5),
                                            shape: CircleBorder(),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget quantity() {
    return Text(
      '${qty}',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }


}
