import 'dart:convert';
import 'package:disease_tracker_app/API/apis_Urls.dart';
import 'package:disease_tracker_app/Components/app_colors.dart';
import 'package:disease_tracker_app/UI/welcome/countryList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Components/text_style.dart';
import '../../Models/covid19_model.dart';
import 'Reuseable and NonScreen/StatsUpdateComponent.dart';
import 'Reuseable and NonScreen/covidScreenShimmer.dart';
import 'Reuseable and NonScreen/progressIndicatorCovid19.dart';

class StatesScreen extends StatefulWidget {
  const StatesScreen({super.key});

  @override
  State<StatesScreen> createState() => _StatesScreenState();
}

class _StatesScreenState extends State<StatesScreen> {
  Future<Covid19Model>? future;
  var positionOfViews = 0;
  var selectedCountry;
  bool inGlobal=true;

  @override
  void initState() {
    super.initState();
    future = fetchCovidStats(isGlobal: true);
  }

  Future<Covid19Model> fetchCovidStats({
    required bool isGlobal,
    String? country,
    bool isYesterday = false,
  }) async {

    String endpoint;

    if (isGlobal) {
      endpoint = 'all';
    } else {
      if (country == null || country.isEmpty) {
        throw ArgumentError('Country name required');
      }
      endpoint = 'countries/$country';
    }

    String url = '${ApiConstants.baseUrlCovidApi}$endpoint';
    if (isYesterday) {
      url += '?yesterday=true';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Covid19Model.fromJson(data);
    } else {
      throw Exception('Failed to load COVID-19 data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CovidStatsShimmer();
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Statistics',
                              style: AppTextStyles.poppinsBold.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Explore covid 19 regular updates on this tab',
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                              color: AppColors.primary2,
                              width: 2,
                            ),
                          ),
                          child: Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        inGlobal=true;
                                        future = fetchCovidStats(isGlobal: true);
                                      });
                                    },
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: inGlobal==true?AppColors.primary2: Colors.white  ,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Global',
                                          style: AppTextStyles.poppinsMedium
                                              .copyWith(
                                                color: inGlobal==true? Colors.white: AppColors.primary2,
                                                fontSize: 17,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      inGlobal=false;
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CountryList(),
                                        ),
                                      );

                                      if (result != null) {
                                        setState(() {
                                          selectedCountry = result;
                                          future = fetchCovidStats(
                                            country: selectedCountry,
                                            isGlobal: false,
                                          );
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: inGlobal==false?AppColors.primary2:Colors.white ,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Country ',
                                          style: AppTextStyles.poppinsMedium
                                              .copyWith(
                                                color: inGlobal==false?Colors.white:AppColors.primary2,
                                                fontSize: 17,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 4,
                      runSpacing: 3,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              positionOfViews = 0;
                            });
                          },
                          child: Container(
                            width: 110,
                            height: 34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  positionOfViews == 0
                                      ? AppColors.primary1
                                      : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                    0.4,
                                  ), // shadow color
                                  spreadRadius: 2, // how wide it spreads
                                  blurRadius: 8, // how soft the shadow looks
                                  offset: Offset(
                                    0,
                                    4,
                                  ), // x: right/left, y: down/up
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Total',
                                style: AppTextStyles.poppinsMedium.copyWith(
                                  fontSize: 12,
                                  color:
                                      positionOfViews == 0
                                          ? Colors.white
                                          : AppColors.secondary2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              positionOfViews = 1;
                            });
                          },
                          child: Container(
                            width: 110,
                            height: 34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  positionOfViews == 1
                                      ? AppColors.primary1
                                      : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                    0.4,
                                  ), // shadow color
                                  spreadRadius: 2, // how wide it spreads
                                  blurRadius: 8, // how soft the shadow looks
                                  offset: Offset(
                                    0,
                                    4,
                                  ), // x: right/left, y: down/up
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Today',
                                style: AppTextStyles.poppinsMedium.copyWith(
                                  fontSize: 12,
                                  color:
                                      positionOfViews == 1
                                          ? Colors.white
                                          : AppColors.secondary2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              positionOfViews = 2;
                              future = fetchCovidStats(
                                isGlobal: selectedCountry == null,
                                isYesterday: true,
                                country: selectedCountry,
                              );
                            });
                          },

                          child: Container(
                            width: 110,
                            height: 34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  positionOfViews == 2
                                      ? AppColors.primary1
                                      : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                    0.4,
                                  ), // shadow color
                                  spreadRadius: 2, // how wide it spreads
                                  blurRadius: 8, // how soft the shadow looks
                                  offset: Offset(
                                    0,
                                    4,
                                  ), // x: right/left, y: down/up
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Yesterday',
                                style: AppTextStyles.poppinsMedium.copyWith(
                                  fontSize: 12,
                                  color:
                                      positionOfViews == 2
                                          ? Colors.white
                                          : AppColors.secondary2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    UpdateScreen(
                      recoverd:
                          positionOfViews == 1
                              ? (0).toInt()
                              : (snapshot.data!.recovered ?? 0).toInt(),
                      deaths:
                          positionOfViews == 1
                              ? (0).toInt()
                              : (snapshot.data!.deaths ?? 0).toInt(),
                      active: (snapshot.data!.active ?? 0).toInt(),
                      critical: (snapshot.data!.critical ?? 0).toInt(),
                    ),
                    SizedBox(height: 20),
                    RecoveryRateCard(
                      affected: (snapshot.data!.cases ?? 0).toInt(),
                      recovered: (snapshot.data!.recovered ?? 0).toInt(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
