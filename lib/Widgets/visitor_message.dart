import 'package:ezhyper/Constants/static_data.dart';
import 'package:flutter/material.dart';
import 'package:ezhyper/fileExport.dart';

class VistorMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VistorMessageState();
  }
}

class VistorMessageState extends State<VistorMessage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/ezhyper_logo.svg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                ' قم بالتسجيل حتى تتمكن من الاستمتاع\n                   بخدمات التطبيق',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: EzhyperFont.font_family),
              ),
            ),
            RaisedButton(
              color: greenColor,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'الدخول الى صفحة التسجيل',
                  style: TextStyle(color: Colors.white,  fontSize: 14,
                      fontFamily: EzhyperFont.font_family),
                ),
              ),
              onPressed: () {
                StaticData.vistor_value='';
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignIn()));
              },
            )
          ],
        ),
      ),

    );
  }
}
