import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:ezhyper/Model/OrdersModel/order_model.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Model/OrdersModel/order_model.dart' as order_model;

class OrderHistoryDetails extends StatefulWidget {
  order_model.Data order;
  OrderHistoryDetails({this.order});
  @override
  _OrderHistoryDetailsState createState() => _OrderHistoryDetailsState();
}

class _OrderHistoryDetailsState extends State<OrderHistoryDetails> {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        child: Column(
          children: [topPart(), Expanded(child: buildBody())],
        ),
      ),
    )));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: translator.currentLanguage == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
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
                    height: height * .01,
                  ),
                  shippingAddressAndOrderTrackCard(),
                  widget.order.products.length == 0
                      ? Container()
                      : Column(
                          children: [
                            textItems(),
                            SizedBox(
                              height: height * .01,
                            ),
                            listViewOfOrdersItems(),
                          ],
                        ),
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
                ],
              ),
            ))));
  }

  Widget listViewOfOrdersItems() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
   //     height: widget.order.status == 'delivered' ? height * .5 : height * .43,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.order.products.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {},
                  child: singleImageAndDescriptionItemCard(
                      product: widget.order.products[index]));
            }));
  }

  Widget textInvoiceSummary() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .075, left: width * .075),
          child: MyText(text: translator.translate("Invoice Summary")),
        ),
      ],
    );
  }

  Widget invoiceSummaryCard() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(height * .02),
                topLeft: Radius.circular(height * .02))),
        padding: EdgeInsets.only(right: width * .075, left: width * .075),
        width: width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(text: translator.translate("Sub Total"), size: height * .02),
                Column(
                  children: [
                    MyText(
                        text:
                            "${widget.order.subTotal} ${translator.translate("SAR")}",
                        size: height * .02),
                    MyText(
                      text: " ( ${translator.translate("inclusive of vat")} )",
                      size: height * .01,
                      color: greyColor,
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(text: translator.translate("Saving"), size: height * .02),
                MyText(
                    text:
                        "${widget.order == null ? '' : widget.order.savingAmount} ${translator.translate("SAR")}",
                    size: height * .02),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(text: translator.translate("Points Discount"), size: height * .02),
                MyText(
                    text:
                        "(${widget.order == null ? '' : widget.order.discount} ${translator.translate("SAR")})",
                    size: height * .02),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(text: translator.translate("Delivery Charges"), size: height * .02),
                MyText(
                    text:
                        "${widget.order == null ? '' : widget.order.shippingCost} ${translator.translate("SAR")}",
                    size: height * .02),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: translator.translate("Order Total"),
                  size: height * .02,
                  color: greenColor,
                ),
                MyText(
                  text:
                      "${widget.order == null ? '' : widget.order.total + widget.order.shippingCost} ${translator.translate("SAR")} ",
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

  Widget shippingAddressAndOrderTrackCard() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
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
                              text:
                              translator.currentLanguage == 'ar' ? "${widget.order.orderNum} # ${translator.translate("order")} " :
                              "${translator.translate("order")} #${widget.order.orderNum}",
                              size: height * .02,
                              color: blackColor,
                              weight: FontWeight.bold,
                            ),
                            CustomButton(
                              givenHeight: height * .05,
                              givenWidth: width * .3,
                              onTapFunction: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return OrderTrackScreen(
                                          order: widget.order);
                                    },
                                    transitionsBuilder: (context, animation8,
                                        animation15, child) {
                                      return FadeTransition(
                                        opacity: animation8,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        Duration(milliseconds: 10),
                                  ),
                                );
                              },
                              text: translator.translate("Track"),
                              fontSize: height * .02,
                              radius: height * .05,
                            )
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
                            SizedBox(
                              width: width * 0.02,
                            ),
                            FittedBox(
                              child: Container(
                                alignment:  translator.currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
                                child: MyText(
                                  text:
                                      "${widget.order.user.address == null ?
                                      StaticData.order_address == null?  translator.translate("address") : StaticData.order_address
                                          : widget.order.user.address}",
                                  size: height * .014,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Directionality(
                            textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
                            child:Row(
                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                          children: [
                            order_status(
                                status: widget.order == null
                                    ? ''
                                    : widget.order.status),
                            MyText(
                              text:
                                  "${widget.order == null ? '' : widget.order.date}",
                              size: height * .015,
                              color: greyColor,
                            ),
                          ],
                        )),
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

  Widget textItems() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .075, left: width * .075),
          child: MyText(
              text: translator.currentLanguage == 'ar'? "(${widget.order.products.length}) : ${translator.translate("Items")} " : "${translator.translate("Items")} : (${widget.order.products.length})"),
        ),
      ],
    );
  }

  Widget singleImageAndDescriptionItemCard({Products product}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<String> gallery = new List<String>();
    product.files.forEach((element) {
      gallery.add(element.url);
    });
    return Row(
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
                    width: width * .85,
                    padding: EdgeInsets.only(right: width * .03),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(height * .02),
                        bottomRight: Radius.circular(height * .02),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            product.files == null
                                ? Image.asset(
                                    "assets/images/food5.png",
                                    height: height * .2,
                                    width: width * .35,
                                    fit: BoxFit.fill,
                                  )
                                : product.files.isEmpty
                                    ? Image.asset(
                                        "assets/images/food5.png",
                                        height: height * .2,
                                        width: width * .35,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        product.files[0].url,
                                        height: height * .2,
                                        width: width * .35,
                                        fit: BoxFit.fill,
                                      ),
                            widget.order.status == 'delivered'
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return RateAndReview(
                                              order: widget.order,
                                            );
                                          },
                                          transitionsBuilder: (context,
                                              animation8, animation15, child) {
                                            return FadeTransition(
                                              opacity: animation8,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 10),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: height * .05,
                                      width: width * .35,
                                      color: Color(0xffFFF7BF),
                                      child: MyText(
                                        text: "rate and review",
                                        color: greenColor,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        FittedBox(
                          child: Container(
                            width: width * .45,
                            child: Column(
                              children: [
                                MyText(
                                  text:
                                      "${product == null ? '' : product.name}",
                                  size: height * .017,
                                ),
                                MyText(
                                  text:
                                      "${product == null ? '' : product.quantity} × ${product == null ? '' : product.price} ${translator.translate("SAR")}",
                                  size:EzhyperFont.primary_font_size,
                                ),
                              ],
                            ),
                          ),
                        )
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
                      text:
                          "${translator.translate("ORDER DETAILS")} - #${widget.order == null ? '' : widget.order.orderNum}",
                      size:EzhyperFont.primary_font_size,
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

  Widget customPaintZigZagShape() {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: MyPainter(),
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

  Widget order_status({String status}) {
    double height = MediaQuery.of(context).size.height;

    switch (status) {
      case 'pending':
        return MyText(
          text: translator.translate("pending"),
          size: height * .016,
          color: Colors.yellow.shade400,
        );
        break;
      case 'accepted':
        return MyText(
          text: translator.translate("accepted"),
          size: height * .016,
          color: Colors.orange,
        );
        break;
      case 'canceled':
        return MyText(
          text: translator.translate("canceled"),
          size: height * .016,
          color: Colors.red,
        );
        break;
      case 'prepare':
        return MyText(
          text: translator.translate("prepare"),
          size: height * .016,
          color: Colors.blue,
        );
        break;
      case 'in_way':
        return MyText(
          text: translator.translate("in_way"),
          size: height * .016,
          color: Colors.greenAccent,
        );
        break;
      case 'delivered':
        return MyText(
          text: translator.translate("delivered"),
          size: height * .016,
          color: Colors.green,
        );
        break;
    }
  }
}
