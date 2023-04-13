import 'package:demo25/screens/home/view/homePage.dart';
import 'package:demo25/screens/login/view/loginPage.dart';
import 'package:demo25/screens/registration/provider/registrationProvider.dart';
import 'package:demo25/utility/constant.dart';
import 'package:demo25/utility/login_reg_changePass/RegistrationUtility.dart';
import 'package:demo25/utility/login_reg_changePass/loginUtility.dart';
import 'package:demo25/utility/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  RegistrationProvider? providerTrue;
  RegistrationProvider? providerFalse;
  @override
  Widget build(BuildContext context) {
    providerTrue = Provider.of<RegistrationProvider>(context, listen: true);
    providerFalse = Provider.of<RegistrationProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Style.black,
        body: Form(
          key: providerFalse!.formKey,
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Style.darkBlue),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      color: Style.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 8, left: 8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            child: Icon(
                              Icons.person,
                              size: 65,
                            ),
                          ),
                          hSize(),
                          Text(
                            "Registration",
                            style: GoogleFonts.acme(
                                letterSpacing: .5,
                                fontSize: 23,
                                color: Style.black),
                          ),
                          hSize(),
                          reg_email_textformfield(
                              'Enter Email id',
                              Icon(
                                Icons.email,
                                color: Style.grey,
                              ),
                              providerTrue!.registration_email),
                          hSize(),
                          reg_password_textFormField('Enter Password',
                              providerTrue!.registration_password),
                          hSize(),
                          reg_re_password_textFormField('Enter Re-Password',
                              providerTrue!.registration_re_password),
                          hSize(),
                          reg_phone_number(providerFalse!.phone_num),
                          hSize(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (providerTrue!.formKey.currentState!
                                      .validate()) {
                                    if (providerTrue!
                                            .registration_password.text !=
                                        providerTrue!
                                            .registration_re_password.text) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Password and re password are not same",
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Style.white,
                                          textColor: Style.black,
                                          fontSize: 14.0);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: Text("Password Changed !!"),
                                        ),
                                      );
                                      save(
                                          providerTrue!.registration_email.text,
                                          providerTrue!
                                              .registration_password.text,
                                          providerTrue!
                                              .registration_re_password.text,
                                          providerTrue!.phone_num.text);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    }
                                  }
                                  // if (providerTrue!.registration_email.text.isEmpty) {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Please Enter Email",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Style.white,
                                  //       textColor: Style.black,
                                  //       fontSize: 14.0);
                                  // } else if (providerTrue!
                                  //     .registration_password.text.isEmpty) {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Please Enter Password",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Style.white,
                                  //       textColor: Style.black,
                                  //       fontSize: 14.0);
                                  // } else if (providerTrue!
                                  //     .registration_re_password.text.isEmpty) {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Please Enter Re Password",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Style.white,
                                  //       textColor: Style.black,
                                  //       fontSize: 14.0);
                                  // } else if (providerTrue!.phone_num.text.isEmpty) {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Please Enter Phone Number",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Style.white,
                                  //       textColor: Style.black,
                                  //       fontSize: 14.0);
                                  // } else if (providerTrue!.registration_password.text !=
                                  //     providerTrue!.registration_re_password.text) {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Password and re password are not same",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Style.white,
                                  //       textColor: Style.black,
                                  //       fontSize: 14.0);
                                  // } else {
                                  //   save(
                                  //       providerTrue!.registration_email.text,
                                  //       providerTrue!.registration_password.text,
                                  //       providerTrue!.registration_re_password.text,
                                  //       providerTrue!.phone_num.text);
                                  //   Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => LoginPage(),
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: Text("Submit"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  providerTrue!.registration_email.clear();
                                  providerTrue!.registration_password.clear();
                                  providerTrue!.registration_re_password
                                      .clear();
                                  providerTrue!.phone_num.clear();
                                },
                                child: Text("Clear Data"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
