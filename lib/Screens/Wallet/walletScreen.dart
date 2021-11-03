
import 'package:ezhyper/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:ezhyper/Model/WalletModel/cashout_model.dart';
import 'package:ezhyper/Model/WalletModel/wallet_model.dart' as wallet_model;
import 'package:ezhyper/Widgets/customWidgets.dart';
import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Screens/Wallet/walletYouDontHaveAnyPayment.dart';
class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> with TickerProviderStateMixin{

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletBloc.add(getWalletHistoryOrdersEvent());
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }


  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    walletBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:WillPopScope(
              onWillPop: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context)=> Settings()
                ));
              },
              child: Scaffold(
                key: _drawerKey,
                backgroundColor: backgroundColor,
                body: Directionality(
                    textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
                    child:Container(
                      child:  Column(
                          children: [
                            topPart(),
                            SizedBox(height: height*.0),
                            Expanded(child: buildBody())],
                        ),
                      ),
                    ),

              ),
            )));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: StreamBuilder<wallet_model.WalletModel>(
                stream: walletBloc.wallet_orders_history_subject,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data.data==null){
                      return NoData(
                        image: "assets/images/img_wallet.png",
                        title: translator.translate("order"),
                        message: translator.translate(
                            "If you are facing any problem or if you have a suggestion, please contact us"),
                      );
                    }else{
                      print("balance : ${snapshot.data.data[0].remainBalance}");
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(height * .05),
                                  topLeft: Radius.circular(height * .05)),
                              color: backgroundColor),
                          child:  Column(
                                  children: [
                                    SizedBox(height: height*.05,),
                                    dashedContainer(
                                      remain_balance: snapshot.data.data[0].user.walletBalance
                                    ),
                                    textHistoryUse(),
                                    divider(),
                                    listViewOfOrdersItems(
                                        wallet_history_orders: snapshot.data.data
                                    ),
                                    SizedBox(height: height*.03,),
                                    StaggerAnimation(
                                      titleButton: translator.translate("Recharge").toUpperCase(),
                                      buttonController: _loginButtonController.view,
                                      onTap: () {
                                        if (!isLoading) {
                                          CustomComponents.walletAmountBottomSheet(
                                              context: context
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(height: height*.03,),
                                  ],
                                ),

                          );
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
                    )
                    );
                  }
                },
              ),
            ),

          ],
        ),
      );


  }
  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child:    Container(
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
                        Navigator.pop(context);

                       /* Navigator.push(context,MaterialPageRoute(
                          builder: (context)=> CustomCircleNavigationBar(page_index: 4,),
                        ));*/

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
      ),
    )
 ;
  }

  Widget dashedContainer({int remain_balance}){
    StaticData.user_wallet_earnings = remain_balance;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DashedContainer(
      child: Container(
        child:  Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Column(children: [
              SizedBox(height: height*.03,),
              Image.asset("assets/images/popup_wallet.png",height: height*.05,),
              SizedBox(height: height*.03,),

              MyText(text:translator.translate("Your Pending Earning" ),size: height*.025,weight: FontWeight.normal,),
              SizedBox(height: height*.01,),

              Row(
                children: [
                  MyText(text:"${ remain_balance}",size: height*.04,weight: FontWeight.w900,),
                  Container(
                      child: Container(padding: EdgeInsets.only(top: height*.025),
                          child: MyText(text:translator.translate("SAR"),size: height*.015,weight: FontWeight.w200,))),
                ],
              ),
            ],)
          ],),
        ),
        height:height*.25,
        width:width*.65,
        decoration: BoxDecoration(color: whiteColor
            , borderRadius: BorderRadius.circular(10.0)),
      ),
      dashColor: greenColor,
      borderRadius: 10.0,
      dashedLength: 5.0,
      blankLength: 5.0,
      strokeWidth: 5.0,
    );

  }

  Widget divider() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * .002,
          width: width * .85,
          color: greyColor,
        ),
      ],
    );
  }

  Widget listViewOfOrdersItems({List<wallet_model.Data> wallet_history_orders}){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: wallet_history_orders.length,
        itemBuilder: (BuildContext context, int index) {
          if(wallet_history_orders.isNotEmpty){
            return InkWell(
              onTap: (){
              },
              child: singleCardForOrderItems(wallet_history_orders[index]),
            );
          }else{
            return Container();
          }

        });



  }
  Widget singleCardForOrderItems(wallet_model.Data order){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(onTap: (){
          Navigator.push(context,MaterialPageRoute(
            builder: (context)=> OrderHistoryDetails(
            ),
          ));

        },
          child: Container(
            margin: EdgeInsets.only(bottom: height*.015),
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
                              text: order.orderNum==""? translator.translate("Recharge") : "${translator.translate("order")} #${order.orderNum}",
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
                              text: "${order.createDates.createdAtHuman}",
                              size: height * .013,
                              color: greyColor,

                            ),
                            MyText(
                              text:"${order.cost} ${translator.translate("SAR")}",
                              size: height * .016,
                              color: greenColor ,

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

  Widget textHistoryUse() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(padding: EdgeInsets.only(left: width*.075,right: width*.075,top: 10,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
              text: translator.translate("History Use"),
              size: height * .018,

          ),
        ],
      ),
    );
  }

}
