import 'package:ezhyper/Bloc/Category_Bloc/category_bloc.dart';
import 'package:ezhyper/Bloc/Product_Bloc/product_bloc.dart';
import 'package:ezhyper/Screens/Product/product_shape.dart';
import 'package:ezhyper/Model/ProductModel/product_model.dart' as product_model;
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart' as category_model;

class SubCategoryProductResult  extends StatefulWidget {
  final String category_id;
  final String subcategory_name;
  final int sub_category_id;
  SubCategoryProductResult({this.category_id,this.subcategory_name,this.sub_category_id });
  @override
  _SubCategoryProductResultState createState() => _SubCategoryProductResultState();
}
class _SubCategoryProductResultState extends State<SubCategoryProductResult> {
  TextEditingController controller = new TextEditingController();
  String search_text='';
  int subcategory_click;
  ScrollController _controller;
  var offset = 1;

  @override
  void initState() {
    _controller = ScrollController()..addListener(_scrollListener);

    categoryBloc.add(getCategoryProducts(
        category_id: widget.category_id,
      offset: offset
    ));
    subcategory_click = 1;
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
                body: WillPopScope(
                  onWillPop: (){
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
                  child:    Directionality(
                      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
                      child: Container(
                          child: Column(
                              children: [
                                topPart(),

                                SizedBox(height: width * 0.05,),

                                Expanded(child: Container(color: backgroundColor,
                                    child:     StreamBuilder<List<product_model.Products>>(
                                      stream: product_bloc.cat_products_subject,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return GridView.builder(
                                              controller: _controller,
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
                                                      : snapshot.data[index].subCategory.id == widget.sub_category_id?
                                                  snapshot.data[index] == null ? Container() : ProductShape(product: snapshot.data[index] ,)
                                                      : null,
                                                );
                                              });
                                        } else {
                                          return MyLoader(45, 45);
                                        }
                                      },
                                    )
                                ))

                              ]))),
                )


            )));
  }
  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child:  Container(
        child: Container(
          height: height *.10,
          color: whiteColor,
          //   padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: translator.currentLanguage == 'ar'? height * 0.02 : 0 ,left: translator.currentLanguage == 'ar'? 0 : height * 0.02),
                        child: InkWell(
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
                            child: translator.currentLanguage == 'ar' ? Image.asset(
                              "assets/images/arrow_right.png",
                              height: height * .03,
                            ) :  Image.asset(
                              "assets/images/arrow_left.png",
                              height: height * .03,
                            ),
                          ),
                        )),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: widget.subcategory_name,
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
                  child:    Padding(
                    padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
                    child: InkWell(
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
                    ),
                  )

              )
            ],
          ),
        ),
      ),
    );
  }
  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        offset +=1;
      });
      product_bloc.add(getMostSellingProduct_click(
          offset: offset
      ));
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
