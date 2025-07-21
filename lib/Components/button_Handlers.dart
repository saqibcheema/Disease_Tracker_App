 import 'package:flutter/material.dart';
import '../UI/AccountVerification/accoutverification.dart';


class ButtonHandlers{



  // Signup button ke liye function
  static void  handleSignup(BuildContext context) {
    // Snackbar show karen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Signup Successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // 2 seconds baad next page par navigate karen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccountVerification()),
      );
    });
  }

  // Google login ke liye function
  static void  handleGoogleLogin(BuildContext context) {
    print('Google login clicked');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google Login Started...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  static void  handleFacebookLogin(BuildContext context) {
    print('Facebook login clicked');
    // Yahan Facebook login ka code likhenge
    // Facebook SDK use karen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Facebook Login Started...'),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}