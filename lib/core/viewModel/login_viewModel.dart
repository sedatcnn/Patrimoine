import 'package:flutter/material.dart';
import 'package:patrimonie/core/authentication/user_authentication.dart';
import 'package:patrimonie/page/navbar/nav_controller.dart';

class UserLoginPageViewModel with ChangeNotifier {
  final AuthServiceUser _authenticationService = AuthServiceUser();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInUser(BuildContext context) async {
    String? result = await _authenticationService.signInUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyBottomNavBar()));
    } else {}
  }
}
