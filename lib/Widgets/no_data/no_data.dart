import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String message;
  final String title;
  final String image;
  const NoData({Key key, this.message,this.title,this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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

                  imageContainer(context),
                  textYouHaveDontHave(context),
                  SizedBox(
                    height: height * .01,
                  ),
                  textClickAdd(context),
                  SizedBox(
                    height: height * .05,

                  ),


                ],
              ),
            )
//

        ));
  }
  Widget imageContainer(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .5,
          height: height * .4,
          child: Image.asset(
            image,height: height*.03,width: width*.1,
          ),
        ),
      ],
    );
  }

  Widget textYouHaveDontHave(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text: "${translator.translate("Opps, you dont have any")} $title ",
            size: height * .019,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget textClickAdd(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text:message,
            size: height * .019,
          ),
        ),
      ],
    );
  }
}
