import 'package:disease_tracker_app/Components/app_colors.dart';
import 'package:disease_tracker_app/Components/text_style.dart';
import 'package:disease_tracker_app/Components/zoomableWidget.dart';
import 'package:disease_tracker_app/UI/welcome/profile.dart';
import 'package:flutter/material.dart';

import '../Maps/nearest_hospital.dart';
import 'Statistices.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                children: [

                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome',
                        style: AppTextStyles.poppinsBold.copyWith(
                          color: AppColors.secondary1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Hey joe we are here to help you out.',
                style: AppTextStyles.poppinsRegular.copyWith(
                  color: AppColors.secondary2,
                ),
              ),
              SizedBox(height: 20),
              Material(
                borderRadius: BorderRadius.circular(12),
                elevation: 4,
                color: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Center(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.center,
                      children: [
                        Icon(Icons.report, size: 30, color: AppColors.primary2),
                        Text(
                          'Report a case',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  buildMenuCard(Icons.bar_chart, 'COVID-19\nStatistics', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatesScreen()),
                    );
                  }),
                  buildMenuCard(Icons.public, 'COVID-19\nPreventions', () {}),
                  buildMenuCard(Icons.local_hospital, 'Medical\nCentres', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NearestHospital(),
                      ),
                    );
                  }),
                  buildMenuCard(Icons.vaccines, 'COVID-19\nSymptoms', () {}),
                  buildMenuCard(Icons.support_agent, 'Online\nSupport', () {}),
                  buildMenuCard(Icons.account_circle, 'Account\nsettings', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuCard(IconData icon, String label, VoidCallback onTap) {
    return ZoomableWidget(
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          child: Container(
            width: 140, // adjust for responsiveness
            height: 140,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: AppColors.primary2),
                SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary2,
                    fontWeight: FontWeight.w500,
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
