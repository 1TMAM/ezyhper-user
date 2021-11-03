import 'package:ezhyper/Bloc/Category_Bloc/category_bloc.dart';
import 'package:ezhyper/Bloc/Filter_Bloc/filter_bloc.dart';
import 'package:ezhyper/Bloc/Product_Bloc/product_bloc.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart';
import 'package:ezhyper/Model/FilterModel/brand_model.dart';
import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Model/FilterModel/size_model.dart';
import 'package:ezhyper/Model/ProductModel/product_model.dart';
import 'package:ezhyper/Screens/Filter/categories_selection.dart';
import 'package:ezhyper/Screens/Filter/filter_result_screen.dart';
import 'package:ezhyper/Widgets/custom_range_slider.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/fileExport.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with TickerProviderStateMixin {
  //SfRangeValues sliderValue = SfRangeValues(0.0, 500.0);
  bool radioValue;
  String minutes = " ";
  var rating;
  TextEditingController from_controller = TextEditingController();
  TextEditingController to_controller = TextEditingController();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  AnimationController _loginButtonController;
  bool isLoading = false;

  String _categoryvalue;
  String _bandvalue;
  String _sizevalue;
  String _pricevalue;
  int _ratevalue;
  List price_chosses;
  @override
  void initState() {
    price_chosses = [
      'all',
      'Under 10 SAR',
      '10 SAR - 20 SAR',
      '20 SAR - 30 SAR',
      '30 SAR - 50 SAR',
      '50 SAR & Above'
    ];
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    rating = 0.0;
    categoryBloc.add(getAllCategories());
    filter_bloc.add(FilterBrandEvent());
    filter_bloc.add(FilterSizeEvent());
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    categoryBloc.dispose();

    super.dispose();
  }
  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: WillPopScope(
              onWillPop: (){
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return CustomCircleNavigationBar(page_index: 4,);                    },
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
              child: Scaffold(
                  key: _drawerKey,
                  backgroundColor: whiteColor,
                  body: Directionality(
                    textDirection: translator.currentLanguage == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Container(
                      child: Column(
                        children: [topPart(), Expanded(child: buildBody())],
                      ),
                    ),
                  )),
            )
        ));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocListener<ProductBloc, AppState>(
        bloc: product_bloc,
        listener: (context, state) {
          if (state is Loading) {
            if (state.indicator == 'filter') {
              CircularProgressIndicator();
            } else {}
          } else if (state is ErrorLoading) {
            if (state.indicator == 'filter') {
              var data = state.model as ProductModel;
              _stopAnimation();
              Flushbar(
                messageText: Row(
                  children: [
                    Text(
                      '${data.msg}',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: whiteColor),
                    ),
                    Spacer(),
                    Text(
                      translator.translate("Try Again"),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: whiteColor),
                    ),
                  ],
                ),
                flushbarPosition: FlushbarPosition.BOTTOM,
                backgroundColor: redColor,
                flushbarStyle: FlushbarStyle.FLOATING,
                duration: Duration(seconds: 6),
              )..show(_drawerKey.currentState.context);
            } else {}
          } else if (state is Done) {
            print("done");
            if (state.indicator == 'filter') {
              _stopAnimation();
              print("filter dispise 1");
 /*             sharedPreferenceManager.removeData(CachingKey.CATEGORY_ID);
              sharedPreferenceManager.removeData(CachingKey.BRAND_ID);
              sharedPreferenceManager.removeData(CachingKey.SIZE_ID);
              sharedPreferenceManager.removeData(CachingKey.FILTER_RATE);
              sharedPreferenceManager.removeData(CachingKey.STRART_PRICE);
              sharedPreferenceManager.removeData(CachingKey.END_PRICE);*/
              from_controller.clear();
              to_controller.clear();
              print("filter dispise 2");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FilterResultScreen()));

            } else {}
          }
        },
        child: Directionality(
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
                    padding: EdgeInsets.only(
                        right: width * .075, left: width * .075),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * .01,
                          ),
                          textCategory(),
                          SizedBox(
                            height: height * .01,
                          ),
                        //  CategoriesSelection(),
                          filteringCategoriesContainer(),
                          SizedBox(
                            height: height * .02,
                          ),
                          textBrand(),
                          SizedBox(
                            height: height * .01,
                          ),
                          filteringBrandContainer(),
                          SizedBox(
                            height: height * .02,
                          ),
                          textSize(),
                          SizedBox(
                            height: height * .01,
                          ),
                          filteringSizeContainer(),
                          SizedBox(
                            height: height * .02,
                          ),
                          textSPrice(),
                          SizedBox(
                            height: height * .02,
                          ),
                          /*  textPriceRange(),
                  SizedBox(
                    height: height * .01,

                  ),
                      CustomRangeSlider(
                        min: 0.0,
                        max: 10000.0,
                        start: 0.0,
                        end: 5000.0,
                        divisions: 100,
                        header: translator.translate("Price Range"),
                        cachingKeyStart: CachingKey.STRART_PRICE,
                        cachingKeyEnd: CachingKey.END_PRICE,
                      ),

                       */

                          filteringPriceContainer(),
                          SizedBox(
                            height: height * .03,
                          ),
                          textRate(),
                          SizedBox(
                            height: height * .01,
                          ),
                          filteringRateContainer(),
                          //rateOptions(),
                          apply_filter()
                        ],
                      ),
                    )))));
  }

  Widget textRate() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [MyText(text: translator.translate("Rate"))],
    );
  }

  Widget priceFilterTextFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        from_priceFilterTextField(hint: "From Price"),
        to_priceFilterTextField(hint: "To Proce ")
      ],
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
                      text: translator.translate("FILTER"),
                      size:  EzhyperFont.primary_font_size,
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

  Widget textCategory() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [MyText(text: translator.translate("CATEGORIES"),size: EzhyperFont.primary_font_size,weight: FontWeight.bold,)],
    );
  }

  Widget textBrand() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [MyText(text: translator.translate("Brand"),size: EzhyperFont.primary_font_size,weight: FontWeight.bold,)],
    );
  }

  Widget textSize() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [MyText(text: translator.translate("Size"),size: EzhyperFont.primary_font_size,weight: FontWeight.bold,)],
    );
  }

  Widget textSPrice() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [MyText(text: translator.translate("Price Range"),size: EzhyperFont.primary_font_size,weight: FontWeight.bold,)],
    );
  }

  Widget filteringCategoriesContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder(
      bloc: categoryBloc,
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        } else if (state is Done) {
          var data = state .model as CategoryModel;
          if(data.data ==null){
            return NoData(
              message: data.msg,
            );
          }else {
          return StreamBuilder<CategoryModel>(
            stream: categoryBloc.categories_subject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data.isEmpty) {
                  return Container();
                } else {
                  return Container(
                 //   height: snapshot.data.data.length > 3 ? width * .6 : null,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius:
                        BorderRadius.all(Radius.circular(height * .02))),
                    child: ListView.builder(
                        itemCount: snapshot.data.data.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data.data.length == 1) {
                            sharedPreferenceManager.writeData(
                                CachingKey.CATEGORY_ID,
                                snapshot.data.data[0].id);
                          }
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xfff7f7f7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                            ),
                            child: Container(
                              child: ListTile(
                                title:
                                Text('${snapshot.data.data[index].name}'),
                                leading: Radio(
                                  value: snapshot.data.data[index].name,
                                  groupValue: _categoryvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      _categoryvalue = value;
                                      sharedPreferenceManager.writeData(
                                          CachingKey.CATEGORY_ID,
                                          snapshot.data.data[index].id);
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
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
    );
  }

  Widget filteringBrandContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder(
      bloc: filter_bloc,
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        } else if (state is Done) {
            return StreamBuilder<BrandModel>(
              stream: filter_bloc.brand_subject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data.brand_data.isEmpty) {
                    return Container();
                  } else {
                    return Container(
                   //   height: snapshot.data.data.brand_data.length > 3 ? width * .6 : null,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(height * .02))),
                      child: ListView.builder(
                          itemCount: snapshot.data.data.brand_data.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data.data.brand_data.length == 1) {
                              sharedPreferenceManager.writeData(
                                  CachingKey.BRAND_ID,
                                  snapshot.data.data.brand_data[0].id);
                            }
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xfff7f7f7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              child: Container(
                                child: ListTile(
                                  title: Text(
                                      '${snapshot.data.data.brand_data[index]
                                          .name}'),
                                  leading: Radio(
                                    value:
                                    snapshot.data.data.brand_data[index].name,
                                    groupValue: _bandvalue,
                                    onChanged: (value) {
                                      setState(() {
                                        _bandvalue = value;
                                        sharedPreferenceManager.writeData(
                                            CachingKey.BRAND_ID,
                                            snapshot
                                                .data.data.brand_data[index]
                                                .id);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
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
    );
  }

  Widget filteringSizeContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder(
      bloc: filter_bloc,
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        } else if (state is Done) {

            return StreamBuilder<SizeModel>(
              stream: filter_bloc.size_subject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data.size_data.isEmpty) {
                    return Container();
                  } else {
                    return Container(
                  //    height: snapshot.data.data.size_data.length > 3 ? width * .6 : null,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(height * .02))),
                      child: ListView.builder(
                          itemCount: snapshot.data.data.size_data.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data.data.size_data.length == 1) {
                              sharedPreferenceManager.writeData(
                                  CachingKey.SIZE_ID,
                                  snapshot.data.data.size_data[0].id);
                            }
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xfff7f7f7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              child: Container(
                                child: ListTile(
                                  title: Text(
                                      '${snapshot.data.data.size_data[index]
                                          .name}'),
                                  leading: Radio(
                                    value:
                                    snapshot.data.data.size_data[index].name,
                                    groupValue: _sizevalue,
                                    onChanged: (value) {
                                      setState(() {
                                        _sizevalue = value;
                                        sharedPreferenceManager.writeData(
                                            CachingKey.SIZE_ID,
                                            snapshot
                                                .data.data.size_data[index].id);
                                      });
                                    },
                                  ),
                                ),


                              ),
                            );
                          }),
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
    );
  }

  Widget filteringPriceContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(height * .02))),
        child: Column(
          children: [
            ListView.builder(
                itemCount: price_chosses.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xfff7f7f7),
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    child: Container(
                      child: ListTile(
                        title: Text('${price_chosses[index]}'),
                        leading: Radio(
                          value: price_chosses[index],
                          groupValue: _pricevalue,
                          onChanged: (value) {
                            setState(() {
                              _pricevalue = value;
                              switch (price_chosses[index]) {
                                case 'all':
                                  sharedPreferenceManager.writeData(
                                      CachingKey.STRART_PRICE, 0.0);
                                  sharedPreferenceManager.writeData(
                                      CachingKey.END_PRICE, 100000.0);
                                  break;
                                case 'Under 10 SAR':
                                  sharedPreferenceManager.writeData(
                                      CachingKey.STRART_PRICE, 0.0);
                                  sharedPreferenceManager.writeData(
                                      CachingKey.END_PRICE, 10.0);
                                  break;
                                case '10 SAR - 20 SAR':
                                  sharedPreferenceManager.writeData(
                                      CachingKey.STRART_PRICE, 10.0);
                                  sharedPreferenceManager.writeData(
                                      CachingKey.END_PRICE, 20.0);
                                  break;
                                case '20 SAR - 30 SAR':
                                  sharedPreferenceManager.writeData(
                                      CachingKey.STRART_PRICE, 20.0);
                                  sharedPreferenceManager.writeData(
                                      CachingKey.END_PRICE, 30.0);
                                  break;
                                case '30 SAR - 50 SAR':
                                  sharedPreferenceManager.writeData(
                                      CachingKey.STRART_PRICE, 30.0);
                                  sharedPreferenceManager.writeData(
                                      CachingKey.END_PRICE, 50.0);
                                  break;
                                case '50 SAR & Above':
                                  sharedPreferenceManager.writeData(
                                      CachingKey.STRART_PRICE, 50.0);
                                  sharedPreferenceManager.writeData(
                                      CachingKey.END_PRICE, 100000.0);
                                  break;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  );
                }),
            priceFilterTextFieldRow()
          ],
        ));
  }

  Widget filteringRateContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          child: Container(
            child: ListTile(
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                ],
              ),
              leading: Radio(
                value: 5,
                groupValue: _ratevalue,
                onChanged: (value) {
                  setState(() {
                    _ratevalue = value;
                    sharedPreferenceManager.writeData(CachingKey.FILTER_RATE, _ratevalue);
                  });

                },
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          child: Container(
            child: ListTile(
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),

                ],
              ),
              leading: Radio(
                value: 4,
                groupValue: _ratevalue,
                onChanged: (value) {
                  setState(() {
                    _ratevalue = value;
                    sharedPreferenceManager.writeData(CachingKey.FILTER_RATE, _ratevalue);
                  });
                },
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          child: Container(
            child: ListTile(
              title: Row(
                children: [

                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                ],
              ),
              leading: Radio(
                value: 3,
                groupValue: _ratevalue,
                onChanged: (value) {
                  setState(() {
                    _ratevalue = value;
                    sharedPreferenceManager.writeData(CachingKey.FILTER_RATE, _ratevalue);
                  });
                },
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          child: Container(
            child: ListTile(
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),
                ],
              ),
              leading: Radio(
                value: 2,
                groupValue: _ratevalue,
                onChanged: (value) {
                  setState(() {
                    _ratevalue = value;
                    sharedPreferenceManager.writeData(CachingKey.FILTER_RATE, _ratevalue);
                  });
                },
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          child: Container(
            child: ListTile(
              title: Row(
                children: [

                  Image.asset(
                    "assets/images/star_sm.png",
                    height: height * .03,
                  ),
                  SizedBox(
                    width: width * .01,
                  ),

                ],
              ),
              leading: Radio(
                value: 1,
                groupValue: _ratevalue,
                onChanged: (value) {
                  setState(() {
                    _ratevalue = value;
                    sharedPreferenceManager.writeData(CachingKey.FILTER_RATE, _ratevalue);
                  });
                },
              ),
            ),
          ),
        )

      ],
    );
  }

  Widget from_priceFilterTextField({String hint}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .4,
          height: height * .07,
          child: TextFormField(
            controller: from_controller,
            keyboardType: TextInputType.number,
            style: TextStyle(
                color: greyColor,
                fontSize:EzhyperFont.primary_font_size),
            obscureText: false,
            cursorColor: greyColor,
            onChanged: (text) {
              sharedPreferenceManager.writeData(CachingKey.STRART_PRICE, text);
            },
            decoration: InputDecoration(
              suffixIcon: Container(
                  padding: EdgeInsets.all(height * .012), child: SizedBox()),
              hintText: hint,
              hintStyle: TextStyle(
                  color: Color(0xffA0AEC0).withOpacity(
                    .8,
                  ),
                  fontSize: height * .018),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: greenColor)),
            ),
          ),
        ),
      ],
    );
  }

  Widget to_priceFilterTextField({String hint}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .4,
          height: height * .07,
          child: TextFormField(
            controller: to_controller,
            keyboardType: TextInputType.number,
            onChanged: (text) {
              sharedPreferenceManager.writeData(CachingKey.END_PRICE, text);
            },
            style: TextStyle(
                color: greyColor,
                fontSize:EzhyperFont.primary_font_size),
            obscureText: false,
            cursorColor: greyColor,
            decoration: InputDecoration(
              suffixIcon: Container(
                  padding: EdgeInsets.all(height * .012), child: SizedBox()),
              hintText: hint,
              hintStyle: TextStyle(
                  color: Color(0xffA0AEC0).withOpacity(
                    .8,
                  ),
                  fontSize: height * .018),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: greenColor)),
            ),
          ),
        ),
      ],
    );
  }

  Widget apply_filter() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: width * 0.1),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              givenHeight: height * .07,
              givenWidth: width * .35,
              onTapFunction: () {
                sharedPreferenceManager.removeData(CachingKey.CATEGORY_ID);
                sharedPreferenceManager.removeData(CachingKey.BRAND_ID);
                sharedPreferenceManager.removeData(CachingKey.SIZE_ID);
                sharedPreferenceManager.removeData(CachingKey.FILTER_RATE);
                sharedPreferenceManager.removeData(CachingKey.STRART_PRICE);
                sharedPreferenceManager.removeData(CachingKey.END_PRICE);
                from_controller.clear();
                to_controller.clear();

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
              },
              text: translator.translate("DISCARD"),
              textColor: greenColor,
              fontSize:EzhyperFont.header_font_size,
              radius: height * .05,
              buttonColor: whiteColor,
            ),
            SizedBox(
              width: width * 0.1,
            ),
            CustomButton(
              givenHeight: height * .07,
              givenWidth: width * .35,
              onTapFunction: () async {
                product_bloc.add(FilterProductsEvent(
                  price_from: await sharedPreferenceManager
                          .readDouble(CachingKey.STRART_PRICE) ??
                      0.0,
                  price_to: await sharedPreferenceManager
                      .readDouble(CachingKey.END_PRICE),
                  rate: await sharedPreferenceManager
                      .readInteger(CachingKey.FILTER_RATE),
                  categories_id: await sharedPreferenceManager
                      .readInteger(CachingKey.CATEGORY_ID),
                  brand_id: await sharedPreferenceManager
                      .readInteger(CachingKey.BRAND_ID),
                  size_id: await sharedPreferenceManager
                      .readInteger(CachingKey.SIZE_ID),
                  offset: 1
                ));
              },
              text: translator.translate("Apply"),
              fontSize:EzhyperFont.header_font_size,
              radius: height * .05,
            ),
          ],
        ),
      ),
    );
  }
}
