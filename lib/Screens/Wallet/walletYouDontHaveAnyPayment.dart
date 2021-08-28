import 'package:ezhyper/Screens/Wallet/walletScreen.dart';
import 'package:ezhyper/fileExport.dart';


class WalletYouDontHavePaymentMethod extends StatefulWidget {


  @override
  _WalletYouDontHavePaymentMethodState createState() => _WalletYouDontHavePaymentMethodState();
}

class _WalletYouDontHavePaymentMethodState extends State<WalletYouDontHavePaymentMethod> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
      child:Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        child: Column(
          children: [topPart(),
            Expanded(child: buildBody())],
        ),
      ),
    )));
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



                  CustomSubmitAndSaveButton(buttonText: translator.translate("ADD PAYMENT METHOD"),onPressButton: (){

                    Navigator.push(context,MaterialPageRoute(
                      builder: (context)=> Wallet(),
                    ));

                  },),



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
      child:Container(
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
                        Navigator.push(context,MaterialPageRoute(
                          builder: (context)=> Settings(),
                        ));

                      },
                      child: Container(
                        child:  translator.currentLanguage == 'ar' ? Image.asset(
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
                          text: translator.translate("Wallet").toUpperCase(),
                          size: height * .016,
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
      ) ,
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
          width: width * .9,
          height: height * .5,
          child: Image.asset(
            "assets/images/img_wallet.png",
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
            text: translator.translate("Opps, you dont have any payment"),
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
            text: translator.translate("look like you do not have any payment, dont worry we will let you notify when you get it"),
            size: height * .019,
          ),
        ),
      ],
    );
  }


}
