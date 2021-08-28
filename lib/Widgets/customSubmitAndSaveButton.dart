import 'package:ezhyper/fileExport.dart';

class CustomSubmitAndSaveButton extends StatelessWidget {

  final String buttonText;
  final Function onPressButton ;
  final double btn_width;

  CustomSubmitAndSaveButton(
      { this.buttonText: "custom button "  ,  this.onPressButton , this.btn_width});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width ;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            givenHeight: height * .08,
            givenWidth: btn_width?? width * .85,
            onTapFunction: onPressButton ,
            text: buttonText,
            fontSize:EzhyperFont.header_font_size,
            radius: height * .05,
          ),
        ],
      ),
    );
  }
}