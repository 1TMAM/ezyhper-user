import 'package:ezhyper/Bloc/Category_Bloc/category_bloc.dart';
import 'package:ezhyper/Bloc/Product_Bloc/product_bloc.dart';
import 'package:ezhyper/Model/CategoryModel/second_lvel_subcategory_model.dart';
import 'package:ezhyper/Screens/Category/subcategory_products_result.dart';
import 'package:ezhyper/Screens/Filter/filterScreen.dart';
import 'package:ezhyper/Screens/Product/product_shape.dart';
import 'package:ezhyper/Screens/Product/product_view.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart'
    as category_model;
import 'package:ezhyper/Model/ProductModel/product_model.dart' as product_model;

class ProductsGridList extends StatefulWidget {
  final String page_name;
  final String category_id;
  final String category_name;
  List<category_model.SubCategory> subCategory_list;
  ProductsGridList(
      {this.page_name,
      this.category_id,
      this.category_name,
      this.subCategory_list});
  @override
  _ProductsGridListState createState() => _ProductsGridListState();
}

class _ProductsGridListState extends State<ProductsGridList> {
  String search_text = '';
  TextEditingController controller;

  int subcategory_click;
  int second_level_subcategory_click;

  bool second_sub_Category_status = false;
  var offset = 1;
  ScrollController _controller;
  final product_bloc = ProductBloc(null);

  @override
  void initState() {
    controller = TextEditingController();

    print("--------- ProductsGridList -----------");
    subcategory_click = 1;
    second_level_subcategory_click = 1;
    switch (second_sub_Category_status
        ? 'ShowSecondLevelSubcCategoryProducts'
        : widget.page_name) {
      case 'RecommendedProducts':
        product_bloc.add(getRecommendedProduct_click(offset: offset));
        break;
      case 'MostSellingProducts':
        product_bloc.add(getMostSellingProduct_click(offset: offset));
        break;
      case 'purchasedProducts':
        product_bloc.add(getPurchasedProduct_click(offset: offset));
        break;
      case 'categoryProducts':
        product_bloc.add(getCategoryProducts(
            category_id: widget.category_id, offset: offset));
        break;


      case 'ShowSecondLevelSubcCategoryProducts':
        product_bloc.add(getSecondLevelSubCategoryProducts(
            secon_level_subcategory_id: widget.category_id,
            offset: offset
        ));
        break;
    }
    super.initState();
  }

  @override
  void dispose() {
    product_bloc.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    switch (second_sub_Category_status ? 'ShowSecondLevelSubcCategoryProducts' : widget.page_name) {
      case 'RecommendedProducts':
        return NetworkIndicator(
            child: PageContainer(
                child: Scaffold(
                    backgroundColor: whiteColor,
                    body: Container(
                        color: backgroundColor,
                        child: Column(children: [
                            topPart(),
                        SizedBox(
                          height: height * .0,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Column(children: [
                                //subcategories list
                                widget.page_name == 'categoryProducts'
                                ? widget.subCategory_list == null
                                    ? Container()
                                    : subCategory_list()
                                : Container(),
                        SizedBox(
                          height: width * 0.02,
                        ),
                        //second level subcategories list
                        second_sub_Category_status
                            ? second_subCategory_list()
                            : Container(),

                        Container(
                            padding: EdgeInsets.only(
                                right: width * .075,
                                left: width * .075,
                                top: height * .02,
                                bottom: height * .02),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(height * .05),
                                    topRight:
                                    Radius.circular(height * .05)),
                                color: backgroundColor),
                            child: searchTextFieldAndFilterPart()),
                        StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.recomended_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  controller: _controller,
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String name = snapshot.data[index].name;

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xfff7f7f7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      child: index >= snapshot.data.length
                          ? MyLoader(25, 25)
                          : snapshot.data[index] == null
                              ? Container()
                              : name !=null? name.contains(search_text) ? ProductShape(
                                  product: snapshot.data[index],
                                ) : Container() : Container(),
                    );
                  });
            } else {
              return MyLoader(45, 45);
            }
          },
        )
                                ])))
                        ])))));
        break;
      case 'MostSellingProducts':
        return NetworkIndicator(
            child: PageContainer(
                child: Scaffold(
                    backgroundColor: whiteColor,
                    body: Container(
                        color: backgroundColor,
                        child: Column(children: [
                            topPart(),
                        SizedBox(
                          height: height * .0,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Column(children: [
                                //subcategories list
                                widget.page_name == 'categoryProducts'
                                ? widget.subCategory_list == null
                                    ? Container()
                                    : subCategory_list()
                                : Container(),
                        SizedBox(
                          height: width * 0.02,
                        ),
                        //second level subcategories list
                        second_sub_Category_status
                            ? second_subCategory_list()
                            : Container(),

                        Container(
                            padding: EdgeInsets.only(
                                right: width * .075,
                                left: width * .075,
                                top: height * .02,
                                bottom: height * .02),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(height * .05),
                                    topRight:
                                    Radius.circular(height * .05)),
                                color: backgroundColor),
                            child: searchTextFieldAndFilterPart()),
                        StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.most_sellingproducts_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  controller: _controller,
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String name = snapshot.data[index].name;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xfff7f7f7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      child: index >= snapshot.data.length
                          ? MyLoader(25, 25)
                          : snapshot.data[index] == null
                              ? Container()
                              : name !=null? name.contains(search_text) ? ProductShape(
                                  product: snapshot.data[index],
                                ) : Container() : Container(),
                    );
                  });
            } else {
              return MyLoader(45, 45);
            }
          },
        )
                                ])))
                        ])))));
        break;
      case 'purchasedProducts':
        return NetworkIndicator(
            child: PageContainer(
            child: Scaffold(
            backgroundColor: whiteColor,
            body: Container(
            color: backgroundColor,
            child: Column(children: [
            topPart(),
    SizedBox(
    height: height * .0,
    ),
    Expanded(
    child: SingleChildScrollView(
    child: Column(children: [
    //subcategories list
    widget.page_name == 'categoryProducts'
    ? widget.subCategory_list == null
    ? Container()
        : subCategory_list()
        : Container(),
    SizedBox(
    height: width * 0.02,
    ),
    //second level subcategories list
    second_sub_Category_status
    ? second_subCategory_list()
        : Container(),

    Container(
    padding: EdgeInsets.only(
    right: width * .075,
    left: width * .075,
    top: height * .02,
    bottom: height * .02),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(height * .05),
    topRight:
    Radius.circular(height * .05)),
    color: backgroundColor),
    child: searchTextFieldAndFilterPart()),

          StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.purchased_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  controller: _controller,
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String name = snapshot.data[index].name;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xfff7f7f7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      child: index >= snapshot.data.length
                          ? MyLoader(25, 25)
                          : snapshot.data[index] == null
                              ? Container()
                              : name !=null? name.contains(search_text) ? ProductShape(
                                  product: snapshot.data[index],
                                ) : Container() : Container(),
                    );
                  });
            } else {
              return MyLoader(45, 45);
            }
          },
          )
              ])))
                ])))));
        break;

      case 'categoryProducts':
        return NetworkIndicator(
            child: PageContainer(
                child: Scaffold(
                    backgroundColor: whiteColor,
                    body: Container(
                        color: backgroundColor,
                        child: Column(children: [
                          topPart(),
                          SizedBox(
                            height: height * .0,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Column(children: [
                            //subcategories list
                            widget.page_name == 'categoryProducts'
                                ? widget.subCategory_list == null
                                    ? Container()
                                    : subCategory_list()
                                : Container(),
                            SizedBox(
                              height: width * 0.02,
                            ),
                            //second level subcategories list
                            second_sub_Category_status
                                ? second_subCategory_list()
                                : Container(),

                            Container(
                                padding: EdgeInsets.only(
                                    right: width * .075,
                                    left: width * .075,
                                    top: height * .02,
                                    bottom: height * .02),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(height * .05),
                                        topRight:
                                            Radius.circular(height * .05)),
                                    color: backgroundColor),
                                child: searchTextFieldAndFilterPart()),


                            BlocBuilder(
                              bloc: product_bloc,
                              builder: (context, state) {
                                if (state is Done) {
                                  return StreamBuilder<
                                      List<product_model.Products>>(
                                    stream: product_bloc.cat_products_subject,
                                    builder: (context, snapshot) {
                                      //     print("%%%%%%% : ${snapshot.data}");
                                      if (snapshot.hasData) {
                                        if (snapshot.data == null) {
                                          return NoData(
                                            image:
                                                "assets/images/img_contactus.png",
                                            title: translator.translate(
                                                "There is no products"),
                                            message: translator.translate(
                                                "If you are facing any problem or if you have a suggestion, please contact us"),
                                          );
                                        } else {
                                          return GridView.builder(
                                              controller: _controller,
                                              shrinkWrap: true,
                                              itemCount: snapshot.data.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 9 / 14,
                                              ),
                                              itemBuilder: (BuildContext context, int index) {
                                                String name = snapshot.data[index].name;

                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xfff7f7f7),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(0),
                                                    ),
                                                  ),
                                                  child: index >=
                                                          snapshot.data.length
                                                      ? MyLoader(25, 25)
                                                      : snapshot.data[index] ==
                                                              null
                                                          ? NoData(
                                                              image:
                                                                  "assets/images/img_contactus.png",
                                                              title: translator
                                                                  .translate(
                                                                      "There is no products"),
                                                              message: translator
                                                                  .translate(
                                                                      "If you are facing any problem or if you have a suggestion, please contact us"),
                                                            )
                                                          : name !=null? name.contains(search_text) ?  ProductShape(
                                                              product: snapshot.data[index],
                                                            ) : Container() : Container,
                                                );
                                              });
                                        }
                                      } else {
                                        /*         return NoData(
                  image: "assets/images/img_contactus.png",
                  title: translator.translate( "There is no products"),
                  message: translator.translate(
                      "If you are facing any problem or if you have a suggestion, please contact us"),
                );*/
                                        return MyLoader(45, 45);
                                      }
                                    },
                                  );
                                } else if (state is ErrorLoading) {
                                  return NoData(
                                    image: "assets/images/img_contactus.png",
                                    title: translator
                                        .translate("There is no products"),
                                    message: translator.translate(
                                        "If you are facing any problem or if you have a suggestion, please contact us"),
                                  );
                                } else {
                                  return MyLoader(45, 45);
                                }
                              },
                            )
                          ])))
                        ])))));

        break;
      case 'filter_result':
        return NetworkIndicator(
            child: PageContainer(
                child: Scaffold(
                    backgroundColor: whiteColor,
                    body: Container(
                        color: backgroundColor,
                        child: Column(children: [
                            topPart(),
                        SizedBox(
                          height: height * .0,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Column(children: [
                                //subcategories list
                                widget.page_name == 'categoryProducts'
                                ? widget.subCategory_list == null
                                    ? Container()
                                    : subCategory_list()
                                : Container(),
                        SizedBox(
                          height: width * 0.02,
                        ),
                        //second level subcategories list
                        second_sub_Category_status
                            ? second_subCategory_list()
                            : Container(),

                        Container(
                            padding: EdgeInsets.only(
                                right: width * .075,
                                left: width * .075,
                                top: height * .02,
                                bottom: height * .02),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(height * .05),
                                    topRight:
                                    Radius.circular(height * .05)),
                                color: backgroundColor),
                            child: searchTextFieldAndFilterPart()),
                        StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.filter_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data.isEmpty){
                return NoData(
                  image: "assets/images/img_contactus.png",
                  title: translator.translate( "There is no products"),
                  message: translator.translate(
                      "If you are facing any problem or if you have a suggestion, please contact us"),
                );
              }else{
                return GridView.builder(
                    controller: _controller,
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 14,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      String name = snapshot.data[index].name;
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
                        child: index >= snapshot.data.length
                            ? MyLoader(25, 25)
                            :  snapshot.data[index] ==
                            null ? Container() :name !=null? name.contains(search_text) ? ProductShape(
                          product: snapshot.data[index] ,
                        ): Container() : Container(),
                      );
                    });
              }

            } else {
              return MyLoader(45, 45);
            }
          },

        )])))
                        ])))));
        break;
      case 'ShowSecondLevelSubcCategoryProducts':

        return  NetworkIndicator(
            child: PageContainer(
            child: Scaffold(
            backgroundColor: whiteColor,
            body: Container(
            color: backgroundColor,
            child: Column(children: [
            topPart(),
    SizedBox(
    height: height * .0,
    ),
    Expanded(
    child: SingleChildScrollView(
    child: Column(children: [
    //subcategories list
    widget.page_name == 'categoryProducts'
    ? widget.subCategory_list == null
    ? Container()
        : subCategory_list()
        : Container(),
    SizedBox(
    height: width * 0.02,
    ),
    //second level subcategories list
    second_sub_Category_status
    ? second_subCategory_list()
        : Container(),

    Container(
    padding: EdgeInsets.only(
    right: width * .075,
    left: width * .075,
    top: height * .02,
    bottom: height * .02),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(height * .05),
    topRight:
    Radius.circular(height * .05)),
    color: backgroundColor),
    child: searchTextFieldAndFilterPart()),
    BlocBuilder(
            bloc: product_bloc,
            builder: (context,state){
              if( state is Done){
                return StreamBuilder<List<product_model.Products>>(
                  stream: product_bloc.second_level_subcatatgory_products_subject,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data ==null){
                        return NoData(
                          image: "assets/images/img_wallet.png",
                          title: translator.translate( "There is no products"),
                          message: translator.translate(
                              "If you are facing any problem or if you have a suggestion, please contact us"),
                        );
                      }else{
                        return GridView.builder(
                            controller: _controller,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 9 / 14,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              String name = snapshot.data[index].name;
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
                                child: index >= snapshot.data.length
                                    ? MyLoader(25, 25)
                                    :  snapshot.data[index] ==
                                    null ? Container() : name !=null? name.contains(search_text) ?ProductShape(
                                  product: snapshot.data[index],
                                )  :Container() : Container(),
                              );
                            });
                      }

                    } else {
                      return MyLoader(45, 45);
                    }
                  },

                );
              }
              else if( state is ErrorLoading){
                return NoData(
                  image: "assets/images/img_contactus.png",
                  title: translator.translate( "There is no products"),
                  message: translator.translate(
                      "If you are facing any problem or if you have a suggestion, please contact us"),
                );
              }
              else{
                return MyLoader(45, 45);

              }
            }
        )      ])))
            ])))));
        break;
      default:
        return Container();
        break;
    }
/*    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
                backgroundColor: whiteColor,
                body: Container(
                    color: backgroundColor,
                    child: Column(children: [
                      topPart(),
                      SizedBox(
                        height: height * .0,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //subcategories list
                            widget.page_name == 'categoryProducts'
                                ? widget.subCategory_list == null
                                    ? Container()
                                    : subCategory_list()
                                : Container(),
                            SizedBox(
                              height: width * 0.02,
                            ),
                            //second level subcategories list
                            second_sub_Category_status
                                ? second_subCategory_list()
                                : Container(),

                            Container(
                                padding: EdgeInsets.only(
                                    right: width * .075,
                                    left: width * .075,
                                    top: height * .02,
                                    bottom: height * .02),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(height * .05),
                                        topRight:
                                            Radius.circular(height * .05)),
                                    color: backgroundColor),
                                child: searchTextFieldAndFilterPart()),

                            Container(
                                color: backgroundColor,
                                child: ProductView(
                                  view_type: 'GridView',
                                  category_id: widget.category_id,
                                  department_name: second_sub_Category_status
                                      ? 'ShowSecondLevelSubcCategoryProducts'
                                      : widget.page_name,
                                ))
                          ],
                        ),
                      )),
                    ])))));*/
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
                        /* Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return  translator.currentLanguage == 'ar' ?
                              CustomCircleNavigationBar(page_index: 4,) : CustomCircleNavigationBar()
                              ;
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
                        Navigator.pop(context);
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
                      text: widget.category_name == null
                          ? translator.translate(widget.page_name)
                          : widget.category_name,
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
                      fontSize: EzhyperFont.primary_font_size),
                  cursorColor: greyColor,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            search_text = controller.value.text;
                            print("search_text :${search_text}");
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: greyColor,
                          size: height * .035,
                        )),
                    hintText: "What Are You Loking For ? ",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: EzhyperFont.secondary_font_size),
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

  Widget subCategory_list() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return widget.subCategory_list.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.only(top: width * 0.02),
            child: Container(
              height: width * 0.1,
              child: ListView.builder(
                  itemCount: widget.subCategory_list.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: subcategory_click ==
                                    widget.subCategory_list[index].id
                                ? greenColor
                                : Colors.grey.shade200,
                          ),
                          child: InkWell(
                              onTap: () {
                                print(
                                    "name : ${widget.subCategory_list[index].nameAr}");
                                setState(() {
                                  subcategory_click =
                                      widget.subCategory_list[index].id;
                                  second_sub_Category_status =
                                      !second_sub_Category_status;
                                  categoryBloc.add(
                                      getSecondLevelSubcategoryEvent(
                                          subcategory_id: widget
                                              .subCategory_list[index].id));
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.05, right: width * 0.05),
                                child: MyText(
                                  text: translator.currentLanguage == 'ar'
                                      ? widget.subCategory_list[index].nameAr
                                      : widget.subCategory_list[index].nameEn,
                                  size: EzhyperFont.header_font_size,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center,
                                  color: subcategory_click ==
                                          widget.subCategory_list[index].id
                                      ? whiteColor
                                      : blackColor,
                                ),
                              )),
                        ));
                  }),
            ),
          );
  }

  Widget second_subCategory_list() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: backgroundColor,
        //  padding: EdgeInsets.only(left: width * 0.1),
        child: BlocBuilder(
          bloc: categoryBloc,
          builder: (context, state) {
            if (state is Loading) {
              return Center(
                child: SpinKitFadingCircle(color: greenColor),
              );
            } else if (state is Done) {
              var data = state.model as SecondLevelSubcategoryModel;
              if (data.data == null) {
                second_sub_Category_status = false;

                return Container();
              } else {
                return StreamBuilder<SecondLevelSubcategoryModel>(
                  stream: categoryBloc.second_level_subcategory_subject,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data == null) {
                        return Container();
                      } else {
                        return widget.subCategory_list.isEmpty
                            ? Container()
                            : Container(
                                height: width * 0.07,
                                child: ListView.builder(
                                    itemCount: snapshot.data.data.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  second_level_subcategory_click ==
                                                          snapshot.data
                                                              .data[index].id
                                                      ? greenColor
                                                      : Colors.grey.shade200,
                                            ),
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    second_level_subcategory_click =
                                                        snapshot.data
                                                            .data[index].id;
                                                    print(
                                                        "second_level_subcategory_click : ${second_level_subcategory_click}");
                                                    // second_sub_Category_status = !second_sub_Category_status;
                                                    product_bloc.add(
                                                        getSecondLevelSubCategoryProducts(
                                                            secon_level_subcategory_id:
                                                                snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .id
                                                                    .toString(),
                                                            offset: offset));
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: width * 0.05,
                                                      right: width * 0.05),
                                                  child: MyText(
                                                    text: snapshot
                                                        .data.data[index].name,
                                                    size: EzhyperFont
                                                        .secondary_font_size,
                                                    weight: FontWeight.normal,
                                                    align: TextAlign.center,
                                                    color:
                                                        second_level_subcategory_click ==
                                                                snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .id
                                                            ? whiteColor
                                                            : blackColor,
                                                  ),
                                                )),
                                          ));
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
                message: translator.translate("There is Error"),
              );
            } else {
              return Center(
                child: SpinKitFadingCircle(color: greenColor),
              );
            }
          },
        ));
  }
}

class MyLoader extends StatelessWidget {
  final double width;
  final double height;

  MyLoader(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
