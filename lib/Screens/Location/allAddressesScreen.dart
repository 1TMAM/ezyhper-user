

import 'package:ezhyper/Model/AddressModel/address_list_model.dart' as address_list;
import 'package:ezhyper/Model/AddressModel/address_list_model.dart';
import 'package:ezhyper/Repository/AddressRepo/address_repository.dart';
import 'package:ezhyper/Screens/Location/update_address.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';

class AllAddressesScreen extends StatefulWidget {
  @override
  _AllAddressesScreenState createState() => _AllAddressesScreenState();
}

class _AllAddressesScreenState extends State<AllAddressesScreen> {
  bool isSwitched = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    address_bloc.add(getAllAddresses_click());
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return CustomCircleNavigationBar(page_index: 4,);
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
      child: NetworkIndicator(
          child: PageContainer(
              child:  Scaffold(
                backgroundColor: whiteColor,
                body: Container(
                  child: Column(
                    children: [
                      topPart(),
                      Expanded(child: buildBody())],
                  ),
                ),
              ))),
    );
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child: BlocBuilder(
          bloc: address_bloc,
      builder: (context,state){
       // var data = state.model as address_list.AddressListModel;
        if(state is Loading){
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        }else if(state is Done){
          var data = state .model as AddressListModel;
          if(data.data ==null){
            return ManageAddress();
          }else {
            return StreamBuilder<address_list.AddressListModel>(
                stream: address_bloc.subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.data == null) {
                      return ManageAddress();
                    } else {
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(height * .05),
                                  topLeft: Radius.circular(height * .05)),
                              color: backgroundColor),
                          child: Container(
                              padding: EdgeInsets.only(
                                  right: width * .075, left: width * .075),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    textSwipeLeft(),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    divider(),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    Container(
                                     //   height: height / 1.7,
                                        child: swiper(snapshot.data.data)
                                    ),
                                    SizedBox(
                                      height: height * .04,
                                    ),
                                    addNewAddressButton(),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                  ],
                                ),
                              )));
                    }
                  } else {
                    return ManageAddress();
                  }
                });
          }
        }else if(state is ErrorLoading){
          return NoData(
            message: translator.translate('THERE IS Connection ERROR'),
          );
        }

      },
    ));

  }

  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child:  Container(
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
                              return CustomCircleNavigationBar(page_index: 4,);
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
                          text: translator.translate("Manage Address").toUpperCase(),
                          size:EzhyperFont.primary_font_size,
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
      ),
    )
   ;
  }

  Widget divider() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * .003,
          width: width * .85,
          color: greyColor,
        ),
      ],
    );
  }

  Widget textSwipeLeft() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/swipe.png",
            height: height * .03,
          ),
          MyText(
              text: translator.translate("swipe"),
              size: height * .015,weight: FontWeight.bold,
              color: greyColor
          ),
        ],
      ),
    );
  }
  //  listview.builder + swipper
  Widget swiper([List<address_list.Data> data]) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  StreamBuilder<address_list.AddressListModel>(
      stream: address_bloc.subject,
      builder: (context,snapshot){
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.data.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = snapshot.data.data[index].id.toString();
              return Dismissible(
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify widgets.
                  key: Key(item),
                  // Provide a function that tells the app
                  // what to do after an item has been swiped away.
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      List<String> mList =  List<String>();
                      mList.add(item);
                      //convert your string list to your original int list
                      List<int> services_ids =
                      mList.map((i) => int.parse(i)).toList();

                      List<int> ids =new List<int>();
                      snapshot.data.data.removeAt(index);
                      address_repository.delete_user_location_func(
                        id: services_ids,
                      );
                    });

            },
                  // Show a red background as the item is swiped away.
                  background: Container(color: Colors.red),
                  child:  Padding(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: singleAddressCard(
                        location_id: snapshot.data.data[index].id.toString(),
                        lat: double.parse(snapshot.data.data[index].latitude),
                        lng: double.parse(snapshot.data.data[index].longitude),
                        default_adddress: snapshot.data.data[index].defaultAddress,
                        addressTitle: snapshot.data.data[index].address,
                        addressDescription: snapshot.data.data[index].descriptions==null?'' : snapshot.data.data[index].descriptions
                    ),
                  ));
            },

          );
        }
        else if (snapshot.hasError) {
          return Container(
            child: Text('${snapshot.error}'),
          );
        } else {
          return Container(
            height: height /5,
            child: CircularProgressIndicator(),
          );
        }
      },

    );

  }

  Widget singleAddressCard({String location_id , String addressTitle, String addressDescription,double lat,double lng,int default_adddress}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: FittedBox(
        child: Container(
          width: width * .85,
          padding: EdgeInsets.only(right: width * .02, left: width * .02),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(height * .02),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: addressTitle,
                    size: height * .02,
                    color: greenColor,
                    weight: FontWeight.bold,
                  ),
                 InkWell(
                   child:  Image.asset(
                     "assets/images/edit.png",
                     height: height * .04,
                   ),
                   onTap: (){
                     Navigator.push(
                       context,
                       PageRouteBuilder(
                         pageBuilder: (context, animation1, animation2) {
                           return UpdateAddress(
                             lng: lng,
                             lat: lat,
                             default_adddress: default_adddress,
                             addressDescription: addressDescription,
                             addressTitle: addressTitle,
                             location_id : location_id
                           );
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
                 )
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/pin.png",
                    height: height * .04,
                  ),

                  Container(
                    width: width * 0.7,
                    alignment: translator.currentLanguage == 'en'? Alignment.centerRight : Alignment.centerLeft,
                    child:  MyText(
                      text: addressDescription,
                      size: height * .0147,
                      color: greyColor,
                      weight: FontWeight.bold,
                      align: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addNewAddressButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            givenHeight: height * .07,
            buttonColor: greyColor,
            givenWidth: width * .85,
            onTapFunction: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                  /*  return Location(
                      route: 'AllAddressesScreen',
                    );*/
                  return AddNewAddress();
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
            text: translator.translate( "ADD NEW ADDRESS"),
            fontSize:EzhyperFont.header_font_size,
            radius: height * .05,
          ),
        ],
      ),
    );
  }


}
