import 'package:ezhyper/Bloc/CreditCard_Bloc/creditCard_bloc.dart';
import 'package:ezhyper/Model/CreditCardModel/credit_card_model.dart';
import 'package:ezhyper/fileExport.dart';

class AddPaymentCard extends StatefulWidget {
  @override
  _AddPaymentCardState createState() => _AddPaymentCardState();
}

class _AddPaymentCardState extends State<AddPaymentCard> with TickerProviderStateMixin{
  bool isSwitched ;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSwitched = false;
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
    creditCard_bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: WillPopScope(
        onWillPop: (){
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return AllAPaymentMethodsScreen();
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
    child:Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child: Scaffold(
                key: _drawerKey,
                backgroundColor: whiteColor,
                body: BlocListener<CreditCardBloc,AppState>(
                  bloc: creditCard_bloc,
                  listener: (context,state){
                    var data = state.model as CreditCardModel;
                    if (state is Loading) {
                      _playAnimation();
                    } else if (state is Done) {
                      _stopAnimation();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return AllAPaymentMethodsScreen();
                            },
                            transitionsBuilder:
                                (context, animation8, animation15, child) {
                    return FadeTransition(
                    opacity: animation8,
                    child: child,
                    );
                    }));
                    } else if (state is ErrorLoading) {
                      _stopAnimation();
                      var error;
                      if(data.errors.holderName != null){
                        error = data.errors.holderName[0];
                      }else if(data.errors.number != null){
                        error = data.errors.number[0];
                      }else if(data.errors.expMonth != null){
                        error = data.errors.expMonth[0];
                      }else if(data.errors.expYear != null){
                        error = data.errors.expYear[0];
                      }
                      Flushbar(
                        messageText: Row(
                          children: [
                            Text(
                              '${error}',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: whiteColor),
                            ),
                            Spacer(),
                            Text(
                              translator.translate("Try Again" ),
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: whiteColor),
                            ),
                          ],
                        ),
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        backgroundColor: redColor,
                        flushbarStyle: FlushbarStyle.FLOATING,
                        duration: Duration(seconds: 6),
                      )..show(_drawerKey.currentState.context);
                    }
                  },
                  child:Container(
                    child: Column(
                      children: [
                        topPart(),
                        Expanded(child: buildBody())
                      ],
                    ),
    )),
                )
            )
            )
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
              SizedBox(height: height * .07),
              textAddPaymentCard(),
              SizedBox(
                height: height * .0,
              ),
              textIndicateRequired(),
              SizedBox(
                height: height * .05,
              ),
              cardHolderTextField(),
              SizedBox(
                height: height * .02,
              ),
              cardNumberTextField(),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  monthexpiresTextField(),
                  SizedBox(
                    width: height * .02,
                  ),
                  yearexpiresTextField()
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              defaultPaymentRow(),
              SizedBox(height: height * .1),
              addButton(),
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
      child:  Container(
        child: Container(
          height: height * .10,
          color: whiteColor,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child:  Padding(
          padding: EdgeInsets.only(right: translator.currentLanguage == 'ar'? height * 0.02 : 0 ,left: translator.currentLanguage == 'ar'? 0 : height * 0.02),
          child:
          Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
          Padding(
          padding: EdgeInsets.only(right: translator.currentLanguage == 'ar'? height * 0.02 : 0 ,left: translator.currentLanguage == 'ar'? 0 : height * 0.02),
          child: InkWell(
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
          )),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: translator.translate("add_payment_method"),
                          size:EzhyperFont.primary_font_size,
                          weight: FontWeight.bold,
                        )),
                  ],
               ) ),
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
                  padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
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

  Widget textAddPaymentCard() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * .075, right: width * .075),
          child: MyText(
            text: translator.translate("add_payment_method"),
            size: height * .026,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget textIndicateRequired() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * .075, right: width * .075),
          child: MyText(
            text: translator.translate( "* indicates a required field" ),
            size: height * .018,
          ),
        ),
      ],
    );
  }

  Widget cardHolderTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<String>(
      stream: creditCard_bloc.holder_name,
      builder: (context, snapshot) {
        return Container(
          width: width * .85,
          child: CustomTextField(
            secure: false,
            onchange: creditCard_bloc.holder_name_change,
            hint: translator.translate("Card Holder Name * "),
            inputType: TextInputType.streetAddress,
            suffixIcon: null,
            errorText: snapshot.error,
          ),
        );
      },
    );

  }

  Widget cardNumberTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<String>(
      stream: creditCard_bloc.number,
      builder: (context, snapshot) {
        return Container(
            width: width * .85,
            child: CustomTextField(
          secure: false,
          onchange: creditCard_bloc.number_change,
          hint: translator.translate("Card Number *"),
          inputType: TextInputType.number,
          suffixIcon: null,
          errorText: snapshot.error,
        ));
      },
    );
  }

  Widget yearexpiresTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<String>(
      stream: creditCard_bloc.exp_year,
      builder: (context, snapshot) {
        return Container(
            width: width * .40,
            child: CustomTextField(
              secure: false,
              onchange: creditCard_bloc.exp_year_change,
              hint: translator.translate("Expires Year* "),
              inputType: TextInputType.number,
              suffixIcon: null,
              errorText: snapshot.error,
            ));
      },
    );

  }

  Widget monthexpiresTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<String>(
      stream: creditCard_bloc.exp_month,
      builder: (context, snapshot) {
        return Container(
            width: width * .40,
            child: CustomTextField(
              secure: false,
              onchange: creditCard_bloc.exp_month_change,
              hint: translator.translate("Expires Month* "),
              inputType: TextInputType.number,
              suffixIcon: null,
              errorText: snapshot.error,
            ));
      },
    );
  }

  Widget addButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           StaggerAnimation(
        titleButton: translator.translate("save").toUpperCase(),
        buttonController: _loginButtonController.view,
        onTap: () {
          creditCard_bloc.add(click());
        },
      ),
        ],
      ),
    );
  }

  Widget defaultPaymentRow() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: width * .075, right: width * .075),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: translator.translate("Default Payment Method "),
            size: height * .017,
            weight: FontWeight.bold,
          ),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                sharedPreferenceManager.writeData(CachingKey.DEFAULT_CREDIT_CARD, isSwitched?1:0);
                print(isSwitched);
              });
            },
            activeTrackColor: greenColor,
            activeColor: whiteColor,
          ),
        ],
      ),
    );
  }
}
