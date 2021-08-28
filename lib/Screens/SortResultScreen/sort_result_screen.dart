import 'package:ezhyper/Bloc/Filter_Bloc/filter_bloc.dart';
import 'package:ezhyper/Bloc/Offers_Bloc/offers_bloc.dart';
import 'package:ezhyper/Bloc/Sort_Bloc/sort_bloc.dart';
import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Model/SortModel/sort_model.dart';
import 'package:ezhyper/Widgets/custom_favourite.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/Widgets/product_slider.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rating_bar/rating_bar.dart';

class SortResultScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SortResultScreenState();
  }

}
class SortResultScreenState extends State<SortResultScreen>{

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
              backgroundColor: whiteColor,
              body: Directionality(
              textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child: Container(
                child: Column(
                  children: [topPart(), Expanded(child: buildBody())],
                ),
              ),)



            )));

  }
  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  BlocBuilder(
      cubit: sort_bloc,
      builder: (context,state){
        if(state is Loading){
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        }else if(state is Done){
          var data = state .model as SortModel;
          if(data.data ==null){
            return NoData(
              message: data.msg,
            );
          }else {
            return StreamBuilder<SortModel>(
              stream: sort_bloc.sort_products_subject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> gallery = new List<String>();

                  return GridView.builder(

                      itemCount: snapshot.data.data.products.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 9 / 14,
                        //  childAspectRatio: StaticData.get_width(context) * 0.002,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        snapshot.data.data.products[index].files.forEach((
                            element) {
                          gallery.add(element.url);
                        });
                        return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xfff7f7f7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),


                              ),


                            ),
                            child: Row(
                                children: [
                                  SizedBox(
                                    width: StaticData.get_width(context) * .03,
                                  ),
                                  InkWell(onTap: () {


                                  },
                                      child: Directionality(
                                          textDirection: translator
                                              .currentLanguage == 'ar'
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      StaticData.get_height(
                                                          context) * .015)),
                                            ),
                                            height: StaticData.get_height(
                                                context) * .35,
                                            width: StaticData.get_width(
                                                context) * .4,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
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
                                                    CustomFauvourite(
                                                      color: redColor,
                                                      favourite_status: snapshot
                                                          .data.data
                                                          .products[index]
                                                          .inFavorite == 0
                                                          ? false
                                                          : true,
                                                      product_id: snapshot.data
                                                          .data.products[index]
                                                          .id,
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: StaticData
                                                          .get_width(context) *
                                                          .01),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          RatingBar.readOnly(
                                                            initialRating: snapshot
                                                                .data.data
                                                                .products[index]
                                                                .totalRate
                                                                .toDouble(),
                                                            maxRating: 5,
                                                            isHalfAllowed: true,
                                                            halfFilledIcon: Icons
                                                                .star_half,
                                                            filledIcon: Icons
                                                                .star,
                                                            emptyIcon: Icons
                                                                .star_border,

                                                            size: StaticData
                                                                .get_width(
                                                                context) * 0.03,
                                                            filledColor: (snapshot
                                                                .data.data
                                                                .products[index]
                                                                .totalRate
                                                                .toDouble() >=
                                                                1)
                                                                ? Colors.yellow
                                                                .shade700
                                                                : Colors.yellow
                                                                .shade700,
                                                          ),
                                                          SizedBox(
                                                            width: StaticData
                                                                .get_width(
                                                                context) * .02,
                                                          ),
                                                          MyText(
                                                            text: "(${snapshot
                                                                .data.data
                                                                .products[index]
                                                                .countRates})",
                                                            size: StaticData
                                                                .get_height(
                                                                context) * .015,
                                                            color: greyColor,
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Container(
                                                                alignment: translator
                                                                    .currentLanguage ==
                                                                    'ar'
                                                                    ? Alignment
                                                                    .centerRight
                                                                    : Alignment
                                                                    .centerLeft,
                                                                child: MyText(
                                                                    text: "${snapshot
                                                                        .data
                                                                        .data
                                                                        .products[index]
                                                                        .name} ",
                                                                    size: StaticData
                                                                        .get_height(
                                                                        context) *
                                                                        .017,
                                                                    color: blackColor),
                                                              )

                                                          )
                                                        ],
                                                      ),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  MyText(
                                                                    text: "${snapshot
                                                                        .data
                                                                        .data
                                                                        .products[index]
                                                                        .priceAfterDiscount} ${translator
                                                                        .translate(
                                                                        "SAR")}",
                                                                    size: StaticData
                                                                        .get_height(
                                                                        context) *
                                                                        .017,
                                                                    color: blackColor,
                                                                    weight: FontWeight
                                                                        .normal,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "${snapshot
                                                                        .data
                                                                        .data
                                                                        .products[index]
                                                                        .price} ${translator
                                                                        .translate(
                                                                        "SAR")}",
                                                                    style: TextStyle(
                                                                        decoration: TextDecoration
                                                                            .lineThrough,
                                                                        fontSize: StaticData
                                                                            .get_height(
                                                                            context) *
                                                                            .011,
                                                                        color: greyColor),
                                                                  ),
                                                                  SizedBox(
                                                                    width: StaticData
                                                                        .get_width(
                                                                        context) *
                                                                        .02,
                                                                  ),
                                                                  MyText(
                                                                      text: "${snapshot
                                                                          .data
                                                                          .data
                                                                          .products[index]
                                                                          .discount}%",
                                                                      size: StaticData
                                                                          .get_height(
                                                                          context) *
                                                                          .011,
                                                                      color: greenColor),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .all(
                                                                  StaticData
                                                                      .get_height(
                                                                      context) *
                                                                      .01),
                                                              height: StaticData
                                                                  .get_height(
                                                                  context) *
                                                                  .05,
                                                              width: StaticData
                                                                  .get_width(
                                                                  context) * .1,
                                                              decoration: BoxDecoration(
                                                                  color: greenColor,
                                                                  borderRadius: BorderRadius
                                                                      .only(
                                                                      topRight: Radius
                                                                          .circular(
                                                                          StaticData
                                                                              .get_height(
                                                                              context) *
                                                                              .01),
                                                                      bottomLeft: Radius
                                                                          .circular(
                                                                          StaticData
                                                                              .get_height(
                                                                              context) *
                                                                              .01))),
                                                              child: Image
                                                                  .asset(
                                                                  "assets/images/cart_white.png")),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )))
                                ])
                        );
                      });
                }
                else if (snapshot.hasError) {
                  return Container(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: SpinKitFadingCircle(color: greenColor),
                  );;
                }
              },

            );
          }
        }else if(state is ErrorLoading){
          return NoData(
            message: 'There is Error',
          );
        }

      },
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
            left: width * .075, right: width * .075, ),
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
                              return CustomCircleNavigationBar();
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
                          text: translator.translate("SORT RESULT"),
                          size:EzhyperFont.primary_font_size,
                          weight: FontWeight.bold,
                        )
                    ),
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
    )
    ;
  }

}