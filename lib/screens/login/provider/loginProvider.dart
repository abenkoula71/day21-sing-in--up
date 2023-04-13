import 'package:flutter/cupertino.dart';

bool pass = false;

class LoginProvider extends ChangeNotifier {
  bool value = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController login_email = TextEditingController();
  TextEditingController login_password = TextEditingController();

  void change_checkbox(newValue) {
    value = newValue;
    notifyListeners();
  }

  void change_pass(newValue) {
    pass = newValue;
    pass = !pass;
    notifyListeners();
  }
}
