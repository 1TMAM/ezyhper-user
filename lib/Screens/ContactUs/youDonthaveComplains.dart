import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/widgets/customSubmitAndSaveButton.dart';

class YouDontHaveComplains extends StatefulWidget {


  @override
  _YouDontHaveComplainsState createState() => _YouDontHaveComplainsState();
}

class _YouDontHaveComplainsState extends State<YouDontHaveComplains> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        child: Column(
          children: [topPart(),
            Expanded(child: buildBody())],
        ),
      ),))
    );
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            color: backgroundColor),
        child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * .0,
                  ),
                  complainsAndTrackRow(),
                  imageContainer(),
                  SizedBox(
                    height: height * .0,
                  ),
                  textYouHaveDontHave(),
                  SizedBox(
                    height: height * .01,
                  ),
                  textClickAdd(),
                  SizedBox(
                    height: height * .05,

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
                            return CustomCircleNavigationBar(page_index: 4,);                          },
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
                        text: translator.translate("PAYMENT METHOD"),
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

  Widget imageContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .5,
          height: height * .5,
          child: Image.asset(
            "assets/images/img_contactus.png",height: height*.03,width: width*.1,
          ),
        ),
      ],
    );
  }

  Widget textYouHaveDontHave() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text: translator.translate("Opps, you dont have any Complaint "),
            size: height * .019,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget textClickAdd() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text:
         translator.translate(   "If you are facing any problem or if you have a suggestion, please contact us"),
            size: height * .019,
          ),
        ),
      ],
    );
  }

  Widget complainsButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: whiteColor,
      onTap:
          (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return TrackYourComplains();
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
      child: Container(width: width*.4,
        child: Column(children: [
          MyText(text: translator.translate( "Track Your Complains") ,color: greyColor,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color:backgroundColor,height: height*.002,)
        ],),),
    );
  }

  Widget trackComplainsButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(splashColor: Colors.white,
      onTap: (){},
      child: Container(width: width*.4,
        child: Column(children: [
          MyText(text:  translator.translate( "Complains") ,color: greenColor ,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color: greenColor,height: height*.002,)
        ],),),
    );
  }

  Widget complainsAndTrackRow(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(padding: EdgeInsets.only(left: width*.075,right: width*.075),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          trackComplainsButton(),

          complainsButton(),
        ],),
    );

  }


}
