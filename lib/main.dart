import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:orbitnetmobileapp/core/services/login.dart';
import 'package:orbitnetmobileapp/screens/login/Login_Screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<LoginService>(create: (_) => LoginService()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder:  (BuildContext context, Widget? child){ 
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orbit',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            textTheme:
                GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)),
        home: AnimatedSplashScreen(
            duration: 2500,
            splash: Image.asset(
              'lib/assets/logo.png',
              width: 2000,
            ),
            nextScreen:LoginScreen() ,//ChiffAffCreditRech(key: GlobalKey<FormState>(),),// LoginScreen() ,//
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.black87),
      );
      }
    );
  }
}
  