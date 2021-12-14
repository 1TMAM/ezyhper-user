import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/widgets/customSubmitAndSaveButton.dart';

class YouDontHavePaymentMethod extends StatefulWidget {
  @override
  _YouDontHavePaymentMethodState createState() =>
      _YouDontHavePaymentMethodState();
}

class _YouDontHavePaymentMethodState extends State<YouDontHavePaymentMethod> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Material(
      child: buildBody(),
    )));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(color: backgroundColor),
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
              CustomSubmitAndSaveButton(
                buttonText: translator.translate("Add Payment Method "  ),
                onPressButton: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return AddPaymentCard();
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
              ),
            ],
          ),
        )));
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
            "assets/images/img_payment.png",
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
            text: translator.translate("Opps, you dont have any payment Methods"),
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
                translator.translate("Please click on the \"Add Payment Method\" button to add a new payment card"),
            size: height * .019,
          ),
        ),
      ],
    );
  }
}
