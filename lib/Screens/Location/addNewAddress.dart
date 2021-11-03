import 'package:ezhyper/Model/AddressModel/address_model.dart';
import 'package:ezhyper/Screens/Location/map.dart';
import 'package:ezhyper/fileExport.dart';


class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> with TickerProviderStateMixin{
  bool isSwitched = false;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
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
    address_bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
        bloc: address_bloc,
        listener: (context, state) async {
      var data = state.model ;
      if (state is Loading) {
        if(state.indicator =='addNewLocation'){
          _playAnimation();
        }else{

        }

      } else if (state is Done) {
        if(state.indicator =='addNewLocation'){
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
        if(state.indicator =='addNewLocation'){
          print('login ErrorLoading');
          _stopAnimation();
          var error;
          if(data.errors.address != null){
            error = data.errors.address[0];
          }else if(data.errors.latitude != null){
            error = data.errors.latitude[0];
          }else if(data.errors.longitude != null){
            error = data.errors.longitude[0];

          }
          Flushbar(
            messageText: Row(
              children: [
                Text(
                  '${error}',
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
    child: Container(
        child: Column(
          children: [
            CustomAppBar(
              text: translator.translate( "ADD NEW ADDRESS"),
            ),
            Expanded(child: buildBody())],
        ),
      ),

    )))));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(height * .05),
                topLeft: Radius.circular(height * .05)),
            color: backgroundColor),
        child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                       MapSample(),
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

                ],
              ),
            ))

        ));
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
          hint:  translator.translate("Address Title(Home ,Work,School,AirPort ...) *"),
          inputType: TextInputType.streetAddress,
          suffixIcon: null,
          errorText: snapshot.error,
        );
      },
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
          hint: translator.translate( "Description *"),
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
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                sharedPreferenceManager.writeData(CachingKey.DEFAULT_SHIPPING_ADDRESS, isSwitched?1:0);
                print(value);
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
    return   StaggerAnimation(
      titleButton: translator.translate( "save").toUpperCase(),
      buttonController: _loginButtonController.view,
      onTap: () {
        if (!isLoading) {
          address_bloc.add(addNewLocation());

        }
      },
    );

  }

}
