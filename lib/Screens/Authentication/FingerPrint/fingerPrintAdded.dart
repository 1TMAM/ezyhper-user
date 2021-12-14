import 'package:ezhyper/constants/static_data.dart';
import 'package:ezhyper/fileExport.dart';
class FingerPrintAdded extends StatefulWidget {
  @override
  _FingerPrintAddedState createState() => _FingerPrintAddedState();
}

class _FingerPrintAddedState extends State<FingerPrintAdded > {

  @override
  Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return NetworkIndicator(
        child: PageContainer(
            child:  WillPopScope(
              onWillPop: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>translator.currentLanguage == 'ar' ?
                  CustomCircleNavigationBar() : CustomCircleNavigationBar(page_index: 4,)
                ));
              },
              child: Scaffold(
                backgroundColor: whiteColor,
                body: Container(
                  child: Column(
                    children: [topPart(),
                      Expanded(child: buildBody())],
                  ),
                ),

              ),
            )));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(height * .05),
                topLeft: Radius.circular(height * .05)),
            color: backgroundColor),
        child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height*.25
                  ),
                  imageContainer(),


                  SizedBox(
                    height: height * .04,
                  ),
                  textYourFingerPrintAdded(),
                  SizedBox(
                    height: height * .23,
                  ),


                ],
              ),
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
                              return translator.currentLanguage == 'ar' ?
                              CustomCircleNavigationBar() : CustomCircleNavigationBar(page_index: 4,);                            },
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
                        ) : Image.asset(
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
                          text: translator.translate("FINGERPRINT"),
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

  Widget imageContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .6,
          height: height * .15,
          child: Image.asset(
            "assets/images/fingerprint_done.png",
          ),
        ),
      ],
    );
  }
  Widget textYourFingerPrintAdded() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text: translator.translate("fingerprint added ! whenever you see this icon, you can use your fingerprint for Sign in"),
            size: height * .023,
          ),
        ),
      ],
    );
  }

}
