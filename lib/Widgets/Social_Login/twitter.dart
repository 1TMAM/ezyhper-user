
import 'package:ezhyper/Bloc/SoicalLogin_Bloc/social_login_bloc.dart';
import 'package:ezhyper/Model/SocialLoginModel/social_login_model.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';


class TwitterLoginScreen extends StatefulWidget {
  final String route;
  TwitterLoginScreen({this.route});
  @override
  _TwitterLoginScreenState createState() => _TwitterLoginScreenState();
}

class _TwitterLoginScreenState extends State<TwitterLoginScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FirebaseAuth auth ;

  TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: 'WvOYNcFdJv5V7ZDrrkkYneKwj',
    consumerSecret: 'WYUq2ZUH2NDtjtVvCFLYkjgreWgo2xEH1brN4e4621qLYblL3d',
  );
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {
        auth = FirebaseAuth.instance;
      });
    });
  }

  String _title="";

  void _login() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String Message;
    print("result : ${result.status}");
    print("session : ${result.session}");
    switch (result.status) {

      case TwitterLoginStatus.loggedIn:
        // Get the Logged In session
        final TwitterSession twitterSession = result.session;
        // Create a credential from the access token
        final twitterAuthCredential = TwitterAuthProvider.credential(
          accessToken: twitterSession.token,
          secret: twitterSession.secret,
        );
        final user = await auth.signInWithCredential(twitterAuthCredential);
        Message = 'Logged in! username: ${user.user.displayName}\n email : ${user.user.email}\n userId : ${user.user.uid} } ';
        print(Message);
        socialLogin_bloc.add(SocialLoginEvent(
          name:  user.user.displayName,
          email:  user.user.email,
          provider_id:  user.user.uid,
          provider: 'twitter',
          firebase_token: await sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN),
        ));
        break;
      case TwitterLoginStatus.cancelledByUser:
        Message = 'Login cancelled by user.';
        print(Message);
        break;
      case TwitterLoginStatus.error:
        Message = 'Login error: ${result.errorMessage}';
        print(Message);
        break;
    }

    setState(() {
      _title = Message;
    });
  }

  void _logout() async {
    await twitterLogin.logOut();

    setState(() {
      _title = 'Logged out.';
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      key: _drawerKey,
      child:  BlocListener<SocialLoginBloc, AppState>(
        cubit: socialLogin_bloc,
        listener: (context,state){
          var data = state.model as SocialLoginModel;
          if (state is Loading) {
            print("lo---------");
            return Center(child: SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? greenColor : whiteColor,
                  ),
                );
              },
            ));
          } else if (state is Done) {
            StaticData.vistor_value = '';
            if(widget.route == 'signUp'){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return UserLocation();
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
            }else{
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return  translator.currentLanguage == 'ar' ?
                    CustomCircleNavigationBar(page_index: 4,) : CustomCircleNavigationBar()
                   ;
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
            }


          } else if (state is ErrorLoading) {
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
          }
        },
        child: InkWell(
          onTap: (){
            _login();
          },
          child:    Image.asset(
            "assets/images/social_twitter.png",
            height: height * .05,
          ),
        ),
      ),
    );
  }
}
