import 'package:disease_tracker_app/Components/zoomableWidget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../Models/NearestHospital.dart';
import '../../Components/app_colors.dart';
import '../../Components/text_style.dart';
import 'Components/HospitalImageList.dart';

class HospitalListWidget extends StatefulWidget {
  final Future<List<Hospital>> Function() fetchHospitals;
  final void Function(Hospital) onDrawRoute;

  const HospitalListWidget({
    super.key,
    required this.fetchHospitals,
    required this.onDrawRoute,
  });

  @override
  State<HospitalListWidget> createState() => _HospitalListWidgetState();
}

class _HospitalListWidgetState extends State<HospitalListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hospital>>(
      future: widget.fetchHospitals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 17),
                  height: 110,
                  width: 94,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            width: double.infinity,
                            height: 16,decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text("No hospitals found");
        }
        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final hospital = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  hospitaldetailsheet(context, hospital, widget.onDrawRoute);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 17),
                  height: 110,
                  width: 94,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ), // Same as outer container
                          child: Image.asset(
                            HospitalImageLinks.hospitalImages[index],
                            fit: BoxFit.cover,
                            width:
                                double
                                    .infinity, // ensures it fills available width
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          hospital.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

void hospitaldetailsheet(
  BuildContext context,
  Hospital hospital,
  Function(Hospital) onDrawRoute,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (context) => FractionallySizedBox(
          heightFactor: 0.75,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 5),
                        Text(
                          '${hospital.rating} Rating',
                          style: AppTextStyles.poppinsMedium,
                        ),
                      ],
                    ),
                    Text('182.8 km away', style: TextStyle(color: Colors.blue)),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Private Hospital',
                  style: AppTextStyles.poppinsMedium.copyWith(
                    color: AppColors.secondary2,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.red, size: 18),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(hospital.address ?? 'No address found'),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.green, size: 18),
                    SizedBox(width: 5),
                    Text(hospital.phone ?? '+92-55-3456789'),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'Description',
                  style: AppTextStyles.poppinsBold.copyWith(fontSize: 14),
                ),
                SizedBox(height: 5),
                Text(
                  'Premium healthcare facility known for excellent patient care, modern amenities, and specialized medical treatments.',
                  style: AppTextStyles.poppinsMedium.copyWith(fontSize: 12),
                ),
                SizedBox(height: 15),
                Text(
                  'Services',
                  style: AppTextStyles.poppinsBold.copyWith(fontSize: 14),
                ),
                SizedBox(height: 8),
                ZoomableWidget(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        hospital.services
                            .map(
                              (service) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue.shade50,
                                  border: Border.all(color: Colors.blue),
                                ),
                                child: Text(
                                  service,
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ZoomableWidget(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          icon: Icon(Icons.call, color: AppColors.secondary1),
                          label: Text(
                            'Call Now',
                            style: TextStyle(color: AppColors.secondary1),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ZoomableWidget(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          icon: Icon(
                            Icons.directions,
                            color: AppColors.secondary1,
                          ),
                          label: Text(
                            'Directions',
                            style: TextStyle(color: AppColors.secondary1),
                          ),
                          onPressed: () {
                            onDrawRoute(hospital);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
  );
}
