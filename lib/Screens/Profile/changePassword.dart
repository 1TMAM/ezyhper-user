import 'package:ezhyper/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:ezhyper/Model/ProfileModel/profile_model.dart';
import 'package:ezhyper/fileExport.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with TickerProviderStateMixin {
  bool _passwordVisible;
  bool _confirmPasswordVisible;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
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
    profile_bloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
              key: _drawerKey,
      backgroundColor: whiteColor,
      body: BlocListener<ProfileBloc, AppState>(
      cubit: profile_bloc,
        listener: (context, state) {
      if (state is Loading) {
        print("Loading");
        _playAnimation();
      } else if (state is ErrorLoading) {
        var data = state.model as ProfileModel;
        print("ErrorLoading");
        _stopAnimation();
        Flushbar(
          messageText: Row(
            children: [
              Text(
                '${data.msg}',
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
      } else if (state is Done) {
        var data = state.model as ProfileModel;
        print("done");
        _stopAnimation();
        Flushbar(
          messageText:  Text(
            '${data.msg}',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: whiteColor),
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: greenColor,
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(seconds: 4),
        )..show(_drawerKey.currentState.context);
      }
    },
    child: Directionality(
    textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
    child:Container(
        child: Column(
          children: [topPart(), Expanded(child: buildBody())],
        ),
      )),
      )
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
                  SizedBox(
                    height: height * .02,
                  ),
                  textPersonalInformation(),
                  SizedBox(
                    height: height * .05,
                  ),
                  oldPasswordTextField(),
                  SizedBox(
                    height: width * .025,
                  ),
                  newPasswordTextField(),
                  SizedBox(
                    height: height * .025,
                  ),
                  confirmPasswordTextField(),
                  SizedBox(
                    height: height * .2,
                  ),
                  saveButton(),
                  SizedBox(
                    height: height * .02,
                  ),
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
                              return CustomCircleNavigationBar(page_index: 4,);
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
                        child: translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) : Image.asset(
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
                          text: translator.translate("CHANGE PASSWORD"),
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
      ) ,
    );
  }
  Widget textPersonalInformation() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * .075, right: width * .075),
          child: MyText(
            text: translator.translate("Personal Information"),
            size: height * .02,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
  Widget oldPasswordTextField(){

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<String>(
        stream: profile_bloc.old_password,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(left: width * .075, right: width * .075),
            child:  CustomTextField(
              secure: !_passwordVisible,
              hint: translator.translate("Password *"),
              onchange: profile_bloc.old_password_change,
              inputType: TextInputType.text,
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              errorText: snapshot.error,
            ),
          )

            ;
        });

  }
  Widget newPasswordTextField(){
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<String>(
        stream: profile_bloc.new_password,
        builder: (context, snapshot) {
          return Padding(
              padding: EdgeInsets.only(left: width * .075, right: width * .075),
          child: CustomTextField(
            secure: !_passwordVisible,
            hint: translator.translate("New Password *"),
            onchange: profile_bloc.new_password_change,
            inputType: TextInputType.text,
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            errorText: snapshot.error,
          ));
        });
  }
  Widget confirmPasswordTextField(){
    double width = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.only(left: width * .075, right: width * .075),
    child: StreamBuilder<String>(
        stream: profile_bloc.confirm_password,
        builder: (context, snapshot) {
          return CustomTextField(
            secure: !_passwordVisible,
            hint:translator.translate( "Confirm Password *"),
            onchange: profile_bloc.confirm_password_change,
            inputType: TextInputType.text,
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            errorText: snapshot.error,
          );
        }));

  }
  Widget saveButton() {
    return Container(
      child:    StaggerAnimation(
        titleButton: translator.translate( "save"),
        buttonController: _loginButtonController.view,
        onTap: () {
          profile_bloc.add((click()));
        },
      ),

    );
  }


}
