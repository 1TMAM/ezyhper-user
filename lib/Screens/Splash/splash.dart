import 'package:ezhyper/Bloc/Offers_Bloc/offers_bloc.dart';
import 'package:ezhyper/fileExport.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StaticData.vistor_value = null; // clear vistor state

    Timer(Duration(seconds: 0), () async {
      try {
        print(
            '--- token -- : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}');
        checkAuthentication(await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      } catch (e) {
        checkAuthentication(null);
      }
    });
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: greenColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: height,
            width: width,
            child: Image.asset(
              "assets/images/splash.png",
            ),
          ),
        ),
      ),
    );
  }

  void checkAuthentication(String token) async {
   if (token.isEmpty) {
     await Future.delayed(Duration(seconds: 4));
     StaticData.vistor_value = 'visitor';
     CustomComponents.isFirstTime().then((isFirstTime) {
       print("isFirstTime : ${isFirstTime}" );
       isFirstTime ?Navigator.push(
         context,
         PageRouteBuilder(
           pageBuilder: (context, animation1, animation2) {
             return  translator.currentLanguage == 'ar' ?
             CustomCircleNavigationBar(page_index: 4,) : CustomCircleNavigationBar();
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
       ) :
       Navigator.push(
         context,
         PageRouteBuilder(
           pageBuilder: (context, animation1, animation2) {
             return Intro1(
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
     });

    } else {
     new CircularProgressIndicator();
     // await signIn_bloc.add(refreshToken()); // refresh token
      await offersBloc.add(getAllOffers());
    //  await recommended_product_bloc.add(getRecommendedProduct_click());
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) =>
          translator.currentLanguage == 'ar' ?
          CustomCircleNavigationBar(page_index: 4,) : CustomCircleNavigationBar()));
    }

    }


  }

