import 'package:ezhyper/Bloc/Order_Bloc/order_bloc.dart';
import 'package:ezhyper/Model/OrdersModel/order_model.dart' as order_model;
import 'package:ezhyper/Model/OrdersModel/order_model.dart';

import 'package:ezhyper/Screens/OrdersScreen/ordersHistoryDetails.dart';
import 'package:ezhyper/fileExport.dart';

class OrderSearchResult extends StatefulWidget{
  final String search_text;
  OrderSearchResult({this.search_text});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderSearchResultState();
  }

}
class OrderSearchResultState extends State<OrderSearchResult>{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
      child: Directionality(
        textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
        child:Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        child: Column(
          children: [topPart(),
            Expanded(child: buildBody())],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar2(
        onTapCart: false , isActiveIconCart: true,),

    ))));
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
                  listViewOfOrdersItems(),
                ],
              ),
            )

        ));
  }
Widget singleCardForOrderItems({order_model.Data order }){
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
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
                            /*   MyText(
                              text: order.status,
                              size: height * .016,
                              color: order.status == "rejected" ? Colors.red : greenColor ,

                            ),*/
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


}



Widget listViewOfOrdersItems(){
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return StreamBuilder<OrderModel>(
    stream: orderBloc.user_orders_subject,
    builder: (context,snapshot){
      if(snapshot.hasData){
        if(snapshot.data.data.isEmpty){
          return Container();
        }else{
          return Container( height: height*.75,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(snapshot.data.data[index].status.contains(widget.search_text)){
                      return InkWell(
                        onTap: (){
                        },
                        child: singleCardForOrderItems(
                            order: snapshot.data.data[index]
                        ),
                      );
                    }else{
                      String order_number = snapshot.data.data[index].orderNum.toString();
                      if(order_number.contains(widget.search_text)){
                        return  singleCardForOrderItems(
                              order: snapshot.data.data[index]
                        );
                      }else{
                        return Container();
                      }

                    }

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
          text: status,
          size: height * .016,
          color:  Colors.yellow.shade400 ,
        );
        break;
      case 'accepted':
        return  MyText(
          text: status,
          size: height * .016,
          color:  Colors.orange ,
        );
        break;
      case 'canceled':
        return  MyText(
          text: status,
          size: height * .016,
          color:  Colors.red ,
        );
        break;
      case 'prepare':
        return  MyText(
          text: status,
          size: height * .016,
          color:  Colors.blue ,
        );
        break;
      case 'in_way':
        return  MyText(
          text: status,
          size: height * .016,
          color:  Colors.greenAccent ,
        );
        break;
      case 'delivered':
        return  MyText(
          text: status,
          size: height * .016,
          color:  Colors.green ,
        );
        break;
    }
  }

Widget topPart() {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Container(
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
                          return MyOrdersHistory();
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
                      translator.currentLanguage =='ar'? "assets/images/arrow_right.png" : "assets/images/arrow_left.png",
                      height: height * .03,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * .03,
                ),
                Container(
                    child: MyText(
                      text: translator.translate("MY ORDERS SEARCH RESULT"),
                      size: height * .016,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}
}