import 'package:ezhyper/Model/AddressModel/address_model.dart';
import 'package:ezhyper/Screens/Location/map.dart';
import 'package:ezhyper/fileExport.dart';


class UpdateAddress extends StatefulWidget {
  String addressTitle,  addressDescription , location_id;
  double lat, lng;
  int default_adddress;
  UpdateAddress({this.lat,this.lng,this.addressTitle,this.addressDescription,this.default_adddress,this.location_id});
  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> with TickerProviderStateMixin{
  bool isSwitched = false;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
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
    return  WillPopScope(
        onWillPop: (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return AllAddressesScreen();
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
        child:NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
              backgroundColor: whiteColor,
              body: BlocListener<AddressBloc, AppState>(
              cubit: address_bloc,
        listener: (context, state) async {

      if (state is Loading) {
       if(state.indicator=='updateLocation'){
         _playAnimation();
       }else{

       }
      } else if (state is Done) {
        if(state.indicator=='updateLocation'){
          _stopAnimation();
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return AllAddressesScreen();
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
          sharedPreferenceManager.removeData(CachingKey.Maps_lang);
          sharedPreferenceManager.removeData(CachingKey.MAPS_LAT);
        }else{

        }


      }
      else if (state is ErrorLoading) {
        if(state.indicator=='updateLocation'){
          _stopAnimation();

          Flushbar(
            messageText: Row(
              children: [
                Text(
                  'there is error',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: whiteColor),
                ),
                Spacer(),
                Text(
                  translator.translate("Try Again" ),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: whiteColor),
                ),
              ],
            ),
            flushbarPosition: FlushbarPosition.BOTTOM,
            backgroundColor: redColor,
            flushbarStyle: FlushbarStyle.FLOATING,
            duration: Duration(seconds: 6),
          )..show(_drawerKey.currentState.context);
        }else{

        }

      }
    },
    child: Directionality(
    textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
    child:Container(
                child: Column(
                  children: [
                    CustomAppBar(
                      text: 'UPDATE ADDRESS',
                    ),
                    Expanded(child: buildBody())],
                ),
              ),
    )
            )))));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(height * .05),
                topLeft: Radius.circular(height * .05)),
            color: backgroundColor),
        child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
//              ---------------------------------------------------------- first container in the stack
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * .03,
                            ),

                            MapSample(
                              lat: widget.lat,
                              lng: widget.lng,
                            ),

                            SizedBox(
                              height: height * .02,
                            ),
                            Container(
                                width: width * .85, child: addressTextField()),
                            SizedBox(
                              height: height * .02,
                            ),
                            Container(
                                width: width * .85,
                                child: descriptionTextField()),
                            SizedBox(
                              height: height * .02,
                            ),
                            textDefaultShipping(),
                            SizedBox(
                              height: height * .02,
                            ),
                            saveButton()
                          ],
                        ),
                      ),
                      //                --------------------------------------------------------- end of first container
//              -------------------------------------------------------------------- start of second container of the stack

                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * .07,
                              ),
                              searchTextField()
                            ],
                          ),
                        ),
                      )
//              -------------------------------------------------------------------------- end of second container
                    ],
                  ),
                ],
              ),
            )
//

        ));
  }




  Widget topNewAddressPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Container(
        height: height * .15,
        color: whiteColor,
        padding: EdgeInsets.only(
            left: width * .075, right: width * .075, top: height * .05),
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
                            return CustomCircleNavigationBar(page_index: 4,);                          },
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
                        text: translator.translate("ADD NEW ADDRESS"),
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
    );
  }


  Widget map() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width,
          height: height * .44,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: markers,
            circles: circles,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
        ),
      ],
    );
  }

  Widget addressTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<String>(
      stream: address_bloc.address,
      builder: (context, snapshot) {
        return CustomTextField(
          secure: false,
          onchange: address_bloc.address_change,
          hint:  widget.addressTitle,
          inputType: TextInputType.streetAddress,
          suffixIcon: null,
          errorText: snapshot.error,
        );
      },
    );

  }

  Widget searchTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: height * .07,
            width: width * .85,
            child: CustomTextField(
              secure: false,
              hint: "Enter Your Location ",
              inputType: TextInputType.emailAddress,
              suffixIcon:      IconButton(
                icon: Icon(
                  Icons.search ,
                  color: greenColor,
                ),
                onPressed: () {

                },
              ),
            )),
      ],
    );
  }

  Widget descriptionTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  StreamBuilder<String>(
      stream: address_bloc.description,
      builder: (context, snapshot) {
        return CustomTextField(
          secure: false,
          onchange: address_bloc.description_change,
          hint:  widget.addressDescription,
          inputType: TextInputType.text,
          suffixIcon: null,
          errorText: snapshot.error,
        );
      },
    );

  }

  Widget textDefaultShipping() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: width * .05, right: width * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: translator.translate("Default Shipping Address "),
            size: height * .017,
            weight: FontWeight.bold,
          ),
          Switch(
            value: widget.default_adddress==0?false:true,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: greenColor,
            activeColor: whiteColor,
          ),
        ],
      ),
    );
  }

  Widget saveButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StaggerAnimation(
      titleButton: "EDIT",
      buttonController: _loginButtonController.view,
      onTap: () {
        if (!isLoading) {
          address_bloc.add(updateLocation(
              location_id: widget.location_id
          ));

        }
      },
    );


  }

//  -------------------------------------------------------------------- all  google  maps functions and variables  here (start)

// first _  controller
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center =
  const LatLng(24.723201041398024, 46.67196272469909);

// second _ on map created
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      markers.add(
        Marker(
            markerId: MarkerId("1"),
            position: LatLng(24.723201041398024, 46.67196272469909),
            infoWindow: InfoWindow(
              title: "Riyadh",
            )),
      );
    });
  }

// third _  markers
  var markers = HashSet<Marker>();
  BitmapDescriptor customMarkerImage;
  getCustomMarker() async {
    customMarkerImage = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/cart.png',
    );
  }

//   finally _  circles
  Set<Circle> circles = Set.from([
    Circle(
        circleId: CircleId("1"),
        center: LatLng(24.723201041398024, 46.67196272469909),
        radius: 5000,
        fillColor: Colors.grey.withOpacity(.4),
        strokeWidth: 0,
        visible: true)
  ]);
//  -------------------------------------------------------------------- (end of google maps functions part )
}
