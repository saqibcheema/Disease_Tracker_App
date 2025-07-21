
import 'package:disease_tracker_app/UI/welcome/HomeScreen.dart';
import 'package:disease_tracker_app/UI/welcome/countryList.dart';
import 'package:disease_tracker_app/UI/welcome/profile.dart';
import 'package:disease_tracker_app/UI/welcome/welcome.dart';
import 'package:flutter/material.dart';

import 'LoginSignup/signup.dart';
import 'Maps/nearest_hospital.dart';

void main() {
  runApp(const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: SignUpPage(),
    );
  }
}

