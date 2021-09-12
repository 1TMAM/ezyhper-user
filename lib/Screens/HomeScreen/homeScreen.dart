import 'package:ezhyper/Bloc/Category_Bloc/category_bloc.dart';
import 'package:ezhyper/Constants/static_data.dart';
import 'package:ezhyper/Screens/Category/category_view.dart';
import 'package:ezhyper/Screens/Offers/offer_slider.dart';
import 'package:ezhyper/Screens/Offers/offers_view.dart';
import 'package:ezhyper/Screens/Product/product_grid_list.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Screens/Product/product_view.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    pending_earnings();
    super.initState();
  }
  void pending_earnings()async{
    StaticData.user_wallet_earnings = await sharedPreferenceManager.readInteger(CachingKey.USER_WALLET);
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Directionality(
              textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
              child:   Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        child: Column(
          children: [
            topPart(),
            Expanded(
                child: _buildBody(),
            )],
        ),
      ),
    ),
            )


        ));
  }

  // all scrolled  widgets in build body
  _buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
          decoration: BoxDecoration(
          color: backgroundColor),
      child: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            OfferSlider(),
            SizedBox(height: height*.01,),
                textCategory(),
            SizedBox(height: height*.02,),
                categoriesSlider(),



            SizedBox(height: height*.02,),
                textOffers(),
            SizedBox(height: height*.02,),
                offersSlider(),
            SizedBox(height: height*.02,),
            textMostSellingProducts(),
            SizedBox(height: height*.02,),
            MostSellingProductsSlider(),

            (StaticData.vistor_value == 'visitor')
                ? Container()
                : Column(
              children: [
/*                textRecommendedProducts(),
                SizedBox(height: height*.02,),
                RecommendedProductsSlider(),


 */

                SizedBox(height: height*.02,),
               // textPurchasedProducts(),
                //SizedBox(height: height*.02,),
                purchasedProductsSlider()
              ],
            ),

            SizedBox(height: height*.02,),
              ],

           ),
      ),
    );
  }

  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Container(
        height: height * .09,
        color: whiteColor,
        padding: EdgeInsets.only(
            left: width * .075, right: width * .075, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(onTap: (){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return SearchResult();
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
                  "assets/images/search.png",
                  height: height * .03,
                ),
              ),
            ),
            Container(
              child: SvgPicture.asset(
                  'assets/images/ezhyper_logo.svg',
                color: greenColor,
                height: height * .04,

              ),
            ),
  /*            Container(
              child: SvgPicture.asset(
                  'assets/images/ezhyper_logo.svg',
                color: greenColor,
                height: height * .04,

              ),
            ),*/

          ],
        ),
      ),
    );
  }

  Widget textCategory() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: width * .05, right: width * .05,
          bottom: StaticData.get_width(context) * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: translator.translate("Categories"),
            size: EzhyperFont.header_font_size,
            color: blackColor,
          ),
          InkWell(onTap: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return Categories();
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
              height: height * .03,
            ),
          )
        ],
      ),
    );
  }
  Widget categoriesSlider() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: height * .15,
        width: width,
        child: CategoryView(
          view_type: 'horizontal_ListView',
        )
    );
  }
  Widget textOffers() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: StaticData.get_width(context) * .05, right: StaticData.get_width(context) * .05,
      bottom: StaticData.get_width(context) * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: translator.translate("Offers"),
            size: EzhyperFont.header_font_size,
            color: blackColor,
          ),
          InkWell(onTap: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return Offers();
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
            child: translator.currentLanguage == 'ar' ? Image.asset(
              "assets/images/arrow_left_md.png",
              height: height * .03,
            ) :Image.asset(
              "assets/images/arrow_right_md.png",
              fit: BoxFit.cover,
              height: StaticData.get_height(context) * .03,
            ),
          )
        ],
      ),
    );
  }

  Widget offersSlider() {
    return Container(
        height: StaticData.get_height(context) * .35,
        width: StaticData.get_width(context),
        child: OffersView(
          view_type: 'horizontal_ListView',
        ));
  }

  Widget textRecommendedProducts() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: StaticData.get_width(context) * .05, right: StaticData.get_width(context) * .05,bottom: StaticData.get_width(context) * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: translator.translate("Recommended Products"),
            size: EzhyperFont.header_font_size,
            color: blackColor,
          ),
      InkWell(onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return ProductsGridList(
                page_name: "RecommendedProducts",
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

  Widget RecommendedProductsSlider() {
    return Container(
        height: StaticData.get_height(context) * .35,
        width: StaticData.get_width(context),
        child: ProductView(
          view_type: 'horizontal_ListView',
          department_name:  'RecommendedProducts',
        ));
  }


  Widget textMostSellingProducts() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: StaticData.get_width(context) * .05, right: StaticData.get_width(context) * .05,bottom: StaticData.get_width(context) * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: translator.translate("Most Selling Products"),
            size: EzhyperFont.header_font_size,
            color: blackColor,
          ),
          InkWell(onTap: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return ProductsGridList(
                    page_name: "MostSellingProducts",

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

  Widget MostSellingProductsSlider() {
    return Container(
        height: StaticData.get_height(context) * .35,
        width: StaticData.get_width(context),
        child: ProductView(
          view_type: 'horizontal_ListView',
          department_name: 'MostSellingProducts',
        ));
  }



  Widget purchasedProductsSlider() {
    return Container(
       // height: StaticData.get_height(context) * .35,
        width: StaticData.get_width(context),
        child: ProductView(
          view_type: 'horizontal_ListView',
          department_name: 'purchasedProducts',
        ));
  }
}
