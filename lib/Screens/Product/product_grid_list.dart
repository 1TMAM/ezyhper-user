
import 'package:ezhyper/Screens/Category/subcategory_products_result.dart';
import 'package:ezhyper/Screens/Filter/filterScreen.dart';
import 'package:ezhyper/Screens/Product/product_view.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart' as category_model;


class ProductsGridList extends StatefulWidget {
  final String page_name;
  final String category_id;
  final String category_name;
   List<category_model.SubCategory> subCategory_list;
  ProductsGridList({this.page_name,this.category_id,this.category_name, this.subCategory_list});
  @override
  _ProductsGridListState createState() => _ProductsGridListState();
}
class _ProductsGridListState extends State<ProductsGridList> {
  String search_text='';
  int subcategory_click;

  @override
  void initState() {
    print("--------- ProductsGridList -----------");
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
                body: Container(
                    child:  Column(
                        children: [
                          topPart(),
                          SizedBox(height: height*.0,),
                          Expanded(child:SingleChildScrollView(
                            child: Column(
                              children: [
                                //subcategories list
                        widget.page_name == 'categoryProducts' ?
                               widget.subCategory_list==null ? Container() : subCategory_list() : Container(),


                                Container(padding: EdgeInsets.only(right: width*.075,left: width*.075,top: height*.02,
                                    bottom: height*.02),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(height*.05),
                                        topRight:Radius.circular(height*.05)),color: backgroundColor),

                                    child: searchTextFieldAndFilterPart()),

                                Container(color: backgroundColor,
                                    child: ProductView(
                                      view_type: 'GridView',
                                      category_id: widget.category_id,
                                      department_name: widget.page_name,
                                    ))
                              ],
                            ),
                          )),

                        ]))
            )));
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
                          text: widget.category_name==null? translator.translate(widget.page_name) : widget.category_name,
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

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: width * .53,
              height: height * .07,
              child: Container(
                child: TextFormField(
                  style: TextStyle(color: greyColor, fontSize:EzhyperFont.primary_font_size),
                  cursorColor: greyColor,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: greyColor,
                      size: height * .035,
                    ),
                    hintText: "What Are You Loking For ? ",
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
              )),
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
        )
          ,
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>FilterScreen()
              ));
            },
            child: Container(padding: EdgeInsets.all(height*.015),
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
  Widget subCategory_list(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return widget.subCategory_list.isEmpty ? Container() :
    Container(
      padding: EdgeInsets.only(right:width * 0.03 , left: width * 0.03),
      height: width * 0.08,
      child: ListView.builder(
          itemCount: widget.subCategory_list.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context , index){
            return Row(
              children: [
                InkWell(
                  onTap: (){
                    print("name : ${widget.subCategory_list[index].nameAr}");
                    setState(() {
                      subcategory_click = widget.subCategory_list[index].id;
                      print("subcategory_click : ${subcategory_click}");
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return SubCategoryProductResult(
                              category_id: widget.category_id,
                              subcategory_name: translator.currentLanguage == 'ar' ? widget.subCategory_list[index].nameAr :
                              widget.subCategory_list[index].nameEn,
                              sub_category_id: widget.subCategory_list[index].id,
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
                    });
                  },
                  child: MyText(
                    text: translator.currentLanguage == 'ar' ? widget.subCategory_list[index].nameAr :
                    widget.subCategory_list[index].nameEn,
                    size: EzhyperFont.header_font_size,
                    weight: FontWeight.bold,
                    color: subcategory_click ==widget.subCategory_list[index].id? greenColor : blackColor,
                  ),
                ),
                SizedBox(width: width *0.05,)
              ],
            );
          }),
    );
  }


}



