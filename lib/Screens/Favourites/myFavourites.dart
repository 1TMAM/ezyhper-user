import 'package:ezhyper/Bloc/Favourite_Bloc/favourite_bloc.dart';
import 'package:ezhyper/Model/FavouriteModel/favourite_list_model.dart';
import 'package:ezhyper/Screens/Favourites/favourite_product_details.dart';
import 'package:ezhyper/Screens/Favourites/youDontHaveFavouriteList.dart';
import 'package:ezhyper/Widgets/custom_favourite.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/Widgets/product_slider.dart';
import 'package:ezhyper/Widgets/visitor_message.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rating_bar/rating_bar.dart';

class MyFavourites extends StatefulWidget {
  @override
  _MyFavouritesState createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  var total_rate = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favourite_bloc.add(getAllFavoutites_click());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Directionality(
                textDirection: translator.currentLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Scaffold(
                  backgroundColor: whiteColor,
                  body:   (StaticData.vistor_value == 'visitor')
                      ? VistorMessage() :Container(
                      child: Column(children: [
                    // topPart(),
                    CustomAppBar(
                      text: translator.translate("My FAVOURITE"),
                    ),
                    SizedBox(
                      height: height * .0,
                    ),
                    Expanded(
                        child: Container(
                            color: backgroundColor, child: gridView()))
                  ])),

                ))));
  }

  Widget singleImageContainerForGridView(Product product) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<String> gallery = new List<String>();
    product.files.forEach((element) {
      gallery.add(element.url);
    });
    List rates=[];
    if(product.rates.isEmpty){
      total_rate = product.totalRate.toDouble();
    }else{
      product.rates.forEach((element) {
        rates.add(element.value);
      });
      total_rate = rates.fold(0, (p, c) => p + c)/ rates.length;
      print("------ total_rate ------- : ${total_rate}");
    }
    var price_after_discount;
    if(product.priceAfterDiscount.runtimeType == String){
      price_after_discount = double.parse(product.priceAfterDiscount).toStringAsFixed(2);
    }else if(product.priceAfterDiscount.runtimeType == double){
      price_after_discount = product.priceAfterDiscount.toStringAsFixed(2);
    }else if(product.priceAfterDiscount.runtimeType == int){
      price_after_discount = double.parse(product.priceAfterDiscount).toStringAsFixed(2);
    }
    return Row(
      children: [
        SizedBox(
          width: width * .03,
        ),
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(height * .015)),
          ),
       //   height: height * .4,
          width: width * .4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(product.cover),

                  /*        MyProductSlider(
                    data: gallery,
                    viewportFraction: 1.0,
                    aspect_ratio: 3.0,
                    border_radius: 15.0,
                    indicator: false,

                  ),*/
                  CustomFauvourite(
                    color: redColor,
                    favourite_status: product.inFavorite == 0 ? false : true,
                    product_id: product.id,
                  )
                ],
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return FavouriteProductDetails(
                            favourite_product: product,
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
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      padding: EdgeInsets.only(left: width * .01),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RatingBar.readOnly(
                                initialRating: total_rate.toDouble(),
                                maxRating: 5,
                                isHalfAllowed: true,
                                halfFilledIcon: Icons.star_half,
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                                size: StaticData.get_width(context) * 0.03,
                                filledColor: (total_rate.toDouble() >= 1)
                                    ? Colors.yellow.shade700
                                    : Colors.yellow.shade700,
                              ),
                              SizedBox(
                                width: width * .01,
                              ),
                              MyText(
                                text: "(${product.countRates})",
                                size: height * .015,
                                color: greyColor,
                              )
                            ],
                          ),
                          Wrap(
                            textDirection: TextDirection.rtl,
                            alignment: WrapAlignment.start,
                            children: [
                              MyText(
                                  text: product.name,
                                  size: height * .014,
                                  color: blackColor)
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
                                        text:
                                            "${product.priceAfterDiscount == 0 ? product.price :
                                            price_after_discount } ${translator.translate("SAR").toLowerCase()}",
                                        size: height * .015,
                                        color: blackColor,
                                        weight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${product.price} ${translator.translate("SAR")}",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: height * .011,
                                            color: greyColor),
                                      ),
                                      SizedBox(
                                        width: width * .02,
                                      ),
                                      MyText(
                                          text: "${product.discount}%",
                                          size: height * .011,
                                          color: greenColor),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  padding: EdgeInsets.all(height * .01),
                                  height: height * .05,
                                  width: width * .1,
                                  decoration: BoxDecoration(
                                      color: greenColor,
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                              Radius.circular(height * .01),
                                          bottomLeft:
                                              Radius.circular(height * .01))),
                                  child: Image.asset(
                                      "assets/images/cart_white.png")),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget gridView() {
    return BlocBuilder(
      bloc: favourite_bloc,
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        } else if (state is Done) {
          var data = state .model as FavouriteListModel;
          print("fav status : ${data.status}");
          print("fav data : ${data.data}");
          if(data.data ==null){

            return NoData(
              message: data.msg,
            );
          }else {
            return StreamBuilder<FavouriteListModel>(
                stream: favourite_bloc.subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("snap : ${snapshot.data.data}");
                    if (snapshot.data.data.isEmpty) {
                      return YouDontHaveFavourites();
                    } else {
                      return GridView.builder(
                          itemCount: snapshot.data.data.length,
                          physics: NeverScrollableScrollPhysics(),

                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 9 / 14,
                            // childAspectRatio: StaticData.get_width(context) * 0.002,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                              //  color: Color(0xfff7f7f7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              child: singleImageContainerForGridView(
                                  snapshot.data.data[index].product),
                            );
                          });
                    }
                  } else {
                    return YouDontHaveFavourites();
                  }
                });
          }

        } else if (state is ErrorLoading) {
          return YouDontHaveFavourites();
        }else{
          return Container();
        }
      },
    );
  }

  Widget redDotOverNotificationsIcon() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: height > width ? width * .1 : width * .085,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: height > width ? width * .02 : width * .005,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                padding: EdgeInsets.only(top: height * .06),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
