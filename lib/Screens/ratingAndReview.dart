import 'package:ezhyper/Bloc/Product_Bloc/product_bloc.dart';
import 'package:ezhyper/Model/RateAndReviewModel/rateAndReview_model.dart';
import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Model/OrdersModel/order_model.dart' as order_model;


class RateAndReview extends StatefulWidget {
  order_model.Data order;
  RateAndReview({this.order});
  @override
  _RateAndReviewState createState() => _RateAndReviewState();
}

class _RateAndReviewState extends State<RateAndReview> with TickerProviderStateMixin{
  var rating ;
  var product_value ;
  var product_quality ;
  var delivery_time ;
  var comment;
  var using_experiences ;


  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  String profile_name , profile_email , profile_phone;
  final product_bloc = ProductBloc(null);

  @override
  void initState() {
    rating = 0.0;
    product_value = 0.0;
    product_quality = 0.0;
    delivery_time = 0.0;
    comment = '';
    using_experiences = 0.0;
    // TODO: implement initState
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();

  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
              key: _drawerKey,
      backgroundColor: whiteColor,
      body: Container(
        child: Column(
          children: [topPart(), Expanded(child: buildBody())],
        ),
      ),
    )));
  }
  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocListener<ProductBloc, AppState>(
      bloc: product_bloc,
      listener: (context, state) {
        var data = state.model as RateAndReviewModel;
        if (state is Loading) {
          print("Loading");
          _playAnimation();
        } else if (state is ErrorLoading) {
          print("ErrorLoading");
          _stopAnimation();
          errorDialog(
            context: context,
            text: '${data.msg}'
          );
        } else if (state is Done) {
          print("done");
          _stopAnimation();
          errorDialog(
              context: context,
              text: '${data.msg}',
              function: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => OrderHistoryDetails(
                      order: widget.order,
                    )
                ));
              });
        }
      },
      child: Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:  Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(height * .05),
                    topLeft: Radius.circular(height * .05)),
                color: backgroundColor),
            child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * .03,
                      ),

                      textContainer(translator.translate("How would you rate this product *")),
                      SizedBox(height: height*.01,),
                      ratingContainer('product_value'),
                      SizedBox(height: height*.02,),
                      textContainer(translator.translate("Product quality")),
                      SizedBox(height: height*.01,),
                      ratingContainer("product_quality"),
                      SizedBox(height: height*.02,),
                      textContainer(translator.translate("Delivery time")),
                      SizedBox(height: height*.01,),
                      ratingContainer("delivery_time"),
                      SizedBox(height: height*.02,),
                      textContainer(translator.translate("Using experiences")),
                      SizedBox(height: height*.01,),
                      ratingContainer("using_experiences"),
                      SizedBox(height: height*.02,),
                      textContainer(translator.translate("leave a comment")),
                      SizedBox(height: height*.01,),
                      commentTextField(),

                      SizedBox(
                        height: height * .05
                        ,
                      ),
                      submitButton(),
                      SizedBox(
                        height: height * .03
                        ,
                      ),


                    ],
                  ),
                )
//

            )),
      )
       ) ;
  }
  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child:Container(
        child: Container(
          height: height * .10,
          color: whiteColor,
          padding: EdgeInsets.only(left: width * .03, right: width * .03, ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return CustomCircleNavigationBar(page_index: 4,);                            },
                            transitionsBuilder:
                                (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );
                      },
                      child: Container(
                        child: translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) : Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: translator.translate("RATE AND REVIEW"),
                          size:  EzhyperFont.primary_font_size,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return ShoppingCart();
                      },
                      transitionsBuilder:
                          (context, animation8, animation15, child) {
                        return FadeTransition(
                          opacity: animation8,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 10),
                    ),
                  );
                },
                child: Container(
                  child: Image.asset(
                    "assets/images/cart.png",
                    height: height * .03,
                  ),
                ),
              )
            ],
          ),
        ),
      ) ,
    )
    ;
  }
  Widget textContainer( String text ) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * .075, right: width * .075),
          child: MyText(
            text:text,
            size: height * .02,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }


  Widget ratingContainer(var rate){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FittedBox(
      child: Container(
        width: width*.85,

    decoration: BoxDecoration
        (color: whiteColor,borderRadius: BorderRadius.all(Radius.circular(height*.03))),
        child: Column(
          children: [
            SizedBox(height: height*.06,),
            MyText(text: translator.translate("Tap On The Star To Choose"), size: height*.015,color: greyColor,),
            SmoothStarRating(

            rating: rating,

            isReadOnly: false,

            size:height*.06 ,
            color: Color(0xffFFE000),
            borderColor:Color(0xffFFE000),
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: true,
            spacing: 5.0,
            onRated: (value) {
              print("rating value -> $value");
              switch(rate){
                case 'product_value':
                  product_value = value;
                  print("product_value : ${product_value}");
                  break;
                case 'product_quality':
                  product_quality = value;
                  print("product_quality : ${product_quality}");

                  break;
                case 'delivery_time':
                  delivery_time = value;
                  print("delivery_time : ${delivery_time}");

                  break;
                case 'using_experiences':
                  using_experiences = value;
                  print("using_experiences : ${using_experiences}");

                  break;
              }
              // print("rating value dd -> ${value.truncate()}");
            },
      ),
            SizedBox(height: height*.06,),
          ],
        ),
      ),
    );
  }
  Widget submitButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StaggerAnimation(
    titleButton: "SUBMIT REVIEW",
    buttonController: _loginButtonController.view,
        onTap: () {
          product_bloc.add(rateAndReview_click(
            value: product_value,
            product_id: 2,
            using_experiences: using_experiences,
            product_quality: product_quality,
            delivery_time: delivery_time,
            comment: comment
          ));

    },
    ),
        ],
      ),
    );
  }
  Widget commentTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: width * .85,

              child: Container(
                child: TextFormField(maxLines: 4,
                  style: TextStyle(color: greyColor, fontSize: EzhyperFont.primary_font_size),
                  cursorColor: greyColor,
                  onChanged: (value){
                  comment = value;
                  },
                  decoration: InputDecoration(
                    suffixIcon: null,
                    hintText: translator.translate("Tell us more about your experience with the product"),
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize:  EzhyperFont.primary_font_size),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: greenColor)),
                  ),
                ),
              )),

        ],
      ),
    );
  }

}
