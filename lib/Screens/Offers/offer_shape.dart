import 'package:ezhyper/Constants/static_data.dart';
import 'package:ezhyper/Model/OffersModel/offer_model.dart' as offerModel;
import 'package:ezhyper/Widgets/custom_favourite.dart';
import 'package:ezhyper/Widgets/product_slider.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rating_bar/rating_bar.dart';

class OfferShape extends StatefulWidget{
  offerModel.Data offer;
  OfferShape({this.offer});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OfferShapeState();
  }

}

class OfferShapeState extends State<OfferShape>{

  @override
  Widget build(BuildContext context) {
    List<String> gallery = new List<String>();
    widget.offer.product.files.forEach((element) {
      gallery.add(element.url);
    });
    return Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:Row(
        children: [
          SizedBox(
            width: StaticData.get_width(context) * .03,
          ),
          InkWell(onTap: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return OfferProductDetails(
                    offer_product: widget.offer.product,
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
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(StaticData.get_height(context) * .015)),
      ),
      height: StaticData.get_height(context)  * .32,
      width: StaticData.get_width(context)  * .4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              MyProductSlider(
                data: gallery,
                viewportFraction: 1.0,
                aspect_ratio: 3.0,
                border_radius: 15.0,
                indicator: false,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: StaticData.get_width(context) * .01),
            child: Column(
              children: [
                Row(
                  children: [
                    RatingBar.readOnly(
                      initialRating: widget.offer.product.totalRate.toDouble(),
                      maxRating: 5,
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,

                      size: StaticData.get_width(context) * 0.03,
                      filledColor: (widget.offer.product.totalRate.toDouble() >= 1)
                          ? Colors.yellow.shade700
                          : Colors.yellow.shade700,
                    ),
                    SizedBox(
                      width: StaticData.get_width(context) * .02,
                    ),
                    MyText(
                      text: "(${widget.offer.product.countRates})",
                      size: StaticData.get_height(context)  * .015,
                      color: greyColor,
                    )
                  ],
                ),
                Wrap(
                  children: [
                    Container(
                      alignment : translator.currentLanguage == 'ar' ?  Alignment.centerRight : Alignment.centerLeft,
                      child: MyText(
                          text: "${widget.offer.product.name} ",
                          size: StaticData.get_height(context)  * .014,
                          color: blackColor),
                    )

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              text: "${widget.offer.product.priceAfterDiscount} ${translator.translate("SAR")}",
                              size: StaticData.get_height(context) * .017,
                              color: blackColor,
                              weight: FontWeight.normal,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${widget.offer.product.price} ${translator.translate("SAR")}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: StaticData.get_height(context)  * .011,
                                  color: greyColor),
                            ),
                            SizedBox(
                              width: StaticData.get_width(context) * .02,
                            ),
                            MyText(
                                text: "${widget.offer.product.discount}%",
                                size: StaticData.get_height(context)  * .011,
                                color: greenColor),
                          ],
                        )
                      ],
                    ),
                    Container(padding: EdgeInsets.all(StaticData.get_height(context) *.01),
                        height: StaticData.get_height(context)  * .05,
                        width: StaticData.get_width(context)  * .1,
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(StaticData.get_height(context)  * .01),
                                bottomLeft: Radius.circular(StaticData.get_height(context)  * .01))),
                        child: Image.asset("assets/images/cart_white.png")),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ))]));
  }

}