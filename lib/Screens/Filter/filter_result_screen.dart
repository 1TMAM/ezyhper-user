import 'package:ezhyper/Bloc/Filter_Bloc/filter_bloc.dart';
import 'package:ezhyper/Bloc/Offers_Bloc/offers_bloc.dart';
import 'package:ezhyper/Model/FilterModel/filter_model.dart';
import 'package:ezhyper/Screens/Filter/filterScreen.dart';
import 'package:ezhyper/Screens/Product/product_view.dart';
import 'package:ezhyper/Widgets/custom_favourite.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/Widgets/product_slider.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:rating_bar/rating_bar.dart';

class FilterResultScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FilterResultScreenState();
  }

}
class FilterResultScreenState extends State<FilterResultScreen>{

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
                 sharedPreferenceManager.removeData(CachingKey.CATEGORY_ID);
              sharedPreferenceManager.removeData(CachingKey.BRAND_ID);
              sharedPreferenceManager.removeData(CachingKey.SIZE_ID);
              sharedPreferenceManager.removeData(CachingKey.FILTER_RATE);
              sharedPreferenceManager.removeData(CachingKey.STRART_PRICE);
              sharedPreferenceManager.removeData(CachingKey.END_PRICE);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return NetworkIndicator(
      child: PageContainer(
      child: WillPopScope(
        onWillPop: (){
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
        child:Scaffold(
            backgroundColor: whiteColor,
            body: Directionality(
              textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
              child: Container(
                child: Column(
                  children: [topPart(),
                    Expanded(
                        child:  ProductView(
                          department_name: 'filter_result',
                          view_type: 'GridView',
                        )),
                    ],
                ),
              ),)



        ) ,
      )

      ));

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
          padding: EdgeInsets.only(left: width * .03, right: width * .03, ),
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
                          text: translator.translate("FILTER RESULT"),
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