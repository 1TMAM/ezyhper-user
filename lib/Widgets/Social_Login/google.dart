

import 'package:ezhyper/Bloc/SoicalLogin_Bloc/social_login_bloc.dart';
import 'package:ezhyper/Model/SocialLoginModel/social_login_model.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithGoogle extends StatefulWidget {
  final String route;
  LoginWithGoogle({this.route});
  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {

   FirebaseAuth _firebaseAuth ;
   GoogleSignIn _googleSignIn ;

  String google_user_name;
  String google_user_email;
  String google_user_image_url;
  String fcmToken ;
  String user_uid;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {
        _firebaseAuth = FirebaseAuth.instance;
        _googleSignIn = new GoogleSignIn();
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
            signInWithGoogle().then((user) async{
              socialLogin_bloc.add(SocialLoginEvent(
                  name: user.displayName,
                  email: user.email,
                  provider_id: user.uid,
                  provider: 'google',
                  firebase_token: await sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN),
              ));
            });

          },
          child:  Image.asset(
            "assets/images/social_gmail.png",
            height: height * .05,
          ),
        ),
      ),
    );

  }

   Future<User> signInWithGoogle() async {
     final GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
     final GoogleSignInAuthentication _googleSignInAuthentication =
     await _googleSignInAccount.authentication;
     final AuthCredential _authCredential = GoogleAuthProvider.credential(
         accessToken: _googleSignInAuthentication.accessToken,
         idToken: _googleSignInAuthentication.idToken);
     final  _authResult =
     await _firebaseAuth.signInWithCredential(_authCredential);
     final User user = _authResult.user;

     assert(user.email != null);
     assert(user.displayName != null);
     assert(user.photoURL != null);

     google_user_name = user.displayName;
     google_user_email = user.email;
     google_user_image_url = user.photoURL;

     assert(!user.isAnonymous);
     assert(await user.getIdToken() != null);
     final User _currentUser = await _firebaseAuth.currentUser;
     assert(user.uid == _currentUser.uid);
     user_uid = _currentUser.uid;
     print("user-uid google :$user_uid ");




     return user;
   }

   Future<String> signOutGoogle() async {
     await _googleSignIn.signOut();
     return "Google Sign Out";
   }

}
LoginWithGoogle loginWithGoogle = LoginWithGoogle();

