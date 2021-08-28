import 'package:ezhyper/Bloc/SoicalLogin_Bloc/social_login_bloc.dart';
import 'package:ezhyper/Model/SocialLoginModel/social_login_model.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWithFacebook extends StatefulWidget {
  final String route;
  LoginWithFacebook({this.route});
  @override
  _LoginWithFacebookState createState() => _LoginWithFacebookState();
}

class _LoginWithFacebookState extends State<LoginWithFacebook> {
   FirebaseAuth auth ;
   FacebookLogin fbLogin ;
  bool isFacebookLoginIn = false;
  String errorMessage = '';
  String successMessage = '';
   GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {
        fbLogin = new FacebookLogin();
        auth = FirebaseAuth.instance;
      });
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
              print("face 11111");
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
                    return CustomCircleNavigationBar(
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
            facebookLogin(context).then((user) {
              if (user != null) {
                print('Logged in successfully.');
                setState(() async{
                  isFacebookLoginIn = true;
                  successMessage = 'Logged in successfully.\n''Email : ${user.email}\n''Name : ${user.displayName}\n ''uid : ${user.uid}\n';
                  print(successMessage);
                  socialLogin_bloc.add(SocialLoginEvent(
                    name: user.displayName,
                    email: user.email,
                    provider_id: user.uid,
                    provider: 'facebook',
                    firebase_token: await sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN),
                  ));

                });
              } else {
                print('Error while Login.');
              }
            });
          },
          child:    Image.asset(
            "assets/images/social_facebook.png",
            height: height * .05,
          ),
        ),
      ),
    );

  }

  Future<User> facebookLogin(BuildContext context) async {
    User currentUser;
    try {
      final FacebookLoginResult facebookLoginResult =
      await fbLogin.logIn(['email', 'public_profile']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.credential(
            facebookAccessToken.token);
        final user = await auth.signInWithCredential(credential);
        assert(user.user.email != null);
        assert(user.user.displayName != null);
        assert(!user.user.isAnonymous);
        assert(await user.user.getIdToken() != null);
        currentUser = await auth.currentUser;
        assert(user.user.uid == currentUser.uid);
        return currentUser;
      }
    } catch (e) {
      print(e);
    }
    return currentUser;
  }

   Future<bool> facebookLoginout() async {
    await auth.signOut();
    await fbLogin.logOut();
    return true;
  }
}
LoginWithFacebook loginWithFacebook = LoginWithFacebook();