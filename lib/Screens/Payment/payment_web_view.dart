import 'dart:async';

import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentWebView extends StatefulWidget {
  final String url;

  PaymentWebView({this.url,});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentWebViewState();
  }
}

class PaymentWebViewState extends State<PaymentWebView> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CustomCircleNavigationBar(
              page_index: 0,
            )));
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
      ),
      body: new WebviewScaffold(
        url: widget.url,
      ),
    );
  }
}
