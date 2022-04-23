import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skylark/view/views/activities/home/HomeActivity.dart';
import 'package:skylark/view/views/activities/setup/login.dart';

import '../../../provider/BookingProvider.dart';
import '../../../provider/SharedPreferenceProvider.dart';
import '../../constants/constants.dart';
import '../activities/setup/RegistrationActivity.dart';
import '../activities/setup/onBoarding.dart';

class RouteInit extends StatefulWidget {
  const RouteInit({Key? key}) : super(key: key);

  @override
  _RouteInitState createState() => _RouteInitState();
}

class _RouteInitState extends State<RouteInit> {
  bool isLoading = true, isSigned = true;
  final SharedPreferenceProvider _sharedPreferenceProvider =
      SharedPreferenceProvider();

  @override
  void initState() {
    super.initState();
    checkIfSigned();
  }

  Future<void> checkIfSigned() async {
    var signedState = await _sharedPreferenceProvider.isLoggedIn();
    setState(() {
      isSigned = signedState;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (BuildContext context) => BookingProvider(),
              ),
            ],
            child: buildMaterialApp(),
          );
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Skylark',
      theme: buildThemeData(),
      //banner
      debugShowCheckedModeBanner: false,
      //routes
      initialRoute: isSigned ? HomeActivity.id : OnBoarding.id,
      routes: routes(),
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      OnBoarding.id: (context) => const OnBoarding(),
      HomeActivity.id: (context) => const HomeActivity(),
      LoginActivity.id: (context) => const LoginActivity(),
      RegistrationActivity.id: (context) => const RegistrationActivity(),
    };
  }

  ThemeData buildThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: kAccent,
      //scaffoldBackgroundColor: Colors.white,
      //buttons
      buttonTheme: const ButtonThemeData(
        buttonColor: kAccent,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            kAccent,
          ), //button color
          foregroundColor: MaterialStateProperty.all<Color>(
            const Color(0xffffffff),
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      //text
      fontFamily: 'Auro',
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Auro'),
      ),
      //colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccent),
    );
  }
}
