import 'package:ezhyper/Bloc/CreditCard_Bloc/creditCard_bloc.dart';
import 'package:ezhyper/Model/CreditCardModel/credit_card_model.dart';
import 'package:ezhyper/Model/CreditCardModel/credit_card_list_model.dart'
    as car_list;
import 'package:ezhyper/fileExport.dart';

class UpdatePaymentCard extends StatefulWidget {
  car_list.Data card;
  UpdatePaymentCard({this.card});
  @override
  _UpdatePaymentCardState createState() => _UpdatePaymentCardState();
}

class _UpdatePaymentCardState extends State<UpdatePaymentCard>
    with TickerProviderStateMixin {
  bool isSwitched;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSwitched = widget.card.defaultCard == 0 ? false : true;
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
                onWillPop: () {
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
                child:  Scaffold(
                        key: _drawerKey,
                        backgroundColor: whiteColor,
                        body: BlocListener<CreditCardBloc, AppState>(
                            bloc: creditCard_bloc,
                          listener: (context, state) {
                            if (state is Loading) {
                              if (state.indicator == 'update_card') {
                                _playAnimation();
                              }
                            } else if (state is Done) {
                              if (state.indicator == 'update_card') {
                                _stopAnimation();
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(pageBuilder:
                                        (context, animation1, animation2) {
                                      return AllAPaymentMethodsScreen();
                                    }, transitionsBuilder: (context, animation8,
                                        animation15, child) {
                                      return FadeTransition(
                                        opacity: animation8,
                                        child: child,
                                      );
                                    }));
                              }
                            } else if (state is ErrorLoading) {
                              if (state.indicator == 'update_card') {
                                _stopAnimation();
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(pageBuilder:
                                        (context, animation1, animation2) {
                                      return AllAPaymentMethodsScreen();
                                    }, transitionsBuilder: (context, animation8,
                                        animation15, child) {
                                      return FadeTransition(
                                        opacity: animation8,
                                        child: child,
                                      );
                                    }));
                              }
                            }
                          },
                          child: Directionality(
                            textDirection: translator.currentLanguage == 'ar'
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child:Container(
                            child: Column(
                              children: [
                                CustomAppBar(
                                  text: 'update_payment_method',
                                ),
                                Expanded(child: buildBody())
                              ],
                            ),
                          ),
                        ))))));
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

  Widget textAddPaymentCard() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * .075, right: width * .075),
          child: MyText(
            text: translator.translate("Add A New Payment Card "),
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
            text: translator.translate( "* indicates A Required Field"),
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
            hint: widget.card.holderName,
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
              hint: widget.card.number,
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
              hint: widget.card.expYear,
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
              hint: widget.card.expMonth,
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
            titleButton: translator.translate('update'),
            buttonController: _loginButtonController.view,
            onTap: () {
              creditCard_bloc
                  .add(updateCreditCard(card_id: widget.card.id.toString()));
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
            text: translator.translate('default_payment'),
            size: height * .017,
            weight: FontWeight.bold,
          ),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
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
