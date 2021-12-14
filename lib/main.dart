import 'package:ezhyper/Screens/Filter/filterScreen.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:notification_permissions/notification_permissions.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    assetsDirectory: 'assets/Langs/',

  );
  runApp(
    new MyApp(),
  );
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType();
    print(newLocale.languageCode);
    // ignore: invalid_use_of_protected_member
    state.setState(() => state.local = newLocale);
  }
}

class _MyAppState extends State<MyApp>{

  Locale local;
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  AppPushNotifications appPushNotifications = AppPushNotifications();

  @override
  void initState() {
    setState(() {
      appPushNotifications.notificationSetup(navKey);
    });
    Future<PermissionStatus> permissionStatus =
    NotificationPermissions.getNotificationPermissionStatus();
    permissionStatus.then((status) {
      print("======> $status");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   MaterialApp(
      localizationsDelegates: translator.delegates,
      locale: local,
      supportedLocales: translator.locals(),
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
        home: Splash(),
        theme: ThemeData(
            primaryColor: greenColor,
            accentColor: greenColor,
            fontFamily: "Cairo",
            textTheme: TextTheme(
              bodyText1: TextStyle(),
              bodyText2: TextStyle(),
            ).apply(
              bodyColor: textColor,
              displayColor: Colors.blue,
            )),

      localeResolutionCallback: (locale,supportedLocales){
        for( var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode==locale.languageCode && supportedLocale.countryCode == locale.countryCode){
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }

}

