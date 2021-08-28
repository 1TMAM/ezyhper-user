import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';

class ProductReview extends StatefulWidget {
  @override
  _ProductReviewState createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
      backgroundColor: whiteColor,
      body: Stack(children: [
        Container(child: Image.asset("assets/images/food5.png"),),
        Container(
          child: Column(


            children: [
              SizedBox(height: height*.03,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(padding: EdgeInsets.all(height*.01),
                    height: height*.05,width: width*.2,decoration:
                    BoxDecoration(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(
                          height*.05,),bottomRight: Radius.circular(height*.05)),color: whiteColor),
                    child: Image.asset("assets/images/arrow_left.png",height: height*.015,),
                  ),
                  Container(
                    width: width*.4,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(padding: EdgeInsets.all(height*.01),
                          height: height*.05,width: width*.1,decoration:
                          BoxDecoration(shape: BoxShape.circle,
                              color: whiteColor),
                          child: Image.asset("assets/images/share.png",height: height*.015,),
                        ),Container(padding: EdgeInsets.all(height*.01),
                          height: height*.05,width: width*.2,decoration:
                          BoxDecoration(shape: BoxShape.circle,
                              color: whiteColor),
                          child: Image.asset("assets/images/heart_outline_black.png",height: height*.015,),
                        ),
                      ],),
                  ),


                ],),
              SizedBox(height: height*.37),
              Expanded(child: _buildBody())],
          ),
        ),

      ],),

    )));
  }
  _buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(height * .05),
              topLeft: Radius.circular(height * .05)),
          color: backgroundColor),
      child: Container(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(padding: EdgeInsets.only(left: width*.05),
                  width: width,height: height*.18,decoration: BoxDecoration(color:
                  whiteColor,borderRadius: BorderRadius.circular(height*.05)),child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                      MyText(text: "product name - Product Name - Product Name ", size: height*.02),
                    ],),
                    Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                      MyText(text: "product name - Product Name  ", size: height*.02),
                    ],),
                    Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                      MyText(text: "1000 ${translator.translate("SAR")} ", size: height*.02),
                      SizedBox(width: width*.02,),
                      Row(
                        children: [
                          Text(
                            "10000 ${translator.translate("SAR")}",
                            style: TextStyle(
                                decoration:
                                TextDecoration.lineThrough,
                                fontSize: height * .011,
                                color: greyColor),
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                          MyText(
                              text: "35%",
                              size: height * .011,
                              color: greenColor),
                        ],
                      ),
                      SizedBox(width: width*.15,),



                      Row(
                        children: [
                          Image.asset(
                            "assets/images/star_sm.png",
                            height: height * .02,
                          ),
                          SizedBox(
                            width: width * .01,
                          ),
                          Image.asset(
                            "assets/images/star_sm.png",
                            height: height * .02,
                          ),
                          SizedBox(
                            width: width * .01,
                          ),
                          Image.asset(
                            "assets/images/star_sm.png",
                            height: height * .02,
                          ),
                          SizedBox(
                            width: width * .01,
                          ),
                          Image.asset(
                            "assets/images/star_sm.png",
                            height: height * .02,
                          ),
                          SizedBox(
                            width: width * .01,
                          ),
                          Image.asset(
                            "assets/images/star_sm.png",
                            height: height * .02,
                          ),
                          SizedBox(
                            width: width * .01,
                          ),
                          Image.asset(
                            "assets/images/star_sm_outline.png",
                            height: height * .02,
                          ),
                          SizedBox(
                            width: width * .01,
                          ),
                          MyText(
                            text: "(52)",
                            size: height * .015,
                            color: greyColor,
                          )
                        ],
                      ),

                    ],
                    ),
                  ],
                  ),
                )
              ],),

            SizedBox(height: height*.03,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width,decoration: BoxDecoration(color:
                whiteColor,borderRadius: BorderRadius.circular(height*.05)),child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                    FittedBox(
                      child: Container(padding: EdgeInsets.only(left: width*.05),
                          width: width,
                          child: MyText(text: "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry's Standard Dummy Text Ever Since The 1500S, When An Unknown Printer Took A Galley Of Type And Scrambled It To Make A Type Specimen Book. It Has Survived Not Only Five Centuries, But Also The Leap Into Electronic Typesetting, Remaining Essentially  ", size: height*.018,align: TextAlign.left,)),
                    ),
                  ],),
                  SizedBox(height: height*.03,),

                  pointsAndPromoCodeRow(),
                  SizedBox(height: height*.03,),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width,decoration: BoxDecoration(color:
                      whiteColor,borderRadius: BorderRadius.circular(height*.05)),child: Column(children: [

                        Container(padding: EdgeInsets.only(left: width*.05,right: width*.05),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(text: "User name", size: height*.02),
                              Row(
                                children: [



                                  SizedBox(
                                    width: width * .01,
                                  ),

                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm_outline.png",
                                    height: height * .02,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                          FittedBox(child: Container(padding: EdgeInsets.only(left: width*.05,right: width*.1),
                              width: width,
                              child: MyText(text: "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry's Standard Dummy Text Ever Since The 1500S, When An ",
                                size: height*.018,align: TextAlign.start,))),
                        ],),
                        Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                          Container(padding: EdgeInsets.only(left: width*.05,right: width*.1),
                              child: MyText(text: "19, may, 2020 - 01:20 AM", size: height*.02,color: greyColor,)),






                        ],
                        ),
                        Container(width: width*.9,color: greyColor,height: height*.001,)

                      ],
                      ),
                      )
                    ],),
                  SizedBox(height: height*.03,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width,decoration: BoxDecoration(color:
                      whiteColor,borderRadius: BorderRadius.circular(height*.05)),child: Column(children: [

                        Container(padding: EdgeInsets.only(left: width*.05,right: width*.05),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(text: "User name", size: height*.02),
                              Row(
                                children: [



                                  SizedBox(
                                    width: width * .01,
                                  ),

                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm_outline.png",
                                    height: height * .02,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                          FittedBox(child: Container(padding: EdgeInsets.only(left: width*.05,right: width*.1),
                              width: width,
                              child: MyText(text: "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry's Standard Dummy Text Ever Since The 1500S, When An ",
                                size: height*.018,align: TextAlign.start,))),
                        ],),
                        Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                          Container(padding: EdgeInsets.only(left: width*.05,right: width*.1),
                              child: MyText(text: "19, may, 2020 - 01:20 AM", size: height*.02,color: greyColor,)),






                        ],
                        ),
                        Container(width: width*.9,color: greyColor,height: height*.001,)

                      ],
                      ),
                      )
                    ],),
                  SizedBox(height: height*.03,),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width,decoration: BoxDecoration(color:
                      whiteColor,borderRadius: BorderRadius.circular(height*.05)),child: Column(children: [

                        Container(padding: EdgeInsets.only(left: width*.05,right: width*.05),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(text: "User name", size: height*.02),
                              Row(
                                children: [



                                  SizedBox(
                                    width: width * .01,
                                  ),

                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm_outline.png",
                                    height: height * .02,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                          FittedBox(child: Container(padding: EdgeInsets.only(left: width*.05,right: width*.1),
                              width: width,
                              child: MyText(text: "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry's Standard Dummy Text Ever Since The 1500S, When An ",
                                size: height*.018,align: TextAlign.start,))),
                        ],),
                        Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                          Container(padding: EdgeInsets.only(left: width*.05,right: width*.1),
                              child: MyText(text: "19, may, 2020 - 01:20 AM", size: height*.02,color: greyColor,)),






                        ],
                        ),
                        Container(width: width*.9,color: greyColor,height: height*.001,)

                      ],
                      ),
                      )
                    ],),
                  SizedBox(height: height*.03,),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width,decoration: BoxDecoration(color:
                      whiteColor,borderRadius: BorderRadius.circular(height*.05)),child: Column(children: [

                        Container(padding: EdgeInsets.only(left: width*.05,right: width*.05),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(text: "User name", size: height*.02),
                              Row(
                                children: [



                                  SizedBox(
                                    width: width * .01,
                                  ),

                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm.png",
                                    height: height * .02,
                                  ),
                                  SizedBox(
                                    width: width * .01,
                                  ),
                                  Image.asset(
                                    "assets/images/star_sm_outline.png",
                                    height: height * .02,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                          FittedBox(child: Container(padding: EdgeInsets.only(left: width*.05,right: width*.1),
                              width: width,
                              child: MyText(text: "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry's Standard Dummy Text Ever Since The 1500S, When An ",
                                size: height*.018,align: TextAlign.start,))),
                        ],),
                        Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                          Container(padding: EdgeInsets.only(left: width*.05,right: width*.1),
                              child: MyText(text: "19, may, 2020 - 01:20 AM", size: height*.02,color: greyColor,)),






                        ],
                        ),
                        Container(width: width*.9,color: greyColor,height: height*.001,)

                      ],
                      ),
                      )
                    ],),


                  SizedBox(height: height*.03,),
                  CustomSubmitAndSaveButton(
                    buttonText: translator.translate("ADD TO CART"),onPressButton: (){},),
                  SizedBox(height: height*.03,),





                ],
                ),
                )
              ],),
          ],

        ),
      ),
    );
  }
  Widget promoCodeButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(splashColor:whiteColor,
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return OfferProductDetails();
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
      child: Container(width: width*.4,
        child: Column(children: [
          MyText(text: 'Product Details ' ,color: greyColor,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color:whiteColor,height: height*.002,)
        ],),),
    );
  }
  Widget pointsButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(splashColor: whiteColor,
      onTap: (){


      },
      child: Container(width: width*.4,
        child: Column(children: [
          MyText(text: 'Product Review' ,color: greenColor ,size: height*.02,weight: FontWeight.bold,),
          Container(width: width*.4,color: greenColor,height: height*.002,)
        ],),),
    );
  }
  Widget pointsAndPromoCodeRow(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(padding: EdgeInsets.only(left: width*.075,right: width*.075),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          promoCodeButton(),
          pointsButton()
        ],),
    );

  }
}
