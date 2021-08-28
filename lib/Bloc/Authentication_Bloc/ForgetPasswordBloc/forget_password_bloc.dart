import 'package:ezhyper/fileExport.dart';


import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';


abstract class BaseBloc{
  void dispose(){
  }
}

class ForgetPasswordBloc extends Bloc<AppEvent,AppState> with Validator implements BaseBloc{
  final AuthenticationRepository _authenticationRepository;
  ForgetPasswordBloc(this._authenticationRepository):super(Start());
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  final email_controller = BehaviorSubject<String>();
  Function(String) get email_change => email_controller.sink.add;
  Stream<String> get email => email_controller.stream.transform(email_validator);

  final code_controller = BehaviorSubject<String>();
  Function(String) get code_change => code_controller.sink.add;
  Stream<String> get code => code_controller.stream.transform(code_validator);

  final password_controller = BehaviorSubject<String>();
  Function(String) get password_change =>password_controller.sink.add;
  Stream<String> get password =>password_controller.stream.transform(password_validator);

  final confirm_password_controller = BehaviorSubject<String>();
  Function(String) get confirm_password_change =>confirm_password_controller.sink.add;
  Stream<String> get confirm_password =>confirm_password_controller.stream.transform(password_validator);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    String user_email;
    //send otp Api handle
    if( event is sendOtpClick){
      yield Loading(model: null);
      print(email_controller.value);
      var response = await AuthenticationRepository.sendVerificationCode(email_controller.value);
      if(response.status == true){
        sharedPreferenceManager.writeData(CachingKey.FORGET_PASSWORD_EMAIL, email_controller.value);
        yield Done(model:response);
      }else{
        yield ErrorLoading(response);
      }
    }
    //check otp Api handle
    else if(event is checkOtpClick){
      yield Loading(model: null,indicator: 'checkOtpClick');
      await sharedPreferenceManager.readString(CachingKey.FORGET_PASSWORD_EMAIL).then((value) => user_email = value);
      var response= await AuthenticationRepository.checkOtpCode(user_email, code_controller.value);
      if(response.status ==true){

        SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
        sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data.accessToken);
        sharedPreferenceManager.writeData(CachingKey.SOCIAL_LOGIN_TYPE, 'email');
        sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data.name);
        sharedPreferenceManager.writeData(CachingKey.EMAIL, response.data.email);
        sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
        sharedPreferenceManager.writeData(CachingKey.USER_WALLET, response.data.walletBalance);
        yield Done(model:response, indicator:'checkOtpClick' );
      }else{
        yield ErrorLoading(response);
      }
    }
    //resend otp Api hamdle
    else if(event is resendOtpClick){
      yield Loading(model: null,indicator: 'resendOtpClick');
      await sharedPreferenceManager.readString(CachingKey.FORGET_PASSWORD_EMAIL).then((value) => user_email = value);
      var response  = await AuthenticationRepository.resendOtp(user_email);
      if(response.status == true){

        yield Done(model: response , indicator: 'resendOtpClick');
      }else{
        yield ErrorLoading(response);
      }
    }

    else if( event is changePasswordClick){
      yield Loading(model: null);
      print('password : ${password_controller.value}');
      print('confirm_password : ${confirm_password_controller.value}');
      await sharedPreferenceManager.readString(CachingKey.FORGET_PASSWORD_EMAIL).then((value) => user_email = value);
      var response = await AuthenticationRepository.changePassword(
        user_email,
          password_controller.value ,
          confirm_password_controller.value);
      if(response.status == true){
        yield  Done(model: response);
      }else{
        yield ErrorLoading(response);
      }
    }

  }
  @override
  void dispose() {
    email_controller?.close();
    code_controller?.close();
  }
}
final forgetPassword_bloc = new ForgetPasswordBloc(null);