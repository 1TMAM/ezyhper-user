import 'package:ezhyper/Bloc/Settings_Bloc/settings_bloc.dart';
import 'package:ezhyper/Model/SettingsModel/settings_model.dart';
import 'package:ezhyper/fileExport.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
        child:Container(
        child: Column(
          children: [
            //CustomHeader(headerText: "About Us",),
            topPart(),

            Expanded(child: buildBody())],
        ),
      )),
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
                height: height * .02,
              ),
              textPersonalInformation(),
              SizedBox(
                height: height * .02,
              ),
            ],
          ),
        )
//

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
                        child: translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) :  Image.asset(
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
                          text: translator.translate("About Us"),
                          size:  EzhyperFont.primary_font_size,
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
  Widget textPersonalInformation() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<SettingsModel>(
      stream: settingsBloc.app_settings_subject,
      builder: (context,snapshot){
        if(snapshot.hasData){
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * .75,
                child: MyText(
                  text: translator.currentLanguage=='ar'? snapshot.data.data.aboutAr : snapshot.data.data.aboutEn,
                  size: height > width ? height * .0155 : height * .03,
                ),
              ),
            ],
          );
        }else{
          return Center(child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? greenColor : whiteColor,
                ),
              );
            },
          ));
        }
      },
    );

  }
}


