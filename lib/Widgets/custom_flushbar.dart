import 'package:flutter/material.dart';
import 'package:ezhyper/fileExport.dart';

class CustomFlushBar extends StatelessWidget{
   String primary_text='';
    String secondary_text='';
    Color backgroundColor;
  BuildContext drawerKey;
  CustomFlushBar({this.primary_text,this.secondary_text,this.drawerKey,this.backgroundColor});
  bool duration_status=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return       Flushbar(
      messageText: Row(
        children: [
          Text(
            '${primary_text}',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: whiteColor),
          ),
          Spacer(),
          InkWell(
            onTap: (){
             switch(secondary_text){
               case 'try again':
                 duration_status = true;
                 break;
               case 'Sign In':
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context)=>SignIn(),
                 ));
             }
            },
            child: Text(
              '${secondary_text}',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: whiteColor),
            ),
          )
        ],
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: backgroundColor,
      duration: duration_status? Duration(seconds: 4) : null,
      flushbarStyle: FlushbarStyle.FLOATING,
    )..show(drawerKey);
  }

}