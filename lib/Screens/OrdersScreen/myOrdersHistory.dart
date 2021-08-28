import 'package:ezhyper/Bloc/Order_Bloc/order_bloc.dart';
import 'package:ezhyper/Model/OrdersModel/order_model.dart';
import 'package:ezhyper/Screens/OrdersScreen/order_search_result.dart';
import 'package:ezhyper/Screens/OrdersScreen/ordersHistoryDetails.dart';
import 'package:ezhyper/Widgets/customWidgets.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Model/OrdersModel/order_model.dart' as order_model;


class MyOrdersHistory extends StatefulWidget {
  @override
  _MyOrdersHistoryState createState() => _MyOrdersHistoryState();
}

class _MyOrdersHistoryState extends State<MyOrdersHistory> {
bool sort ;
TextEditingController controller ;
String search_text='';
  @override
  void initState() {
    orderBloc.add(UserOrdersEvent());
    sort= false;
    controller = TextEditingController();
    super.initState();

  }
@override
  void dispose() {
    orderBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
      child: Directionality(
        textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
        child:WillPopScope(
          onWillPop: (){
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=>Settings()
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
        )
      ) ));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(height * .05),
                  topLeft: Radius.circular(height * .05)),
              color: backgroundColor
          ),
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

          )),
    );
  }

  Widget singleCardForOrderItems({order_model.Data order }){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    if(orderBloc.radio_choosed_value.value == null){

      return Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(onTap: (){
            print("order : ${order.status}");
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return OrderHistoryDetails(
                    order: order,

                  );
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
                            mainAxisAlignment:   translator.currentLanguage == 'ar' ? MainAxisAlignment.start : MainAxisAlignment.end,
                            children: [
                              MyText(
                                text: translator.currentLanguage == 'ar' ? "${order.orderNum} # ${translator.translate("order")} " :
                                "${translator.translate("order")} #${order.orderNum}",
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
                                text: "${order.date}",
                                size: height * .013,
                                color: greyColor,

                              ),


                              order_status(order.status),

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
    }else{
      print("ssss : ${ orderBloc.radio_choosed_value.value}");
      String statusOrder =filter_order_status(order.status);

      if(statusOrder == orderBloc.radio_choosed_value.value){
        return Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(onTap: (){
              print("order : ${order.status}");
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return OrderHistoryDetails(
                      order: order,
                    );
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
                                  text: "order #${order.orderNum}",
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
                                  text: "${order.date}",
                                  size: height * .013,
                                  color: greyColor,

                                ),


                                order_status(order.status),

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
      }else{
        print("------------");
        return Container();
      }
    }

  }



  Widget listViewOfOrdersItems(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<OrderModel>(
      stream: orderBloc.user_orders_subject,
      builder: (context,snapshot){
        if(snapshot.hasData){
          if(snapshot.data.data.isEmpty){
            return NoData(
              message:  translator.translate("If you are facing any problem or if you have a suggestion, please contact us"),
            );
          }else{
            return Container(
               height: height*.75,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:snapshot.data.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                        },
                        child: singleCardForOrderItems(
                            order: snapshot.data.data[index]
                        ),
                      );


                    }));
          }
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
                      width: width * .65,
                      height: height * .07,
                      child: Container(
                        child: TextField(
                          controller: controller,
                          style: TextStyle(color: greyColor, fontSize: height * .016),
                          cursorColor: greyColor,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  search_text = controller.value.text;
                                  print("search_text :${search_text}");
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) {
                                        return OrderSearchResult(
                                          search_text:search_text
                                        );
                                      },
                                      transitionsBuilder:
                                          (context, animation8, animation15, child) {
                                        return FadeTransition(
                                          opacity: animation8,
                                          child: child,
                                        );
                                      },
                                      transitionDuration: Duration(milliseconds: 0),
                                    ),
                                  );
                                });
                              },
                              icon:  Image.asset("assets/images/search_gray.png",
                                 ),

                            ),
                            hintText: translator.translate("Search By Order Id"),
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: height * .013),
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
                    setState(() {
                      sort = true;
                    });
                    CustomComponents.filterByStatusBottomSheet(
                      context: context,
                      data: [translator.translate('all') , translator.translate("pending"), translator.translate("accepted"), translator.translate("canceled"),
                        translator.translate("prepare") ,translator.translate("in_way"), translator.translate("delivered"), ],
                    );

                  },
                  child:  Container(padding: EdgeInsets.all(height*.015),
                    height: height * .075,
                    width: width * .15,
                    decoration:
                    BoxDecoration(color: whiteColor, shape: BoxShape.circle),
                    child: Image.asset("assets/images/sort_outline.png"),
                  ),
                ),

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
          padding: EdgeInsets.only(
            left: width * .075, right: width * .025, ),
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
                          translator.currentLanguage =='ar'? "assets/images/arrow_right.png" : "assets/images/arrow_left.png",                        height: height * .03,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: translator.translate("My Orders History").toUpperCase(),
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
      ),
    )
    ;
  }


String filter_order_status(String status){

  switch(status){
    case 'pending':
      return translator.translate("pending");
      break;
    case 'accepted':
      return  translator.translate("accepted");
      break;
    case 'canceled':
      return  translator.translate("canceled");
      break;
    case 'prepare':
      return   translator.translate( "prepare");
      break;
    case 'in_way':
      return translator.translate("in_way");
      break;
    case 'delivered':
      return  translator.translate("delivered");
      break;
  }
}



}
