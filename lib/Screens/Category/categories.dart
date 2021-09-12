import 'package:ezhyper/Bloc/Category_Bloc/category_bloc.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart';
import 'package:ezhyper/Screens/Category/category_shape.dart';
import 'package:ezhyper/Screens/Category/category_view.dart';
import 'package:ezhyper/Screens/Offers/offers_view.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
class Categories extends StatefulWidget {

  @override
  _CategoriesState createState() => _CategoriesState();
}
class _CategoriesState extends State<Categories> {
  TextEditingController controller ;
  String search_text='';
  @override
  void initState() {
    categoryBloc.add(getAllCategories());
    controller = TextEditingController();
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
        body: Directionality(
          textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
          child: Container(
            child: Column(
                children: [
                  topPart(),
                  SizedBox(height: height*.0,),
                  Expanded(child: _build_body())

                ])))
    )));
  }
  
  Widget _build_body(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(right: width*.075,left: width*.075,top: height*.02,
                  bottom: height*.02),
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(height*.05),
                  topRight:Radius.circular(height*.05)),color: backgroundColor),

              child: searchTextFieldAndFilterPart()),
        Container(
                  color: backgroundColor,
              child:  BlocBuilder(
                cubit: categoryBloc,
                builder: (context,state){
                  if(state is Loading){
                    return Center(
                      child: SpinKitFadingCircle(color: greenColor),
                    );
                  }else if(state is Done){
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
                              return GridView.builder(
                                  itemCount: snapshot.data.data.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),

                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.3,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    String name = snapshot.data.data[index].name;
                                    return name !=null? name.contains(search_text) ? Container(
                                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                      //  color: Color(0xfff7f7f7),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                      child: snapshot.data.data[index].subCategory == null
                                          ? Container()
                                          : CategoryShape(
                                        categoryModel: snapshot.data.data[index],
                                      ),
                                    ) : Container() : Container();
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
                      message: translator.translate("There is Error"),
                    );
                  }else{
                    return Center(
                      child: SpinKitFadingCircle(color: greenColor),
                    );
                  }

                },
              )

          )
        ],
      )
      ,
    );
  }
  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child:   Container(
        child: Container(
          height: height * .10,
          color: whiteColor,
         // padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
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
                        padding: EdgeInsets.only(right: translator.currentLanguage == 'ar'? height * 0.02 : 0 ,left: translator.currentLanguage == 'ar'? 0 : height * 0.02),
                        child: translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) : Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        ),
                      ),
          ) ,
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: translator.translate("CATEGORIES"),
                          size:EzhyperFont.primary_font_size,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
        Padding(
          padding: EdgeInsets.only(right: translator.currentLanguage == 'ar'? height * 0.02 : 0 ,left: translator.currentLanguage == 'ar'? 0 : height * 0.02),
          child:   InkWell(
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
                  padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
                  child: Image.asset(
                    "assets/images/cart.png",
                    height: height * .03,
                  ),
                ),
              ))
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: width * .85,
              height: height * .07,
              child: Container(
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(color: greyColor, fontSize:EzhyperFont.primary_font_size),
                  cursorColor: greyColor,
                  decoration: InputDecoration(
                    suffixIcon:  IconButton(
                      onPressed: () {
                        setState(() {
                          search_text = controller.value.text;
                          print("search_text :${search_text}");
                        });
                      },
                      icon:  Image.asset("assets/images/search_gray.png",
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
              )),

        ],
      ),
    );
  }

}
