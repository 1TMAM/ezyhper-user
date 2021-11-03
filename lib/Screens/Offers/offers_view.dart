import 'package:ezhyper/Bloc/Offers_Bloc/offers_bloc.dart';
import 'package:ezhyper/Model/OffersModel/offer_model.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/Widgets/visitor_message.dart';
import 'package:ezhyper/fileExport.dart';

class OffersView extends StatefulWidget{
  final String view_type;
  OffersView({this.view_type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OffersViewState();
  }

}
class OffersViewState extends State<OffersView>{

@override
  void initState() {
  offersBloc.add(getAllOffers());
  super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    offersBloc.offer_search_controller = null;
  }
  @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.ltr,
        child: BlocBuilder(
          bloc: offersBloc,
          builder: (context,state){
          //  var data = state.model as OfferModel;
            if(state is Loading){
              return Center(
                child: SpinKitFadingCircle(color: greenColor),
              );
            }else if(state is Done){
              var data = state .model as OfferModel;
              if(data.data ==null){
                return NoData(
                  message: data.msg,
                );
              }else {
                return widget.view_type == 'horizontal_ListView'
                    ? StreamBuilder<OfferModel>(
                  stream: offersBloc.offers_subject,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.isEmpty) {
                        return Container();
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data.data[index].product == null
                                  ? Container()
                                  : OfferShape(
                                offer: snapshot.data.data[index],
                              );
                            });
                      }
                    }
                    else if (snapshot.hasError) {
                      return Container(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        child: SpinKitFadingCircle(color: greenColor),
                      );
                    }
                  },

                )
                    : StreamBuilder<OfferModel>(
                  stream: offersBloc.offers_subject,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          itemCount: snapshot.data.data.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 9 / 14,
                            // childAspectRatio: StaticData.get_width(context) * 0.002,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            String name = snapshot.data.data[index].product
                                .name;
                            return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xfff7f7f7),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(0),


                                  ),


                                ),
                                child: snapshot.data.data[index].product == null
                                    ?
                                Container()
                                    : OfferShape(
                                  offer: snapshot.data.data[index],
                                )

                            );
                          });
                    }
                    else if (snapshot.hasError) {
                      return Container(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        child: SpinKitFadingCircle(color: greenColor),
                      );;
                    }
                  },

                );
              }
            }else if(state is ErrorLoading){
              return NoData(
                message: translator.translate("There is Error"),
              );
            }else{
              return  Center(
                child: SpinKitFadingCircle(color: greenColor),
              );
            }

          },
        )
    );

  }

}