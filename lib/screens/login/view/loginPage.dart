import 'package:demo25/screens/changePassword/provider/changeProvider.dart';
import 'package:demo25/screens/changePassword/view/changePasswordPage.dart';
import 'package:demo25/screens/home/view/homePage.dart';
import 'package:demo25/screens/login/provider/loginProvider.dart';
import 'package:demo25/screens/registration/view/registrationPage.dart';
import 'package:demo25/utility/constant.dart';
import 'package:demo25/utility/login_reg_changePass/loginUtility.dart';
import 'package:demo25/utility/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginProvider? providerTrue;
  LoginProvider? providerFalse;
  @override
  Widget build(BuildContext context) {
    providerTrue = Provider.of<LoginProvider>(context, listen: true);
    providerFalse = Provider.of<LoginProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
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
                    height: MediaQuery.of(context).size.height / 1.5,
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
                            "Login",
                            style: GoogleFonts.acme(
                                letterSpacing: .5,
                                fontSize: 23,
                                color: Style.black),
                          ),
                          hSize(),
                          customTextEditingController(
                              'Enter Email id',
                              Icon(
                                Icons.email,
                                color: Style.grey,
                              ),
                              providerFalse!.login_email),
                          hSize(),
                          TextFormField(
                            controller: providerFalse!.login_password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "PLease Enter Your Password";
                              }
                              if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(value)) {
                                return "Please enter a valid Password";
                              } else {
                                return null;
                              }
                            },
                            obscureText: (pass == false) ? true : false,
                            style: TextStyle(color: Style.black),
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(color: Style.grey),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  providerTrue!.change_pass(pass);
                                },
                                icon: Icon(
                                  (pass == true) ? Icons.lock_open : Icons.lock,
                                  color: Style.grey,
                                ),
                              ),

                              // Icon(
                              //   Icons.lock,
                              //   color: Style.grey,
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Style.grey),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: new BorderSide(color: Style.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide:
                                    BorderSide(width: 1, color: Style.white),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Style.white,
                                // autofocus: true,
                                focusColor: Style.white,
                                checkColor: Style.black,
                                value: providerFalse!.value,
                                side: MaterialStateBorderSide.resolveWith(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return const BorderSide(
                                          width: 2, color: Colors.grey);
                                    }
                                    return const BorderSide(
                                        width: 1, color: Colors.grey);
                                  },
                                ),
                                onChanged: (newValue) {
                                  providerFalse!.change_checkbox(newValue);
                                },
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(color: Style.grey),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  Provider.of<ChangePasswordProvider>(context,
                                          listen: false)
                                      .change_new_pass
                                      .clear();
                                  Provider.of<ChangePasswordProvider>(context,
                                          listen: false)
                                      .change_password
                                      .clear();
                                  Provider.of<ChangePasswordProvider>(context,
                                          listen: false)
                                      .change_re_new_pass
                                      .clear();

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordPage(),
                                    ),
                                  );
                                },
                                child: Text("Change Password"),
                              ),
                            ],
                          ),
                          hSize(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 19),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 14.7,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () async {
                                  String? email = await readEmail();
                                  String? password = await readPassword();

                                  if (providerTrue!.formKey.currentState!
                                      .validate()) {
                                    if (providerTrue!.login_email.text !=
                                        email) {
                                      Fluttertoast.showToast(
                                          msg: "Email Id Not Same",
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Style.black,
                                          textColor: Style.white,
                                          fontSize: 14.0);
                                    } else if (providerTrue!
                                            .login_password.text !=
                                        password) {
                                      Fluttertoast.showToast(
                                          msg: "Password Not Same",
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Style.black,
                                          textColor: Style.white,
                                          fontSize: 14.0);
                                    } else {
                                      login();
                                      bool? checkLogin = await loginCheck();
                                      print(checkLogin);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    }

                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => HomePage(),
                                    //   ),
                                    // );
                                  }

                                  // else if (providerTrue!.login_email.text !=
                                  //     email) {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Email Id Not Same",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Style.white,
                                  //       textColor: Style.black,
                                  //       fontSize: 14.0);
                                  // } else if (providerTrue!.login_password.text !=
                                  //     password) {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Password Not Same",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Style.white,
                                  //       textColor: Style.black,
                                  //       fontSize: 14.0);
                                  // } else {
                                  //   Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => HomePage(),
                                  //     ),
                                  //   );
                                  // }

                                  //  else if (providerTrue!.formKey.currentState!
                                  //     .validate()) {
                                  //   Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => RegistrationPage(),
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                            ),
                          ),
                          hSize(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have Not Account Yet?",
                                style:
                                    TextStyle(color: Style.black, fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationPage(),
                                    ),
                                  );
                                },
                                child: Text("Create Account"),
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
