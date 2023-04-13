import 'package:demo25/screens/login/provider/loginProvider.dart';
import 'package:demo25/screens/login/view/loginPage.dart';
import 'package:demo25/utility/constant.dart';
import 'package:demo25/utility/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginProvider? providerTrue;
  LoginProvider? providerFalse;
  @override
  Widget build(BuildContext context) {
    providerTrue = Provider.of<LoginProvider>(context, listen: true);
    providerFalse = Provider.of<LoginProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login successfully",
                style: GoogleFonts.acme(
                    letterSpacing: .5, fontSize: 30, color: Style.black),
              ),
              hSize(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      clear();
                      providerTrue!.login_email.clear();
                      providerTrue!.login_password.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text("Clear All Data"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();

                      var getCheck = prefs.getBool('login');
                      if (providerTrue!.value == false) {
                        providerTrue!.login_email.clear();
                        providerTrue!.login_password.clear();
                        getCheck = false;
                        prefs.setBool('login', getCheck);

                        var a = loginCheck();
                        print(getCheck);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      } else {
                        getCheck = false;
                        prefs.setBool('login', getCheck);

                        var a = loginCheck();
                        print(getCheck);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      }
                    },
                    child: Text("Log Out"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
