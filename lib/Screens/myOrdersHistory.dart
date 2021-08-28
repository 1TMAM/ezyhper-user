import 'package:ezhyper/Screens/Filter/filterScreen.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Screens/OrdersScreen/ordersHistoryDetails.dart';

class MyOrdersHistory extends StatefulWidget {
  @override
  _MyOrdersHistoryState createState() => _MyOrdersHistoryState();
}

class _MyOrdersHistoryState extends State<MyOrdersHistory> {
  List <String> orderStatus = ["pending" ,"rejected" ,"rejected" , "delivered" ,
    "prepare","pending" ,"rejected" ,"rejected" , "delivered" , "prepare","pending" ,
    "rejected" ,"rejected" , "delivered" , "prepare"];

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
                  SizedBox(height: height*.03,),
                searchTextFieldAndFilterPart(),
                 listViewOfOrdersItems(),
                ],
              ),
            )
//

        ));
  }
  Widget singleCardForOrderItems(int index){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(onTap: (){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return OrderHistoryDetails();
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              text: "order #2015356",
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
                              text: "date: 20 Jun 2019",
                              size:EzhyperFont.secondary_font_size,
                              color: greyColor,

                            ),
                            MyText(
                              text: orderStatus[index],
                              size:EzhyperFont.primary_font_size,
                              color: orderStatus[index] == "rejected" ? Colors.red : greenColor ,

                            ),

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
  Widget listViewOfOrdersItems(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return (
        Container( height: height*.75,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:orderStatus.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(onTap: (){
                 },child: singleCardForOrderItems(index),
                     );
                })));



  }
  Widget searchTextFieldAndFilterPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(width: width*.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: width * .53,
                      height: height * .07,
                      child: Container(
                        child: TextFormField(
                          style: TextStyle(color: greyColor, fontSize:EzhyperFont.primary_font_size),
                          cursorColor: greyColor,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                              color: greyColor,
                              size: height * .035,
                            ),
                            hintText: "What Are You Loking For ? ",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize:EzhyperFont.secondary_font_size),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: greenColor)),
                          ),
                        ),
                      )),
        InkWell(
          onTap: (){
            CustomComponents.filterProductInfoBottomSheet(
              context: context,
              data:
              [translator.translate('Top Rated') ,
                translator.translate("Most Selling"),
                translator.translate("price : low to high"),
                translator.translate("price : high to low"),
                translator.translate("unit price : low to high"),
                translator.translate("unit price : high to low"),
              ],
            );
          },
          child: Container(padding: EdgeInsets.all(height*.015),
            height: height * .075,
            width: width * .15,
            decoration:
            BoxDecoration(color: whiteColor, shape: BoxShape.circle),
            child: Image.asset("assets/images/sort_outline.png"),
          ),
        )
                  ,
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context)=>FilterScreen()
                  ));
                },
                child: Container(padding: EdgeInsets.all(height*.015),
                    height: height * .075,
                    width: width * .15,
                    decoration:
                    BoxDecoration(color: whiteColor, shape: BoxShape.circle),
                    child: Image.asset("assets/images/filter_outline.png"),
                  ),)
                ],
              ),
            ),
            SizedBox(height: height*.02)
          ],
        ),
      ],
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
                        child:  translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) :Image.asset(
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
                          text: translator.translate( "My Orders History"),
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
  Widget textYourFingerPrintAdded() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text:
            "fingerprint added ! whenever you see this icon, you can use your fingerprint for Sign in",
            size: height * .023,
          ),
        ),
      ],
    );
  }





}
