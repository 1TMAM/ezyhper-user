import 'package:ezhyper/fileExport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog({BuildContext context, String text, Function function}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
        child: CupertinoAlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      text ?? "",
                      style: TextStyle(
                          color: greenColor,
                          fontFamily: EzhyperFont.font_family,
                          fontSize:  16),
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                translator.translate("ok" ),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo",
                  color: greenColor,
                ),
              ),
              onPressed: function ?? () => Navigator.pop(context),
            )
          ],
        ));
      });
}
