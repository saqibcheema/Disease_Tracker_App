import 'package:disease_tracker_app/Components/app_colors.dart';
import 'package:disease_tracker_app/Components/button_refactor.dart';
import 'package:disease_tracker_app/Components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../welcome/welcome.dart';

class AccountVerification extends StatefulWidget {
  const AccountVerification({super.key});

  @override
  State<AccountVerification> createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {

  late String _generatedOtp;
  late String _enteredOtp;

  @override
  void initState() {
    super.initState();
    _generateOtp();
  }

  void _generateOtp() async {
    final Random random = Random();
    _generatedOtp = (1000 + random.nextInt(9000)).toString();
    print('Generated OTP (for test): $_generatedOtp');

    String recipientEmail = "saqibyu971@gmail.com";
    String yourEmail = "saqibyu961@gmail.com";
    String appPassword = "njmhxkycgfgtmupn";

    final smtpServer = gmail(yourEmail, appPassword);

    final message = Message()
      ..from = Address(yourEmail, 'Disease Tracker App')
      ..recipients.add(recipientEmail)
      ..subject = 'Your OTP Code'
      ..text = 'Your OTP code is: $_generatedOtp';

    try {
      await send(message, smtpServer);
      print('OTP Sent to $recipientEmail');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP has been sent to your email.')),
      );
    } catch (e) {
      print('Error sending OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send OTP.')),
      );
    }
  }

  void  verifyOtp(String enteredOtp) {
    if (enteredOtp == _generatedOtp) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>   WelcomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong OTP! Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Icon(Icons.arrow_back_ios_new_outlined)),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Account Verification',
                    style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 20),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                'We have sent you a four digit code to your email address.\n'
                    'Enter the code below to verify your account',
                textAlign: TextAlign.center,

                style: AppTextStyles.poppinsMedium.copyWith(
                  fontSize: 10,
                  color: AppColors.secondary2,
                ),
              ),
            ),
            SizedBox(height: 170),
            OtpTextField(
              showFieldAsBox: true,
              fieldWidth: 65,
              focusedBorderColor: AppColors.primary1,
              textStyle: TextStyle(color: AppColors.primary1,fontSize: 35),
              fieldHeight: 80,
              disabledBorderColor: Colors.white,
              onSubmit: (String code) {
                _enteredOtp = code; // store user input
              },
            ),
            SizedBox(height: 100,),
            ApiButton(text: 'VerifyAccount', color: Colors.white, backgroundColor: AppColors.primary2  ,onTap:() =>  verifyOtp(_enteredOtp),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do not receive code yet?'),
                InkWell(
                  onTap: () {
                    _generateOtp();
                  },
                  child: Text(
                    'Resend',
                    style: AppTextStyles.poppinsMedium.copyWith(
                      color: AppColors.primary2,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
