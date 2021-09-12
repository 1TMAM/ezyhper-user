import 'package:ezhyper/Bloc/ContactUs_Bloc/contactUs_bloc.dart';
import 'package:ezhyper/Model/ContactUsModel/contactUs_model.dart' as contactUSmOdel;
import 'package:ezhyper/Model/ContactUsModel/contactUs_model.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/screens/ContactUs/complainsScreen.dart';

class TrackYourComplains extends StatefulWidget {
  @override
  _TrackYourComplainsState createState() => _TrackYourComplainsState();
}

class _TrackYourComplainsState extends State<TrackYourComplains> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("1");
    contactUsBloc.add(getAllComplain());
    print("2");
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child: Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        child: Column(
          children: [
            topPart(),
            Expanded(child: buildBody())],
        ),
      ),
    ))
        ));
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
                  SizedBox(height: height*.03,),
                  complainsAndTrackRow(),
                  SizedBox(height: height*.03,),
                  Container(
                    height: StaticData.get_height(context) * 0.72,
                    child: listViewOfComplains(),
                  )
                ],
              ),
            )
//

        ));
  }
  Widget singleComplainCard(contactUSmOdel.Data data){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){

        },
          child: Container(margin: EdgeInsets.only(bottom: height*.015),
            child: FittedBox(
              child: Row(
                children: [
                  Container(
                    width: width * .85,
                    padding: EdgeInsets.only(right: width * .04, left: width * .04),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(height * .02),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * .02,
                        ),
                        Row(
                          mainAxisAlignment:   translator.currentLanguage == 'ar' ? MainAxisAlignment.start : MainAxisAlignment.end,
                          children: [
                            MyText(
                              text: translator.currentLanguage == 'ar' ? "${data.msgNum} # ${translator.translate("Complain")} " :
                              "${translator.translate("Complain")} #${data.msgNum}",
                              size: height * .02,
                              color: blackColor,

                            ),

                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: translator.currentLanguage == 'ar' ? "${data.createDates.createdAtHuman} : ${translator.translate("date")}" : "${translator.translate("date")}:  ${data.createDates.createdAtHuman} ",
                              size:EzhyperFont.secondary_font_size,
                              color: greyColor,

                            ),
                            order_status(data.status)

                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget listViewOfComplains(){
    return StreamBuilder<ContactUsModel>(
      stream: contactUsBloc.complains_subject,
      builder: (context,snapshot){
        if (snapshot.hasData) {
          if(snapshot.data.data != null){
            if(snapshot.data.data.length != 0){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount:snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: (){

                        },
                        child: singleComplainCard(snapshot.data.data[index])

                    );
                  });
            }else{
              double height = MediaQuery.of(context).size.height;
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
                          ],
                        ),
                      )
                  ));
            }

          }else{
            double height = MediaQuery.of(context).size.height;
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
                        ],
                      ),
                    )
                ));
          }

        }
        else if (snapshot.hasError) {
          return Container(
            child: Text('${snapshot.error}'),
          );
        } else {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        }
      },

    );

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
          Padding(
          padding: EdgeInsets.only(right: translator.currentLanguage == 'ar'? height * 0.02 : 0 ,left: translator.currentLanguage == 'ar'? 0 : height * 0.02),
          child:
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
                        child:  translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) : Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        ),
                      ),
                    )),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: translator.translate("Contact Us").toUpperCase(),
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
                  padding: EdgeInsets.only(left: width * .075, right: width * .075,),
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
          MyText(text: translator.translate( "Track Your Complains") ,color: greenColor,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color:greenColor,height: height*.002,)
        ],),),
    );
  }
  Widget trackComplainsButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(splashColor: Colors.white,
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return ComplainsScreen();
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
          MyText(text: translator.translate("Complains") ,color: greyColor ,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color: backgroundColor ,height: height*.002,)
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
            translator.translate("If you are facing any problem or if you have a suggestion, please contact us"),
            size: height * .019,
          ),
        ),
      ],
    );
  }

  Widget order_status(String status){
    double height = MediaQuery.of(context).size.height;

    switch(status){
      case 'pending':
        return  MyText(
          text: translator.translate("pending"),
          size: height * .016,
          color:  Colors.yellow.shade400 ,
        );
        break;
      case 'accepted':
        return  MyText(
          text:  translator.translate("accepted"),
          size: height * .016,
          color:  Colors.orange ,
        );
        break;
      case 'canceled':
        return  MyText(
          text:  translator.translate("canceled"),
          size: height * .016,
          color:  Colors.red ,
        );
        break;
      case 'prepare':
        return  MyText(
          text:  translator.translate( "prepare"),
          size: height * .016,
          color:  Colors.blue ,
        );
        break;
      case 'in_way':
        return  MyText(
          text: translator.translate("in_way"),
          size: height * .016,
          color:  Colors.greenAccent ,
        );
        break;
      case 'delivered':
        return  MyText(
          text:  translator.translate("delivered"),
          size: height * .016,
          color:  Colors.green ,
        );
        break;
    }
  }



}
