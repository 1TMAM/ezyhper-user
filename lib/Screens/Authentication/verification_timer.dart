import 'package:ezhyper/fileExport.dart';

import 'dart:async';

import 'package:flutter/material.dart';

class TimerCountDownWidget extends StatefulWidget {
  Function onTimerFinish;

  TimerCountDownWidget({this.onTimerFinish}) : super();

  @override
  State<StatefulWidget> createState() => TimerCountDownWidgetState();
}

class TimerCountDownWidgetState extends State<TimerCountDownWidget> {
  Timer _timer;
  int _countdownTime = 0;
bool resend_click;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCountdownTimer();
    resend_click = false;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (resend_click) {
          startCountdownTimer();
          forgetPassword_bloc.add(resendOtpClick());
        }else{


        }
      },
      child: InkWell(
        child: Text(
          _countdownTime > 0 ? '00:$_countdownTime' : translator.translate("Resend Code"),
          style: TextStyle(
            fontSize: 14,
            color: _countdownTime > 0
                ? Colors.red
                : Color.fromARGB(255, 17, 132, 255),
          ),
        ),
      ),
    );
  }

  void startCountdownTimer() {
    if (_countdownTime == 0) {
      setState(() {
        _countdownTime = 60;
      });
    }
    _timer = Timer.periodic(
        Duration(seconds: 1),
            (Timer timer) => {
          setState(() {
            if (_countdownTime < 1) {
              widget.onTimerFinish();
              _timer.cancel();
              setState(() {
                resend_click = true;
              });
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}

