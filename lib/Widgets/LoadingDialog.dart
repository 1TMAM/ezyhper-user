import 'package:ezhyper/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingDialog(BuildContext mcontext) {
  showDialog(
      barrierDismissible: false,
      context: mcontext,
      builder: (BuildContext mcontext) {
        return WillPopScope(
            onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 10,
          content: Container(
            height: 80,
            width: MediaQuery.of(mcontext).size.width * 0.50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SpinKitDualRing(
                      size: 40,
                      color: greenColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "جاري التحميل",
                      style: TextStyle(color: whiteColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
      });
}
