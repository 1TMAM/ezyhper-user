import 'dart:async';


import 'package:ezhyper/fileExport.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends Bloc<AppEvent,AppState> with Validator{
  final AuthenticationRepository _authenticationRepository;
  SignUpBloc(this._authenticationRepository) : super(Start());

  final name_controller = BehaviorSubject<String>();
  final phone_controller = BehaviorSubject<String>();
  final email_controller = BehaviorSubject<String>();
  final password_controller = BehaviorSubject<String>();
  final confirm_password_controller = BehaviorSubject<String>();

  Function(String) get name_change => name_controller.sink.add;
  Function(String) get phone_change  => phone_controller.sink.add;
  Function(String) get email_change => email_controller.sink.add;
  Function(String) get password_change => password_controller.sink.add;
  Function(String) get confirm_password_change => confirm_password_controller.sink.add;

  Stream<String> get name => name_controller.stream.transform(username_validator);
  Stream<String> get phone => phone_controller.stream.transform(phone_validator);
  Stream<String> get email => email_controller.stream.transform(email_validator);
  Stream<String> get password => password_controller.stream.transform(password_validator);
  Stream<String> get confirm_password => confirm_password_controller.stream.transform(password_validator);

  Stream<bool> get submitCheck => Rx.combineLatest4(name, phone, email, password, (a, b, c, d) => true);





  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is click){
      yield Loading(model: null);

      print('signup 1');
      var response = await AuthenticationRepository.signUp(
        name:   name_controller.value,
        phone: phone_controller.value,
        email: email_controller.value,
        password: password_controller.value,
        password_confirmation:  confirm_password_controller.value,
      );
      print('signup 2');
      print('signup response : ${response}');
      if(response.status ==true){
        print('signup 1');

     //   sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data.accessToken);
       // sharedPreferenceManager.writeData(CachingKey.USER_ID, response.data.id);
        sharedPreferenceManager.writeData(CachingKey.USER_NAME, name_controller.value);
        sharedPreferenceManager.writeData(CachingKey.FORGET_PASSWORD_EMAIL, email_controller.value);
        sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, phone_controller.value);



        yield Done(model:response);
        print('signup 3');
      }else if (response.status == false){
        print('signup 4');
        yield ErrorLoading(response);
        print('response status : ${response.status}');

      }



    }
  }

  @override
  void dispose() {
    name_controller?.close();
    phone_controller?.close();
    email_controller?.close();
    password_controller?.close();
  }


}


