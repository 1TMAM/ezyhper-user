import 'package:ezhyper/fileExport.dart';

class ManageAddress extends StatefulWidget {
  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Material(
                child: buildBody())
            ));
    
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:Container(
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
                    height: height * .2,
                  ),
                  imageContainer(),


                  SizedBox(
                    height: height * .01,
                  ),
                  textYoudonthaveanyaddreses(),
                  SizedBox(
                    height: height * .23,
                  ),
                  addNewAddressButton()
                ],
              ),
            )


        )  ));
  }


  Widget imageContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .8,
          height: height * .2,
          child: Image.asset(
            "assets/images/bg_location.png",
          ),
        ),
      ],
    );
  }
  Widget textYoudonthaveanyaddreses() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text:translator.translate("You do not have any addresses currently, please add a new address",),
            size: height * .019,
          ),
        ),
      ],
    );
  }

  Widget addNewAddressButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            givenHeight: height * .07,
            givenWidth: width * .85,
            onTapFunction: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    print("1111111111111111111");
                 return AddNewAddress();
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
            text: translator.translate("ADD NEW ADDRESS"),
            fontSize:EzhyperFont.header_font_size,
            radius: height * .05,
          ),
        ],
      ),
    );
  }
}
