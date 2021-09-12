import 'package:ezhyper/fileExport.dart';



class CustomHeader extends StatelessWidget {

  final String headerText ;





  CustomHeader(
      {this.headerText : ""});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width ;

    return Container(
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
                      child: Image.asset(
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
                        text: headerText,
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
    );
  }
}