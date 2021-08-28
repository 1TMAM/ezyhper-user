import 'package:ezhyper/fileExport.dart';
class CustomButton extends StatelessWidget {
  final double givenHeight ;
  final double givenWidth ;
  final double radius ;
  final Color buttonColor ;
  final String text ;
  final Color textColor ;
  final double  fontSize;
  final Function onTapFunction ;
  final FontWeight fontWieght;
  CustomButton(
      {@required this.givenHeight,@required this.givenWidth,this.buttonColor:greenColor, this.text:"",
        this.fontSize:2,this.textColor:whiteColor,@required this.onTapFunction,this.radius:10,this.fontWieght:FontWeight.normal});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width ;

    return  Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(height*.03)),splashColor: Colors.white,
            onTap: onTapFunction,
            child: Container(
              height:givenHeight,width: givenWidth,child: Center(child: Text(text
              ,style: TextStyle(color: textColor,fontWeight: fontWieght ,fontSize: fontSize),)),decoration:
            BoxDecoration(color: buttonColor,borderRadius: BorderRadius.circular(radius)),
            ),
          ),
        ],
      ),
    );
  }
}