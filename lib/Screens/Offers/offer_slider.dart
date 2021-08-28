
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezhyper/Bloc/Offers_Bloc/offers_bloc.dart';
import 'package:ezhyper/Model/OffersModel/offer_model.dart';
import 'package:ezhyper/Widgets/Shimmer/slider_shimmer.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class OfferSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OfferSlider_State();
  }
}

class _OfferSlider_State extends State<OfferSlider> {
  int _current = 0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
}
  @override
  // TODO: implemen
  Widget build(BuildContext context) {
    // imgList = widget.imgList;
    return StreamBuilder<OfferModel>(
      stream: offersBloc.offers_subject,
      builder: (context, snapshot){
        if(snapshot.hasData){
          if(snapshot.data.status==false){
            return SliderSimmer();
          }
          return _buildWidget(snapshot.data);
        } else if (snapshot.hasError) {
        } else {
          return SliderSimmer();

        }
      },
    );
  }

  Widget _buildWidget(OfferModel offers){
    return SafeArea(
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
          child:  InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>Offers()
              ));
            },
            child: Stack(
                children: [
                  CarouselSlider(
                    items: offers.data.map((item) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      clipBehavior: Clip.hardEdge,
                      child:
                      Image.network(
                        '${item.photo}',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    )).toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        aspectRatio: 2.7,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: StaticData.get_width(context) * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: offers.data.map((url) {
                        int index = offers.data.indexOf(url);
                        return Container(
                          width: 6.0,
                          height: 6.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? greenColor
                                : whiteColor,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}

