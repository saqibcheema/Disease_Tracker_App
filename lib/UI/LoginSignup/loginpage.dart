import 'package:disease_tracker_app/Components/app_colors.dart';
import 'package:disease_tracker_app/Components/button_refactor.dart';
import 'package:disease_tracker_app/Components/text_style.dart';
import 'package:disease_tracker_app/UI/LoginSignup/signup.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../Components/button_Handlers.dart';

class LoginPage extends StatelessWidget {
    LoginPage({super.key});
    final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  TextLine(
                    name: 'Login',
                    style: AppTextStyles.poppinsBold,
                    size: 20,
                  ),
                  SizedBox(height: 10),
                  ApiButton(
                    icon: Icons.facebook,
                    text: 'Continue with Facebook',
                    color: Colors.white,
                    backgroundColor: AppColors.secondary2,
                    onTap: () => ButtonHandlers.handleFacebookLogin(context),
                  ),
                  ApiButton(
                    image: 'assets/image/logo.png',
                    text: 'Continue with Gmail',
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    onTap: () => ButtonHandlers.handleGoogleLogin(context),
                  ),
                  SizedBox(height: 20),
                  TextLine(
                    name: 'OR',
                    style: AppTextStyles.poppinsSemiBold,
                    size: 12,
                  ),
                  SizedBox(height: 10),
                  TextForm(labelName: 'E-mail', hintText: 'E-mail / Username', controller: emailController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email is required'),
                      EmailValidator(errorText: 'Enter a valid email'),
                    ]).call ,),
                  TextForm(
                    labelName: 'Password',
                    hintText: 'Password',
                    controller: passwordController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                      MinLengthValidator(8, errorText: 'Password must be at least 8 characters'),
                      PatternValidator(r'(?=.*?[A-Z])', errorText: 'One uppercase letter needed'),
                      PatternValidator(r'(?=.*?[a-z])', errorText: 'One lowercase letter needed'),
                      PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'One special character needed'),
                    ]).call ,
                    isPassword: true,
                  ),
                  SizedBox(height: 10),
                  ApiButton(
                    text: 'Sign in',
                    color: Colors.white,
                    backgroundColor: AppColors.primary2,
                    onTap: () => ButtonHandlers.handleSignup(context),
                  ),
                  SizedBox(height: 10),
                  CustomFieldRow(
                    text: 'Did not have an account? ',
                    action: 'Sign up',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
