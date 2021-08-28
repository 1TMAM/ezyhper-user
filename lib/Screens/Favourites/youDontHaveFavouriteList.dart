import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/widgets/customSubmitAndSaveButton.dart';

class YouDontHaveFavourites extends StatefulWidget {
  final String message;
  final String image;
  final double width;
  final double height;
  YouDontHaveFavourites({this.message,this.image,this.width , this.height});
  @override
  _YouDontHaveFavouritesState createState() => _YouDontHaveFavouritesState();
}

class _YouDontHaveFavouritesState extends State<YouDontHaveFavourites> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
          child:  buildBody()
      ));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            color: backgroundColor),
        child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * .2,
                  ),
                  imageContainer(),
                  SizedBox(
                    height: height * .0,
                  ),
                  textYouHaveDontHave(),
                  SizedBox(
                    height: height * .01,
                  ),



                ],
              ),
            )
//

        ));
  }


  Widget imageContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: widget.width ?? width * .6,
          height: widget.height??  height * .2,
          child: Image.asset(
           widget.image?? "assets/images/menu_favourite.png",
          ),
        ),
      ],
    );
  }

  Widget textYouHaveDontHave() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text:  widget.message??translator.translate('no_favourite'),
            size: height * .019,
            color: Colors.red,
          ),
        ),
      ],
    );
  }



}
