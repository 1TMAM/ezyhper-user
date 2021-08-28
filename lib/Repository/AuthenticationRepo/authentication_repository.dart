import 'package:ezhyper/Model/RefreshTokenModel/refresh_token_model.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository{
 static SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();

  static Future<AuthenticationModel> signUp({String name, String phone, String email,
            String password, String password_confirmation})async{
    FormData formData=FormData.fromMap({
      "name" : name,
      "phone" : phone,
      "email" : email,
      "password" : password,
      "password_confirmation" :password_confirmation,
      "lang":"ar",
      "type" : "user",
      "firebase_token" : await  sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN)
    });

    return NetworkUtil.internal().post(AuthenticationModel(), Urls.SIGN_UP,body: formData);
  }

  static Future<AuthenticationModel> signIn(String email, String password)async{
    FormData formData =FormData.fromMap({
      "email" : email,
      "password" : password,
      "lang" : "ar",
      "firebase_token" : await  sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN)

    });

    return NetworkUtil.internal().post(AuthenticationModel(), Urls.SIGN_IN,body: formData);
  }

  static Future<AuthenticationModel> sendVerificationCode(String email){
    FormData formData = FormData.fromMap({
      'email' : email,
      'lang' : translator.currentLanguage
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.FORGET_PASSWORD, body: formData);
  }

  static Future<AuthenticationModel> checkOtpCode(String email , String code){
    FormData formData =FormData.fromMap({
    'email' : email,
    'lang' : translator.currentLanguage,
      'code' : code,
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.CHECK_OTP, body: formData);
  }

  static Future<AuthenticationModel> resendOtp(String email){
    FormData formData =FormData.fromMap({
      'email' : email,
      'lang' : translator.currentLanguage
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.FORGET_PASSWORD ,body: formData);
  }

  static Future<AuthenticationModel> changePassword(String email, String password, String password_confirmation){
    FormData formData =FormData.fromMap({
      'email' : email,
      'password' :password,
      'password_confirmation' : password_confirmation,
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.CHANGE_PASSWORD,body: formData);
  }

  static Future<AuthenticationModel> editProfile(String token, String username, String mobile, String email, String password ){
    FormData formData = FormData.fromMap({
      "token" : token,
      "username" : username,
      "mobile" : mobile,
      "email" : email,
      "password" : password
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.UPDATE_PROFILE, body: formData);
  }

  static Future<AuthenticationModel> logout(String token){

    FormData formData = FormData.fromMap({
      'token' : token,
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.LOGOUT, body: formData);
  }



 static Future<AuthenticationModel> fingerprint_login() async{
    FormData formData = FormData.fromMap({
      'firebase_token' : await sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN),
      'lang' : translator.currentLanguage
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.FINGERPRINT_LOGIN, body: formData);
 }
 static Future<RefreshTokenModel> refresh_token() async{
   print("refresh : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");
   FormData formData = FormData.fromMap({
     'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
   });
   return NetworkUtil.internal().post(RefreshTokenModel(), Urls.REFRESH_TOKEN, body: formData);
 }

}