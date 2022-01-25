import 'package:ezhyper/Bloc/Offers_Bloc/offers_bloc.dart';
import 'package:ezhyper/Model/OffersModel/offer_model.dart';
import 'package:ezhyper/Screens/Filter/filterScreen.dart';
import 'package:ezhyper/Widgets/customWidgets.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  TextEditingController controller;
  String search_text = '';

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CustomCircleNavigationBar()));
      },
      child: Scaffold(
          backgroundColor: whiteColor,
          body: Directionality(
              textDirection: translator.currentLanguage == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                  child: Column(children: [
                topPart(),
                SizedBox(
                  height: height * .0,
                ),
                Container(
                    padding: EdgeInsets.only(
                        right: width * .075, left: width * .075, top: height * .02, bottom: height * .02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(height * .05),
                            topRight: Radius.circular(height * .05)),
                        color: backgroundColor),
                    child: searchTextFieldAndFilterPart()
                ),
                Expanded(
                    child: Container(
                        color: backgroundColor,
                        child: BlocBuilder(
                          bloc: offersBloc,
                          builder: (context, state) {
                            if (state is Loading) {
                              return Center(
                                child: SpinKitFadingCircle(color: greenColor),
                              );
                            } else if (state is Done) {
                              var data = state.model as OfferModel;
                              if (data.data == null) {
                                return NoData(
                                  message: data.msg,
                                );
                              }
                              else {
                                return StreamBuilder<OfferModel>(
                                  stream: offersBloc.offers_subject,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.data.isEmpty) {
                                        return Container();
                                      } else {
                                        return GridView.builder(
                                            itemCount:
                                                snapshot.data.data.length,
                                            physics: NeverScrollableScrollPhysics(),

                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 9 / 14,
                                              //childAspectRatio: StaticData.get_width(context) * 0.002,
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              String name = snapshot.data
                                                  .data[index].product.name;
                                              return name.contains(search_text)
                                                  ? Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0,
                                                              vertical: 0),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff7f7f7),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(0),
                                                        ),
                                                      ),
                                                      child: snapshot
                                                                  .data
                                                                  .data[index]
                                                                  .product ==
                                                              null
                                                          ? Container()
                                                          : OfferShape(
                                                              offer: snapshot
                                                                  .data
                                                                  .data[index],
                                                            ),
                                                    )
                                                  : Container();
                                            });
                                      }
                                    } else if (snapshot.hasError) {
                                      return Container(
                                        child: Text('${snapshot.error}'),
                                      );
                                    } else {
                                      return Center(
                                        child: SpinKitFadingCircle(
                                            color: greenColor),
                                      );
                                      ;
                                    }
                                  },
                                );
                              }
                            } else if (state is ErrorLoading) {
                              return NoData(
                                message: 'There is Error',
                              );
                            } else {
                              return Center(
                                child: SpinKitFadingCircle(color: greenColor),
                              );
                            }
                          },
                        )

                        /*OffersView(
                        view_type: 'GridView',
                      )*/

                        ))
              ])))),
    )));
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
                      text: translator.translate("OFFERS"),
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
                  child: InkWell(
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
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchTextFieldAndFilterPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: width * .53,
              height: height * .07,
              child: Container(
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(
                      color: greyColor,
                      fontSize:EzhyperFont.primary_font_size),
                  cursorColor: greyColor,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          search_text = controller.value.text;
                          print("search_text :${search_text}");
                        });
                      },
                      icon: Image.asset(
                        "assets/images/search_gray.png",
                      ),
                    ),
                    hintText:
                        translator.translate("What Are You Loking For ? "),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize:EzhyperFont.secondary_font_size),
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
              )),
          InkWell(
            onTap: () {
              CustomComponents.filterProductInfoBottomSheet(
                context: context,
                data: [
                  translator.translate('Top Rated'),
                  translator.translate("Most Selling"),
                  translator.translate("price : low to high"),
                  translator.translate("price : high to low"),
                  translator.translate("unit price : low to high"),
                  translator.translate("unit price : high to low"),
                ],
              );
            },
            child: Container(
              padding: EdgeInsets.all(height * .015),
              height: height * .075,
              width: width * .15,
              decoration:
                  BoxDecoration(color: whiteColor, shape: BoxShape.circle),
              child: Image.asset("assets/images/sort_outline.png"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FilterScreen()));
            },
            child: Container(
              padding: EdgeInsets.all(height * .015),
              height: height * .075,
              width: width * .15,
              decoration:
                  BoxDecoration(color: whiteColor, shape: BoxShape.circle),
              child: Image.asset("assets/images/filter_outline.png"),
            ),
          )
        ],
      ),
    );
  }
}
