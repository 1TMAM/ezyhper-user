import 'package:ezhyper/Bloc/ContactUs_Bloc/contactUs_bloc.dart';
import 'package:ezhyper/Bloc/Settings_Bloc/settings_bloc.dart';
import 'package:ezhyper/Model/ContactUsModel/complain_model.dart';
import 'package:ezhyper/Model/ContactUsModel/contactUs_model.dart';
import 'package:ezhyper/Model/SettingsModel/settings_model.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class ComplainsScreen extends StatefulWidget {
  @override
  _ComplainsScreenState createState() => _ComplainsScreenState();
}
class _ComplainsScreenState extends State<ComplainsScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  var name , email, phone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saved_data();
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
    contactUsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  WillPopScope(
              onWillPop: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>Settings()
                ));
              },
              child: Directionality(
              textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
    child: Scaffold(
                key: _drawerKey,
                backgroundColor: whiteColor,
                body: (StaticData.vistor_value == 'visitor')
                    ? VistorMessage() :Container(

                  child: Column(
                    children: [
                      topPart(),
                      Container(
                        child: Expanded(
                            child:

                            _buildBody()


                        ),
                      )

                      ,],),
                ),

    ) ),
            )
        ))

    ;}
  _buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocListener<ContactUsBloc, AppState>(
        bloc: contactUsBloc,
        listener: (context, state) {

          if (state is Loading) {
            if(state.indicator == 'make-complain'){
              var data = state.model as ComplainModel;
              _playAnimation();
            }else{

            }
          } else if (state is ErrorLoading) {
            if(state.indicator == 'make-complain'){
              var data = state.model as ComplainModel;
              _stopAnimation();
              Flushbar(
                messageText: Row(
                  children: [
                    Text(
                      '${data.errors.message[0]}',
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
            }else{

            }

          } else if (state is Done) {
            print("done");
            _stopAnimation();
            if(state.indicator =='make-complain'){
              var data = state.model as ComplainModel;
              showConfirmationMessage(data.data.msgNum.toString());
          }else{

            }

          }
        },
        child: Directionality(
    textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
    child: SingleChildScrollView(
    child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * .03),
      Container(
        decoration: BoxDecoration(color: backgroundColor,
            borderRadius:
            BorderRadius.only(topRight: Radius.circular(height*.05),
                topLeft:
                Radius.circular(height*.05))),
        child: Container(padding: EdgeInsets.only(left: width*.0,right: width*.0),
          child:  Column(
              children: [
                SizedBox(height: height*.01,),
                complainsAndTrackRow(),

                SizedBox(height: height*.015,),
                fullNameTextField(),
                SizedBox(
                  height: height * .02,
                ),
                emailAddressTextField(),
                SizedBox(
                  height: height * .02,
                ),
                phoneNumberTextField(),
                SizedBox(
                  height: height * .02,
                ),
                subjectTextField(),
                SizedBox(
                  height: height * .02,
                ),
                messageTextField(),
                SizedBox(
                  height: height * .03,
                ),
                sendInButton(),
                SizedBox(
                  height: height * .03,
                ),
                social(),
                SizedBox(
                  height: height * .01,
                ),

              ],
            ),

                  ))
            ],
          ),)
        ));
  }

  Widget sendInButton(){
   return StaggerAnimation(
      titleButton: translator.translate("SEND"),
      buttonController: _loginButtonController.view,
      onTap: () {
            contactUsBloc.add(click());


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
                        child: translator.currentLanguage == 'ar' ? Image.asset(
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
                          text:translator.translate("Contact Us").toUpperCase(),
                          size:  EzhyperFont.primary_font_size,
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
    );
  }
  Widget social(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<SettingsModel>(
      stream: settingsBloc.app_settings_subject,
      builder: (context,snapshot){
        if(snapshot.hasData){
          return Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: width*.85,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                    InkWell(
                      child: Image.asset("assets/images/social_gmail.png" ,height: height*.05,),
                      onTap: (){
                         _launchURL('mailto: ${snapshot.data.data.email}');
                      },
                    ),
                    InkWell(
                      child:  Image.asset("assets/images/social_facebook.png" ,height: height*.05,),
                      onTap: (){
                        _launchURL('${snapshot.data.data.fbLink}');
                      },
                    ),
                    InkWell(
                      child:   Image.asset("assets/images/social_phone.png" ,height: height*.05,),
                      onTap: (){
                        _launchURL(
                            'tel:${snapshot.data.data.phone}');
                      },
                    ),
                    InkWell(
                      child:  Image.asset("assets/images/social_twitter.png" ,height: height*.05,),
                      onTap: (){
                        _launchURL('${snapshot.data.data.twLink}');
                      },
                    ),
                    InkWell(
                      child:  Image.asset("assets/images/social_whatsapp.png" ,height: height*.05,),
                      onTap: (){
                        _launchURL(
                            'https://api.whatsapp.com/send?phone=${snapshot.data.data.phone}');
                      },
                    ),







                  ],),
                ),
              ],
            ),
          );
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
          MyText(text: translator.translate( "Track Your Complains") ,color: greyColor,size: height*.019,weight: FontWeight.bold,),
          Container(width: width*.4,color:backgroundColor,height: height*.002,)
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
          MyText(text: translator.translate("Complains" ) ,color: greenColor ,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.35,color: greenColor ,height: height*.002,)
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

  Widget fullNameTextField() {
    return StreamBuilder<String>(
      stream: contactUsBloc.name,
      builder: (context, snapshot) {
        return Container(
          width: StaticData.get_width(context)*.85,
          child: CustomTextField(
            secure: false,
            onchange: contactUsBloc.name_change,
            hint: name?? translator.translate("Full Name *"),
            inputType: TextInputType.name,
            suffixIcon: null,
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget emailAddressTextField() {

    return StreamBuilder<String>(
        stream: contactUsBloc.email,
        builder: (context, snapshot) {
          return Container(
              width: StaticData.get_width(context)*.85,
              child: CustomTextField(
            secure: false,
            onchange: contactUsBloc.email_change,
            hint: email?? translator.translate("Email Address *"),
            inputType: TextInputType.emailAddress,
            suffixIcon: null,
            errorText: snapshot.error,
          ));
        });
  }

  Widget phoneNumberTextField() {

    return StreamBuilder<String>(
        stream: contactUsBloc.phone,
        builder: (context, snapshot) {
          return Container(
              width: StaticData.get_width(context)*.85,
              child: CustomTextField(
            secure: false,
            onchange: contactUsBloc.phone_change,
            hint: phone??  translator.translate("Phone Number *"),
            inputType: TextInputType.number,
            suffixIcon: null,
            errorText: snapshot.error,
          ));
        });
  }
  Widget subjectTextField() {
    return Container(
        width: StaticData.get_width(context)*.85,
        child: StreamBuilder<String>(
      stream: contactUsBloc.subject,
      builder: (context, snapshot) {
        return CustomTextField(
          secure: false,
          onchange: contactUsBloc.subject_change,
          hint: translator.translate("Subject *"),
          inputType: TextInputType.name,
          suffixIcon: null,
          errorText: snapshot.error,
        );
      },
    ));
  }
  Widget messageTextField() {
    return StreamBuilder<String>(
      stream: contactUsBloc.message,
      builder: (context, snapshot) {
        return Container(
            width: StaticData.get_width(context)*.85,
            child:  CustomTextField(
          secure: false,
          onchange: contactUsBloc.message_change,
          hint: translator.translate("Message *"),
          inputType: TextInputType.name,
          suffixIcon: null,
          errorText: snapshot.error,
          maxline: 4,
        ));
      },
    );
  }


  void showConfirmationMessage(String complain_id){
         showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          content: Column(
            children: [
              Image.asset('assets/images/popup_done.png',
                width: StaticData.get_width(context)*.07,
                height: StaticData.get_width(context) * .07,),
              SizedBox(
                height: StaticData.get_height(context) * .03,
              ),
              new Text("${translator.translate( "Your complaint has been successfully sent, you can track it now. Complaint Id Is")} $complain_id",
                style: TextStyle(color: blackColor)),
            ],
          ),

          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02, left: StaticData.get_width(context) * 0.02),
              child: RaisedButton(
                child: Text(translator.translate("Track Your Complains"),
                  style: TextStyle(color: whiteColor),),
                color: greenColor,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: greenColor)
                ),
                onPressed: () {
                  Navigator.pushReplacement(
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
              ),
            )

          ],
        ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void saved_data()async{
    name = await sharedPreferenceManager.readString(CachingKey.USER_NAME);
    email = await sharedPreferenceManager.readString(CachingKey.EMAIL);
    phone = await sharedPreferenceManager.readString(CachingKey.MOBILE_NUMBER);
  }



}
