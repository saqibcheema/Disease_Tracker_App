import 'package:disease_tracker_app/Components/text_style.dart';
import 'package:flutter/material.dart';

import '../../../Components/app_colors.dart';

class UpdateScreen extends StatelessWidget {
  late var recoverd, deaths, active, critical;

  UpdateScreen({
    super.key,
    required this.recoverd,
    required this.deaths,
    required this.active,
    required this.critical,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary2,
              ),
              child: Center(
                child: Text(
                  'Recoverd\n$recoverd',
                  style: AppTextStyles.poppinsBold.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary1,
              ),
              child: Center(
                child: Text(
                  'Deaths\n$deaths',
                  style: AppTextStyles.poppinsBold.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Wrap(
          spacing: 20,
          runSpacing: 4,

          children: [
            Container(
              width: 94,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Recoverd\n$recoverd',
                  style: AppTextStyles.poppinsBold.copyWith(
                    fontSize: 12,
                    color: AppColors.primary2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              width: 94,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Active\n$active',
                  style: AppTextStyles.poppinsBold.copyWith(
                    fontSize: 12,
                    color: AppColors.primary2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              width: 94,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Critical\n$critical ',
                  style: AppTextStyles.poppinsBold.copyWith(
                    fontSize: 12,
                    color: AppColors.primary2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
