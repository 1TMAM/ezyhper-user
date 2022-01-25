import 'package:ezhyper/Base/Database/DB_Helper.dart';
import 'package:ezhyper/Base/Database/Product.dart';
import 'package:ezhyper/Bloc/Favourite_Bloc/favourite_bloc.dart';
import 'package:ezhyper/Model/FavouriteModel/favourite_list_model.dart'
    as favourite_model;
import 'package:ezhyper/Model/OffersModel/offer_model.dart' as offerModel;
import 'package:ezhyper/Screens/Product/product_view.dart';
import 'package:ezhyper/Widgets/custom_favourite.dart';
import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/Widgets/product_slider.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/screens/productReview.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';

class OfferProductDetails extends StatefulWidget {
  offerModel.Product offer_product;
  final String old_price;
  final String price;
  final int percentage;
  OfferProductDetails({
    this.offer_product,
    this.price,
    this.old_price,
    this.percentage
  });
  @override
  _OfferProductDetailsState createState() {
    return _OfferProductDetailsState();
  }
}

class _OfferProductDetailsState extends State<OfferProductDetails> {
  bool product_status;
  bool favourite_status;
  var product_quantity;
  int qty;
  var _cart_status = 0;
  var _order_status = 0;
  var total_rate = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qty = 1;

    product_quantity = widget.offer_product.quantity;
    print("product_quantity : ${product_quantity}");
    product_status = false;
    favourite_status = widget.offer_product.inFavorite == 0 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<String> gallery = new List<String>();

    widget.offer_product.files.forEach((element) {
      gallery.add(element.url);
    });
    List rates=[];
    if(widget.offer_product.rates.isEmpty){
      total_rate = widget.offer_product.totalRate.toDouble();
    }else{
      widget.offer_product.rates.forEach((element) {
        rates.add(element.value);
      });
      total_rate = rates.fold(0, (p, c) => p + c)/ rates.length;
      print("------ total_rate ------- : ${total_rate}");
    }
    return NetworkIndicator(
        child: PageContainer(
            child: Directionality(
                textDirection: translator.currentLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Scaffold(
                    backgroundColor: whiteColor,
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Stack(
                              children: [
                                Image.network(widget.offer_product.cover),
                  /*              MyProductSlider(
                                  data: gallery,
                                  viewportFraction: 1.0,
                                  aspect_ratio: 3.0,
                                  border_radius: 0.0,
                                  indicator: false,
                                  slider_height:
                                      StaticData.get_height(context) / 2,
                                  motion: true,
                                ),*/
                                Padding(
                                  padding: EdgeInsets.only(top: width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(height * .01),
                                        height: height * .05,
                                        width: width * .2,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                  height * .05,
                                                ),
                                                bottomRight: Radius.circular(
                                                    height * .05)),
                                            color: whiteColor),
                                        child: InkWell(
                                          child:
                                              translator.currentLanguage == 'ar'
                                                  ? Image.asset(
                                                      "assets/images/arrow_right.png",
                                                      height: height * .03,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/arrow_left.png",
                                                      height: height * .015,
                                                    ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: width * .4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                final RenderBox box =
                                                    context.findRenderObject();
                                                Share.share(
                                                    '${widget.offer_product.name}',
                                                    subject:
                                                        'Welcome To Ezhyper',
                                                    sharePositionOrigin:
                                                        box.localToGlobal(
                                                                Offset.zero) &
                                                            box.size);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    height * .01),
                                                height: height * .05,
                                                width: width * .1,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: whiteColor),
                                                child: Image.asset(
                                                  "assets/images/share.png",
                                                  height: height * .015,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: height * .01),
                                              height: height * .05,
                                              width: width * .2,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: whiteColor),
                                              child: favourite_status
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        size: 20,
                                                        color: redColor,
                                                      ),
                                                      onPressed: (StaticData
                                                                  .vistor_value ==
                                                              'visitor')
                                                          ? null
                                                          : () async {
                                                              await favourite_bloc
                                                                  .add(
                                                                      removeFavourite_click(
                                                                product_id: widget
                                                                    .offer_product
                                                                    .id,
                                                              ));
                                                              setState(() {
                                                                favourite_status =
                                                                    !favourite_status;
                                                              });
                                                            },
                                                    )
                                                  : IconButton(
                                                      icon: Icon(
                                                        Icons.favorite_border,
                                                        size: 20,
                                                        color: redColor,
                                                      ),
                                                      onPressed: (StaticData
                                                                  .vistor_value ==
                                                              'visitor')
                                                          ? null
                                                          : () {
                                                              favourite_bloc.add(
                                                                  addFavourite_click(
                                                                product_id: widget
                                                                    .offer_product
                                                                    .id,
                                                              ));
                                                              setState(() {
                                                                favourite_status =
                                                                    !favourite_status;
                                                              });
                                                            },
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: width * 0.7),
                              child: _buildBody(),
                            )
                          ],
                        ),
                      ),
                    )))));
  }

  _buildBody() {
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: width * .05, right: width * .05),
                    width: width,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(height * .05)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: width * .02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                  text: "${widget.offer_product.name} ",
                                  size: height * .02),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: width * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                                text:
                                    "${widget.price} ${translator.translate("SAR")} ",
                                size: height * .02),
                            SizedBox(
                              width: width * .02,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${widget.old_price} ${translator.translate("SAR")}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: height * .011,
                                      color: greyColor),
                                ),
                                SizedBox(
                                  width: width * .02,
                                ),
                                MyText(
                                    text: "${widget.percentage}%",
                                    size: height * .011,
                                    color: greenColor),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * .02,
                                right: width * .02,
                              ),
                              child: Row(
                                children: [
                                  RatingBar.readOnly(
                                    initialRating: total_rate.toDouble(),
                                    maxRating: 5,
                                    isHalfAllowed: true,
                                    halfFilledIcon: Icons.star_half,
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                    size: StaticData.get_width(context) * 0.03,
                                    filledColor: (total_rate.toDouble() >=
                                            1)
                                        ? Colors.yellow.shade700
                                        : Colors.yellow.shade700,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  MyText(
                                    text:
                                        "(${widget.offer_product.countRates})",
                                    size: height * .015,
                                    color: greyColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(height * .05)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: width * .05, right: width * .05),
                              width: width,
                              height: width * .2,
                              child: Wrap(
                                children: [
                                  MyText(
                                    text: "${widget.offer_product.description}",
                                    size: height * .018,
                                    align: TextAlign.left,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: height * .01,
                        ),
                        productDetailsAndReviewRow(),
                        Container(
                          //   height: StaticData.get_width(context)* 0.7,
                          child: product_status
                              ? product_review(
                                  rates: widget.offer_product.rates)
                              : product_details(),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: StaticData.get_width(context) * 0.02,
                              right: StaticData.get_width(context) * 0.02,
                              top: StaticData.get_width(context) * 0.1),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: blackColor,
                                  borderRadius:
                                      BorderRadius.circular(height * .05),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: <Widget>[
                                    MaterialButton(
                                      height: 5,
                                      minWidth:
                                          StaticData.get_width(context) * 0.15,
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
                                          StaticData.get_width(context) * 0.15,
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
                                      textColor: Colors.white,
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: blackColor,
                                      ),
                                      padding: EdgeInsets.all(5),
                                      shape: CircleBorder(),
                                    ),
                                    CustomSubmitAndSaveButton(
                                      buttonText:
                                          translator.translate("ADD TO CART"),
                                      btn_width: width * .60,
                                      onPressButton: () {
                                        print("cart 1");
                                        if (_cart_status == 0) {
                                          _cart_status = 1;
                                          print("cart 2");

                                          DB_Helper.insert_product(new Product(
                                              prod_id: widget.offer_product.id,
                                              prod_name:
                                                  widget.offer_product.name,
                                              prod_price: widget.old_price,
                                              prod_pricture: widget
                                                      .offer_product
                                                      .files
                                                      .isEmpty
                                                  ? 'https://eazyhyper.wothoq.co/public/media/categories/yOHvUbpcnTrh58YWwdYb9BNUzorReMyDeabG1m95.jpg'
                                                  : widget.offer_product
                                                      .files[0].url,
                                              prod_chossed_quantity: qty,
                                              prod_main_quantity:
                                                  widget.offer_product.quantity,
                                              prod_discount: widget.percentage,
                                              prod_price_after_discount: widget.price,
                                              prod_cart_status: _cart_status,
                                              prod_order_status:
                                                  _order_status));
                                          print("cart 3");
                                          //use to calculate price of all products in cart
                                          DB_Helper.calculate_amount();
                                          print("cart 4");
                                          //use to calculate number of all products in cart
                                          DB_Helper.cart_items_number();
                                          print("cart 5");
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShoppingCart()));
                                        } else {
                                          print("cart 6");
                                          String msg =
                                              "this product already added in shopping cart";
                                          StaticData.Toast_Short_Message(msg);
                                          print("cart 7");
                                        }
                                        /*            if(StaticData.vistor_value == 'visitor'){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>VistorMessage(),
                                      )   );
                                    }else{
                                      print("cart 1");
                                      if(_cart_status ==0){
                                        _cart_status=1;
                                        print("cart 2");
                                        DB_Helper.insert_product(new Product(
                                            prod_id:  widget.offer_product.id,
                                            prod_name :  widget.offer_product.name,
                                            prod_price :  widget.offer_product.price,
                                            prod_pricture :  widget.offer_product.files.isEmpty ?'https://eazyhyper.wothoq.co/public/media/categories/yOHvUbpcnTrh58YWwdYb9BNUzorReMyDeabG1m95.jpg'
                                                : widget.offer_product.files[0].url,
                                            prod_chossed_quantity : qty ,
                                            prod_main_quantity :  widget.offer_product.quantity,
                                            prod_discount:  widget.offer_product.discount,
                                            prod_price_after_discount: widget.offer_product.priceAfterDiscount,
                                            prod_cart_status : _cart_status ,
                                            prod_order_status: _order_status
                                        ));
                                        print("cart 3");
                                        //use to calculate price of all products in cart
                                        DB_Helper.calculate_amount();
                                        print("cart 4");
                                        //use to calculate number of all products in cart
                                        DB_Helper.cart_items_number();
                                        print("cart 5");
                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context)=>ShoppingCart()
                                        ));
                                      }
                                      else{
                                        print("cart 6");
                                        String msg = "this product already added in shopping cart";
                                        StaticData.Toast_Short_Message(msg);
                                        print("cart 7");
                                      }
                                    }*/
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                        ),

                        //releated products

                        Container(
                            alignment: translator.currentLanguage == 'ar'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: StaticData.get_width(context) * .05,
                                right: StaticData.get_width(context) * .05,
                                bottom: StaticData.get_width(context) * .03),
                            child: MyText(
                              text: translator.translate("relatedProducts"),
                              size: EzhyperFont.primary_font_size,
                              color: blackColor,
                            )),

                        Container(
                            height: StaticData.get_height(context) * .35,
                            width: StaticData.get_width(context),
                            child: ProductView(
                              department_name: 'relatedProducts',
                              product_id: widget.offer_product.id,
                              view_type: 'horizontal_ListView',
                            )),

                        SizedBox(
                          height: height * .03,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productDetailsButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: whiteColor,
      onTap: () {
        setState(() {
          product_status = !product_status;
        });
      },
      child: Container(
        width: width * .4,
        child: Column(
          children: [
            MyText(
              text: translator.translate("Product Details"),
              color: product_status ? greyColor : greenColor,
              size: height * .02,
              weight: FontWeight.bold,
            ),
            Container(
              width: width * .4,
              color: product_status ? whiteColor : greenColor,
              height: height * .002,
            )
          ],
        ),
      ),
    );
  }

  Widget productReviewButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: whiteColor,
      onTap: () {
        setState(() {
          product_status = !product_status;
        });
      },
      child: Container(
        width: width * .4,
        child: Column(
          children: [
            MyText(
              text: translator.translate("Product Review"),
              color: product_status ? greenColor : greyColor,
              size: height * .02,
              weight: FontWeight.bold,
            ),
            Container(
              width: width * .4,
              color: product_status ? greenColor : whiteColor,
              height: height * .002,
            )
          ],
        ),
      ),
    );
  }

  Widget productDetailsAndReviewRow() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: width * .075, right: width * .075),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [productDetailsButton(), productReviewButton()],
      ),
    );
  }

  Widget product_details() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(
          height: StaticData.get_height(context) * .03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: StaticData.get_height(context) * .08,
                padding: EdgeInsets.only(
                    right: StaticData.get_width(context) * .05,
                    left: StaticData.get_width(context) * .05),
                child: Row(
                  children: [
                    MyText(
                        text: translator.translate("product number"),
                        size: StaticData.get_height(context) * .02),
                    MyText(
                        text:
                            "${widget.offer_product.code ?? translator.translate("not found")}",
                        size: StaticData.get_height(context) * .02),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                width: StaticData.get_width(context),
                color: whiteColor)
          ],
        ),
        SizedBox(
          height: StaticData.get_height(context) * .03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: StaticData.get_height(context) * .1,
              padding: EdgeInsets.only(
                  right: StaticData.get_width(context) * .05,
                  left: StaticData.get_width(context) * .05),
              child: Row(
                children: [
                  MyText(
                      text: translator.translate("product Size"),
                      size: StaticData.get_height(context) * .02),
                  MyText(
                      text:
                          "${widget.offer_product.size == null ?  translator.translate("not found") :
                          " ${widget.offer_product.unitSize} "+  "${widget.offer_product.overallSize}" }",
                      size: StaticData.get_height(context) * .02),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              width: StaticData.get_width(context),
              color: backgroundColor,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: StaticData.get_height(context) * .08,
                padding: EdgeInsets.only(
                    right: StaticData.get_width(context) * .05,
                    left: StaticData.get_width(context) * .05),
                child: Row(
                  children: [
                    MyText(
                        text: translator.translate("Brand"),
                        size: StaticData.get_height(context) * .02),
                    MyText(
                        text: widget.offer_product.brand == null
                            ? translator.translate("not found")
                            : "${translator.currentLanguage == 'ar' ? widget.offer_product.brand.nameAr :  widget.offer_product.brand.nameAr} ",
                        size: StaticData.get_height(context) * .02),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                width: StaticData.get_width(context),
                color: whiteColor)
          ],
        ),
        SizedBox(
          height: StaticData.get_height(context) * .03,
        ),
/*
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: StaticData.get_height(context) * .1,
              padding: EdgeInsets.only(
                  right: StaticData.get_width(context) * .05,
                  left: StaticData.get_width(context) * .05),
              child: Row(
                children: [
                  MyText(
                      text: translator.translate("Height"),
                      size: StaticData.get_height(context) * .02),
                  MyText(
                      text: widget.offer_product.shape == null
                          ? translator.translate("not found")
                          : "${widget.offer_product.shape} ${translator.translate("Cm")} ",
                      size: StaticData.get_height(context) * .02),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              width: StaticData.get_width(context),
              color: backgroundColor,
            )
          ],
        ),

        SizedBox(
          height: StaticData.get_height(context) * .03,
        ),

 */
      ],
    );
  }

  Widget product_review({List<offerModel.Rates> rates}) {
    double width = MediaQuery.of(context).size.width;
    return rates.isEmpty
        ? Container(
            height: width * 0.2,
            alignment: Alignment.center,
            child: Text(translator.translate("there is no comments")),
          )
        : ListView.builder(
            itemCount: rates.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print("!!!!!! : ${rates[index].user}");
              var total_rate = (rates[index].deliveryTime +
                      rates[index].product +
                      rates[index].productQuality +
                      rates[index].usingExperiences) /
                  4;
              return Directionality(
                textDirection: translator.currentLanguage == 'ar'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: Column(
                  children: [
                    Container(
                      width: StaticData.get_width(context),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(
                              StaticData.get_height(context) * .05)),
                      child: Directionality(
                        textDirection: translator.currentLanguage == 'ar'
                            ? TextDirection.ltr
                            : TextDirection.ltr,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: StaticData.get_width(context) * .05,
                                  right: StaticData.get_width(context) * .05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBar.readOnly(
                                    initialRating: total_rate,
                                    maxRating: 5,
                                    isHalfAllowed: true,
                                    halfFilledIcon: Icons.star_half,
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                    size: StaticData.get_width(context) * 0.03,
                                    filledColor: (total_rate >= 1)
                                        ? Colors.yellow.shade700
                                        : Colors.yellow.shade700,
                                  ),
                                  MyText(
                                      text: rates.isEmpty
                                          ? ''
                                          : rates[index].user == null
                                              ? rates[index]
                                                  .user
                                                  .name
                                                  .cast<String, dynamic>()
                                              : translator.currentLanguage ==
                                                      'ar'
                                                  ? "مستخدم"
                                                  : "user",
                                      size:
                                          StaticData.get_height(context) * .02),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                FittedBox(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left:
                                                StaticData.get_width(context) *
                                                    .05,
                                            right:
                                                StaticData.get_width(context) *
                                                    .05),
                                        width: StaticData.get_width(context),
                                        child: MyText(
                                          text: rates[index].comment.toString(),
                                          size: StaticData.get_height(context) *
                                              .018,
                                          align: TextAlign.end,
                                        ))),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            StaticData.get_width(context) * .05,
                                        right:
                                            StaticData.get_width(context) * .1),
                                    child: MyText(
                                      text: rates[index]
                                          .createDates
                                          .createdAtHuman,
                                      size:
                                          StaticData.get_height(context) * .02,
                                      color: greyColor,
                                    )),
                              ],
                            ),
                            Container(
                              width: StaticData.get_width(context) * .9,
                              color: greyColor,
                              height: StaticData.get_height(context) * .001,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: StaticData.get_height(context) * .03,
                    ),
                  ],
                ),
              );
            });
  }

  Widget quantity() {
    return Text(
      '${qty}',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
