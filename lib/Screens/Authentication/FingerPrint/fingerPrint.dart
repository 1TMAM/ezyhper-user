import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrint extends StatefulWidget {
  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometric;
  String authorized = "Not authorized";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkBiometric();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        child: Column(
          children: [topPart(),
            Expanded(child: buildBody())],
        ),
      ),
    )));
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
              SizedBox(
                height: height * .01,
              ),
              imageContainer(),
              SizedBox(
                height: height * .01,
              ),
              textYouHaveNotSetup(),
              SizedBox(
                height: height * .01,
              ),
              textClickOnSetup(),
              SizedBox(
                height: height * .05,
              ),
              fingerprintSetUpButton(),
            ],
          ),
        )
//

            ));
  }

  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child: Container(
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
                              return translator.currentLanguage == 'ar' ?
                              CustomCircleNavigationBar() : CustomCircleNavigationBar(page_index: 4,);                            },
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
                        child:  translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) :Image.asset(
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
                          text: translator.translate("FINGERPRINT"),
                          size: EzhyperFont.primary_font_size,
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

  Widget imageContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .8,
          height: height * .5,
          child: Image.asset(
            "assets/images/img_fingerprint.png",
          ),
        ),
      ],
    );
  }

  Widget textYouHaveNotSetup() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text: translator.translate("Opps, You haven't set up your fingerprint"),
            size: height * .019,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget textClickOnSetup() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .75,
          child: MyText(
            text: translator.translate(" Please, click on \"Fingerprint Set up\" button to set up your fingerprint"),
            size: height * .019,
          ),
        ),
      ],
    );
  }

  Widget fingerprintSetUpButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            givenHeight: height * .07,
            givenWidth: width * .85,
            onTapFunction: () {
              if(_canCheckBiometric){
                _authenticate();
              }else{
                errorDialog(
                  context: context,
                  text: translator.translate(  "Opps, Your device does not support the fingerprint feature")
                );
              }
            },
            text: translator.translate("FINGERPRINT SET UP"),
            fontSize:  EzhyperFont.header_font_size,
            radius: height * .05,
          ),
        ],
      ),
    );
  }


  //checking bimetrics
  //this function will check the sensors and will tell us
  // if we can use them or not
  Future<void> _checkBiometric() async{
    bool canCheckBiometric;
    try{
      List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();
      print("availableBiometrics : ${availableBiometrics}");
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch(e){
      print(e);
    }
    if(!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _authenticate() async{
    bool authenticated = false;
    try{
      print('1');
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: translator.translate("Touch Sensor to confirm fingerprint to continue"),
          useErrorDialogs: true,
          stickyAuth: false
      );
      if(authenticated){
        var response = await AuthenticationRepository.fingerprint_login();
        print("fingerprint response : ${response.msg}");
        if(response.status ==true){
          sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data.accessToken);
          sharedPreferenceManager.writeData(CachingKey.SOCIAL_LOGIN_TYPE, 'fingerprint');
          sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data.name);
          sharedPreferenceManager.writeData(CachingKey.EMAIL, response.data.email);
          sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
          sharedPreferenceManager.writeData(CachingKey.USER_WALLET, response.data.walletBalance);
          sharedPreferenceManager.writeData(CachingKey.FINGERPRINT_STATUS, true);

          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return FingerPrintAdded();
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
        }else{
          errorDialog(
              context: context,
              text: response.msg
          );
        }

      }else{

      }
      print('2');
    } on PlatformException catch(e){
      print(e);
    }
    if(!mounted) return;

    setState(() {
      authorized = authenticated ? "Autherized success" : "Failed to authenticate";
    });
  }
}
