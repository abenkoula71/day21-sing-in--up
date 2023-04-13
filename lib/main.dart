import 'package:demo25/screens/changePassword/provider/changeProvider.dart';
import 'package:demo25/screens/changePassword/view/changePasswordPage.dart';
import 'package:demo25/screens/intro/provider/introProvider.dart';
import 'package:demo25/screens/intro/view/introPage.dart';
import 'package:demo25/screens/login/provider/loginProvider.dart';
import 'package:demo25/screens/login/view/loginPage.dart';
import 'package:demo25/screens/registration/provider/registrationProvider.dart';
import 'package:demo25/screens/registration/view/registrationPage.dart';
import 'package:demo25/screens/splash/view/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IntroProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistrationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChangePasswordProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    ),
  );
}
