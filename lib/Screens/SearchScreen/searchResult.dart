import 'package:ezhyper/Bloc/Search_Bloc/search_bloc.dart';
import 'package:ezhyper/Model/SearchModel/search_model.dart';
import 'package:ezhyper/Screens/Filter/filterScreen.dart';
import 'package:ezhyper/Widgets/custom_favourite.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/Widgets/product_slider.dart';
import 'file:///D:/Wothoq%20Tech/ezhyper/code/ezhyper/lib/Screens/SearchScreen/auto_search_class.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rating_bar/rating_bar.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  TextEditingController controller = new TextEditingController();
  @override
  void initState() {
    search_bloc.add(SearchProductsEvent(
        columns: ['name_ar'],
        operand: ['like'],
        columns_values: ['']

    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
              backgroundColor: whiteColor,
              body:  Directionality(
                  textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
                  child:Container(
                      child: Column(
                          children: [
                            topPart(),
                            SizedBox(height: height*.0,),
                            Container(padding: EdgeInsets.only(right: width*.075,left: width*.075,top: height*.02,
                                bottom: height*.02),decoration:
                            BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(height*.05),
                                topRight:Radius.circular(height*.05)),color: backgroundColor),

                                child: searchTextFieldAndFilterPart()

                            ),
                            Expanded(child: Container(color: backgroundColor,
                                child: gridView()))

                          ]))),


            )));
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
                //     width: width * .4,
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
                          text: translator.translate("SEARCH RESULT"),
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

  Widget searchTextFieldAndFilterPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AdvancedSearchClass(),
            /*      Container(
              width: width * .53,
              height: height * .07,
              child: Container(
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(color: greyColor, fontSize:EzhyperFont.primary_font_size),
                  cursorColor: greyColor,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: (){
                        search_bloc.add(SearchProductsEvent(
                            columns: ['name_ar'],
                            operand: ['like'],
                            columns_values: [controller.text]

                        ));
                      },
                      icon: Icon(
                        Icons.search,
                        color: greyColor,
                        size: height * .035,
                      ),
                    ),
                    hintText: translator.translate("What Are You Loking For ? "),
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize:EzhyperFont.secondary_font_size),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: greenColor)),
                  ),
                ),
              )),*/
            InkWell(
              onTap: (){
                CustomComponents.filterProductInfoBottomSheet(
                  context: context,
                  data:
                  [translator.translate('Top Rated') ,
                    translator.translate("Most Selling"),
                    translator.translate("price : low to high"),
                    translator.translate("price : high to low"),
                    translator.translate("unit price : low to high"),
                    translator.translate("unit price : high to low"),
                  ],
                );
              },
              child: Container(padding: EdgeInsets.all(height*.015),
                height: height * .075,
                width: width * .15,
                decoration:
                BoxDecoration(color: whiteColor, shape: BoxShape.circle),
                child: Image.asset("assets/images/sort_outline.png"),
              ),
            ),

            Container(padding: EdgeInsets.all(height*.017),
              height: height * .075,
              width: width * .15,
              decoration:
              BoxDecoration(color: whiteColor, shape: BoxShape.circle),
              child: InkWell(onTap: (){
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return FilterScreen();
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
                  child: Image.asset("assets/images/filter_outline.png")),
            ),
          ],
        ),
      ),
    );
  }
  Widget gridView(){
    return Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:BlocBuilder(
          cubit: search_bloc,
          builder: (context,state){
            if(state is Loading){
              return Center(
                child: SpinKitFadingCircle(color: greenColor),
              );
            }else if(state is Done) {
              var data = state .model as SearchModel;
              if(data.data ==null){
                return NoData(
                  message: data.msg,
                );
              }else {
                return StreamBuilder<SearchModel>(
                  stream: search_bloc.search_products_subject,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> gallery = [];
                      if (snapshot.data.data == null) {
                        return NoData(
                          message: "there is No Data",
                        );
                      } else {
                        return GridView.builder(

                            itemCount: snapshot.data.data.products.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 9 / 14,
                              // childAspectRatio: StaticData.get_width(context) * 0.002,
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

                                          /*    Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) {
                                         return RecommendedProductDetails(
                                            recomended_product: widget.recomended_product,
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
                                  );*/

                                        },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        StaticData.get_height(
                                                            context) * .015)),
                                              ),
                                              height: StaticData.get_height(context) *
                                                  .35,
                                              width: StaticData.get_width(context) *
                                                  .4,
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
                                                            .data.data.products[index]
                                                            .inFavorite == 0
                                                            ? false
                                                            : true,
                                                        product_id: snapshot.data.data
                                                            .products[index].id,
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: StaticData.get_width(
                                                            context) * .01),
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
                                                              filledIcon: Icons.star,
                                                              emptyIcon: Icons
                                                                  .star_border,

                                                              size: StaticData
                                                                  .get_width(
                                                                  context) * 0.03,
                                                              filledColor: (snapshot
                                                                  .data.data
                                                                  .products[index]
                                                                  .totalRate
                                                                  .toDouble() >= 1)
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
                                                              text: "(${snapshot.data
                                                                  .data
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
                                                            Container(

                                                              child: MyText(
                                                                  text: "${snapshot
                                                                      .data.data
                                                                      .products[index]
                                                                      .name} ",
                                                                  size: StaticData
                                                                      .get_height(
                                                                      context) * .014,
                                                                  color: blackColor),
                                                            ),
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
                                                                          .data.data
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
                                                                      "${snapshot.data
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
                                                                            .data.data
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
                                                                    .all(StaticData
                                                                    .get_height(
                                                                    context) * .01),
                                                                height: StaticData
                                                                    .get_height(
                                                                    context) * .05,
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
                                                                child: Image.asset(
                                                                    "assets/images/cart_white.png")),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        )
                                      ])
                              );
                            });
                      }
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
                message: 'There is NO Data',
              );
            }

          },
        )   );

  }
}
