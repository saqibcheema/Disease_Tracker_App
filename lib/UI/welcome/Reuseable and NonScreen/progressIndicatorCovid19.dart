import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../Components/app_colors.dart';

class RecoveryRateCard extends StatelessWidget {
  final int affected;
  final int recovered;

  const RecoveryRateCard({
    super.key,
    required this.affected,
    required this.recovered,
  });

  @override
  Widget build(BuildContext context) {
    double recoveryRate = recovered / affected;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 10.0,
            percent: recoveryRate.clamp(0.0, 1.0),
            center: Text(
              "${(recoveryRate * 100).toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            progressColor: AppColors.primary1,
            backgroundColor: AppColors.primary2,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 16),
          const Text(
            "Rate of Recovery",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.circle, color: AppColors.primary1, size: 10),
                      SizedBox(width: 4),
                      Text("Affected"),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    affected.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.circle, color: AppColors.primary2, size: 10),
                      SizedBox(width: 4),
                      Text("Recovered"),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recovered.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
