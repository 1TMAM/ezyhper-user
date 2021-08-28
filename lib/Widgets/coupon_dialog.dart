import 'package:ezhyper/fileExport.dart';

class CouponDialog extends StatefulWidget{
  final String text;
  CouponDialog({this.text});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CouponDialogState();
  }

}
class CouponDialogState extends State<CouponDialog>{
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          width: width,
          height: height / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height*.1)
          ),
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content:  SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: width,
                    height: height / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.1)
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: width * 0.02),
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/promo_code.png',color: greenColor,),
                          width: width * 0.15,
                          height:  width * 0.15,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: width * 0.01),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(width * 0.02),
                                child: MyText(
                                  text: translator.translate(widget.text),
                                  size:EzhyperFont.header_font_size,
                                  color: blackColor,
                                  weight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: width * 0.05),
                                child:  CustomSubmitAndSaveButton(
                                  buttonText: translator.translate("CONTINUE"),
                                  btn_width: width * 0.7,
                                  onPressButton: () async{
                                    Navigator.pop(context);
                                  },
                                ),

                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        );
      },
    );
  }

}