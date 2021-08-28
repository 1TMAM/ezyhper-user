
import 'package:ezhyper/fileExport.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutBloc extends Bloc<AppEvent,AppState> implements BaseBloc{
  final AuthenticationRepository _authenticationRepository;
  LogoutBloc(this._authenticationRepository):super(Start());
  SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();
  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is logoutClick){
      yield Loading(model: null);
      var response = await AuthenticationRepository.logout(await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      if(response.status ==true){
        yield Done(model: response);
        switch(await sharedPreferenceManager.readString(CachingKey.SOCIAL_LOGIN_TYPE)){
          case 'email':
            sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
            sharedPreferenceManager.removeData(CachingKey.MOBILE_NUMBER);
            sharedPreferenceManager.removeData(CachingKey.EMAIL);
            sharedPreferenceManager.removeData(CachingKey.IS_OWNER);
            sharedPreferenceManager.removeData(CachingKey.USER_NAME);
            sharedPreferenceManager.removeData(CachingKey.FORGET_PASSWORD_EMAIL);
            sharedPreferenceManager.removeData(CachingKey.USER_ID);
            print("Email logout");
            break;
          case 'facebook':
            FirebaseAuth auth = FirebaseAuth.instance;
            FacebookLogin fbLogin = new FacebookLogin();
            await auth.signOut();
            await fbLogin.logOut();
            print("facebook logout");
            break;
          case 'twitter':
            TwitterLogin twitterLogin =TwitterLogin(
              consumerKey: 'WvOYNcFdJv5V7ZDrrkkYneKwj',
              consumerSecret: 'WYUq2ZUH2NDtjtVvCFLYkjgreWgo2xEH1brN4e4621qLYblL3d',
            );
            await twitterLogin.logOut();
            print("Twitter logout");
            break;
          case 'google':
            GoogleSignIn _googleSignIn = new GoogleSignIn();;
            await _googleSignIn.signOut();
            print("google logout");
          break;
          case 'phone':
            break;
          case 'fingerprint':
            sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
            sharedPreferenceManager.removeData(CachingKey.MOBILE_NUMBER);
            sharedPreferenceManager.removeData(CachingKey.EMAIL);
            sharedPreferenceManager.removeData(CachingKey.USER_NAME);
            sharedPreferenceManager.removeData(CachingKey.FORGET_PASSWORD_EMAIL);
            sharedPreferenceManager.removeData(CachingKey.USER_ID);
            break;

        }


      }else{
        yield ErrorLoading(response);
      }
    /*  switch(await sharedPreferenceManager.readString(CachingKey.SOCIAL_LOGIN_TYPE)){

       case 'facebook':
          FirebaseAuth auth ;
          FacebookLogin fbLogin ;
          fbLogin = new FacebookLogin();
          auth = FirebaseAuth.instance;
          await auth.signOut();
          await fbLogin.logOut();
       print("facebook logout");

          break;
        case 'email':

         break;

      }*/

    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
  }

}

final logout_bloc = LogoutBloc(null);