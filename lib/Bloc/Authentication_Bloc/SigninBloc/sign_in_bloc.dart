import 'package:ezhyper/fileExport.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';


class SigninBloc extends Bloc<AppEvent,AppState> with Validator {
  final AuthenticationRepository _authenticationRepository;
    SigninBloc(this._authenticationRepository): super(Start());

    final email_controller = BehaviorSubject<String>();
    final password_controller = BehaviorSubject<String>();

    Function(String) get email_change => email_controller.sink.add;
    Function(String) get password_change => password_controller.sink.add;

    Stream<String> get email => email_controller.stream.transform(email_validator);
    Stream<String> get password => password_controller.stream.transform(password_validator);

    Stream<bool> get submit_check => Rx.combineLatest2(email, password, (a, b) => true);



  @override
  Stream<AppState> mapEventToState(AppEvent event)async*{
    if(event is click){
      yield Loading(model: null);
      var response = await AuthenticationRepository.signIn(email_controller.value, password_controller.value);
      if(response.status ==true){

        SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
        sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data.accessToken);
        sharedPreferenceManager.writeData(CachingKey.SOCIAL_LOGIN_TYPE, 'email');
        sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data.name);
        sharedPreferenceManager.writeData(CachingKey.EMAIL, response.data.email);
        sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
        sharedPreferenceManager.writeData(CachingKey.USER_WALLET, response.data.walletBalance);
        yield Done(model:response);
      }else{
        yield ErrorLoading(response);
      }
    }else if(event is FingerprintLoginEvent){
      yield Loading(model: null);
      var response = await AuthenticationRepository.fingerprint_login();
      print("fingerprint response : ${response.msg}");
      if(response.status ==true){
        sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data.accessToken);
        yield Done(model:response);
      }else{
        yield ErrorLoading(response);
      }
    }else if(event is refreshToken){
      yield Loading(model: null);
      var response = await AuthenticationRepository.refresh_token();
      print("refresh response : ${response.msg}");
      if(response.status ==true){
        sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data.accessToken);

        yield Done(model:response);
      }else{
        yield ErrorLoading(response);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email_controller?.close();
    password_controller?.close();

  }



}
final signIn_bloc = SigninBloc(null);