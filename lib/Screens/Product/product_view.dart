
import 'package:ezhyper/Bloc/Product_Bloc/product_bloc.dart';
import 'package:ezhyper/Model/ProductModel/product_model.dart';
import 'package:ezhyper/Screens/Product/product_grid_list.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Screens/Product/product_shape.dart';
import 'package:ezhyper/Model/ProductModel/product_model.dart' as product_model;

class ProductView extends StatefulWidget{
  final String view_type;
  final String department_name;
  final int product_id;
  final String category_id;
  double price_from,  price_to ;
  int categories_id , brand_id, size_id,  rate ,offset;
  ProductView({this.view_type,this.department_name,this.product_id,this.category_id});
  ProductView.filter({this.price_to,this.offset,this.rate,this.size_id,this.brand_id,this.categories_id,
    this.price_from, this.view_type, this.department_name, this.product_id, this.category_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductViewState();
  }

}
class ProductViewState extends State<ProductView>{
  ScrollController _controller;
  var offset = 1;
  final product_bloc = ProductBloc(null);

  @override
  Future<void> initState()  {
  print("--------- ProductView -----------");
  _controller = ScrollController()..addListener(_scrollListener);

  switch(widget.department_name){
    case 'RecommendedProducts':
      product_bloc.add(getRecommendedProduct_click(
          offset: offset
      ));
      break;
    case 'MostSellingProducts':
      product_bloc.add(getMostSellingProduct_click(
          offset: offset
      ));
      break;
    case 'purchasedProducts':
      product_bloc.add(getPurchasedProduct_click(
          offset: offset
      ));
      break;
    case 'categoryProducts':
      product_bloc.add(getCategoryProducts(
          category_id: widget.category_id,
          offset: offset
      ));
      break;
    case 'relatedProducts':
      product_bloc.add(getRelatedProduct_click(
        product_id: widget.product_id,
          offset: offset

      ));
      break;

    case 'ShowSecondLevelSubcCategoryProducts':
      product_bloc.add(getSecondLevelSubCategoryProducts(
          secon_level_subcategory_id: widget.category_id,
          offset: offset
      ));
      break;
    case 'filter_result' :
      product_bloc.add(FilterProductsEvent(
          price_from: widget.price_from,
          price_to: widget.price_to,
    rate: widget.rate,
    categories_id: widget.categories_id,
    brand_id: widget.brand_id,
    size_id: widget.size_id,
    offset: widget.offset
    ));
      break;
  }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    product_bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    switch(widget.department_name){
      case 'RecommendedProducts':
        return widget.view_type == 'horizontal_ListView'
            ? StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.recomended_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Container();
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data[index] == null
                          ? Container()
                          : ProductShape(
                        product: snapshot.data[index],
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

        )

            : StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.recomended_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                          null ? Container() : ProductShape(
                        product: snapshot.data[index],
                      ),
                    );
                  });
            } else {
              return MyLoader(45, 45);
            }
          },

        );
        break;
      case 'MostSellingProducts':
        return widget.view_type == 'horizontal_ListView'
            ? StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.most_sellingproducts_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Container();
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data[index] == null
                          ? Container()
                          : ProductShape(
                        product: snapshot.data[index],
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

        )

            : StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.most_sellingproducts_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                          null ? Container() : ProductShape(
                        product: snapshot.data[index],
                      ),
                    );
                  });
            } else {
              return MyLoader(45, 45);
            }
          },

        );
        break;
      case 'purchasedProducts':
        return widget.view_type == 'horizontal_ListView'
            ? StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.purchased_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                  return Container();
              } else {
                return  Column(
                      children: [
                      textPurchasedProducts(context: context),
                  SizedBox(height: height*.02,),
            Container(
            height: StaticData.get_height(context)  * .35,
            child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return snapshot.data[index] == null
                            ? Container()
                            : ProductShape(
                          product: snapshot.data[index],
                        );
                      }),)
                  ]);

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

        )

            : StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.purchased_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                          null ? Container() : ProductShape(
                        product: snapshot.data[index],
                      ),
                    );
                  });
            } else {
              return MyLoader(45, 45);
            }
          },

        );
        break;

      case 'categoryProducts':
        return BlocBuilder(
          bloc: product_bloc,
          builder: (context,state){
            if(state is Done){
              return widget.view_type == 'horizontal_ListView'
                  ? StreamBuilder<List<product_model.Products>>(
                stream: product_bloc.cat_products_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data ==null) {
                      return Container();
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data[index] == null
                                ? Container()
                                : ProductShape(
                              product: snapshot.data[index],
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

              )

                  : StreamBuilder<List<product_model.Products>>(
                stream: product_bloc.cat_products_subject,
                builder: (context, snapshot) {
                  //     print("%%%%%%% : ${snapshot.data}");
                  if (snapshot.hasData) {
                    if (snapshot.data ==null) {
                      return NoData(
                        image: "assets/images/img_contactus.png",
                        title: translator.translate( "There is no products"),
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
                                  : snapshot.data[index] ==
                                  null ? NoData(
                                image: "assets/images/img_contactus.png",
                                title: translator.translate( "There is no products"),
                                message: translator.translate(
                                    "If you are facing any problem or if you have a suggestion, please contact us"),
                              ) : ProductShape(
                                product: snapshot.data[index],
                              ),
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
            }else if (state is ErrorLoading){
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
          },
        );

        break;
      case 'relatedProducts':
        return widget.view_type == 'horizontal_ListView'
            ? StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.related_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Container();
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data[index] == null
                          ? Container()
                          : ProductShape(
                        product: snapshot.data[index],
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

        )

            : StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.related_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                          null ? Container() : ProductShape(
                        product: snapshot.data[index],
                      ),
                    );
                  });
            } else {
              return MyLoader(45, 45);
            }
          },

        );
        break;
      case 'filter_result':
        return widget.view_type == 'horizontal_ListView'
            ? StreamBuilder<List<product_model.Products>>(
          stream: product_bloc.filter_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Container();
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data[index] == null
                          ? Container()
                          : ProductShape(
                        product: snapshot.data[index],
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

        )

            : StreamBuilder<List<product_model.Products>>(
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
                            null ? Container() : ProductShape(
                          product: snapshot.data[index],
                        ),
                      );
                    });
              }
             
            } else {
              return MyLoader(45, 45);
            }
          },

        );
        break;
      case 'ShowSecondLevelSubcCategoryProducts':

        return  BlocBuilder(
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
              null ? Container() : ProductShape(
              product: snapshot.data[index],
              ),
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
        );
        break;
      default:
        return Container();
        break;
    }

  }

  void _scrollListener() async{
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        offset +=1;
      });

      switch(widget.department_name){
        case 'RecommendedProducts':
          product_bloc.add(getRecommendedProduct_click(
              offset: offset
          ));
          break;
        case 'MostSellingProducts':
          product_bloc.add(getMostSellingProduct_click(
              offset: offset
          ));
          break;
        case 'purchasedProducts':
          product_bloc.add(getPurchasedProduct_click(
              offset: offset
          ));
          break;
        case 'relatedProducts':
          product_bloc.add(getRelatedProduct_click(
              product_id: widget.product_id,
              offset: offset

          ));
          break;
        case 'categoryProducts':
          product_bloc.add(getCategoryProducts(
              category_id: widget.category_id,
              offset: offset
          ));
          break;
   case 'filter_result':
      product_bloc.add(FilterProductsEvent(
          price_from :  await sharedPreferenceManager
              .readDouble(CachingKey.STRART_PRICE) ??
              0.0,
          price_to : await sharedPreferenceManager
              .readDouble(CachingKey.END_PRICE),
          rate : await sharedPreferenceManager
              .readInteger(CachingKey.FILTER_RATE),
      categories_id : await sharedPreferenceManager
          .readInteger(CachingKey.CATEGORY_ID),
      brand_id :  await sharedPreferenceManager
          .readInteger(CachingKey.BRAND_ID),
      size_id :  await sharedPreferenceManager
          .readInteger(CachingKey.SIZE_ID),
  offset: offset
  ));
      break;
      }
    }
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

Widget textPurchasedProducts({BuildContext context}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Container(
    padding: EdgeInsets.only(left: StaticData.get_width(context) * .05, right: StaticData.get_width(context) * .05,bottom: StaticData.get_width(context) * .01),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: translator.translate("Purchase List"),
          size: EzhyperFont.header_font_size,
          color: blackColor,
        ),
        InkWell(onTap: (){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return ProductsGridList(
                  page_name: "purchasedProducts",
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
            child:  translator.currentLanguage == 'ar' ? Image.asset(
              "assets/images/arrow_left_md.png",
              height: height * .03,
            ) :Image.asset(
              "assets/images/arrow_right_md.png",
              fit: BoxFit.cover,
              height: StaticData.get_height(context) * .03,
            ))
      ],
    ),
  );
}
