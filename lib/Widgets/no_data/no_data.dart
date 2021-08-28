import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String message;

  const NoData({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/img_slide3.png',
        height: StaticData.get_width(context) * 0.5,
        width:  StaticData.get_width(context) * 0.5,),
  /*      Icon(
          Icons.not_interested,
          size: height * 0.12,
          color: greenColor,
        ),*/
        Container(
          margin: EdgeInsets.only(top: height * 0.02),
          child: Text(
            message,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
      ],
    ));
  }
}
