import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../Components/app_colors.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {

  TextEditingController searchController=TextEditingController();
  String? selectedCountry;

  Future<List<dynamic>> fetchCovidStats() async {
    String baseUrl = 'https://disease.sh/v3/covid-19/countries';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data as List;
    } else {
      throw Exception('Failed to load COVID-19 data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' '),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              cursorColor: AppColors.primary1,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey),
                  ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary2, width: 2),
                  ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
              ),

              onChanged: (value) {
                setState(() {});
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchCovidStats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) =>
                          ListTile(
                          leading: Container(height: 50,width: 50,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(100)),),
                          title: Container(height: 10,width: 80,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),),
                        subtitle: Container(height: 10,width: 80,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),),
                                            ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if(searchController.text.isEmpty){
                        return ListTile(
                          onTap: (){
                              selectedCountry = name;
                              Navigator.pop(context,selectedCountry);
                            print("Selected Country: $selectedCountry");
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              snapshot.data![index]['countryInfo']['flag'],
                            ),
                          ),
                          title: Text(snapshot.data![index]['country']),
                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                        );
                      }else if(name.toLowerCase().contains(searchController.text.toLowerCase())) {
                        return ListTile(
                          onTap: (){
                            selectedCountry = name;
                            Navigator.pop(context,selectedCountry);
                            print("Selected Country: $selectedCountry");
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              snapshot.data![index]['countryInfo']['flag'],
                            ),
                          ),
                          title: Text(snapshot.data![index]['country']),
                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                        );
                      } else{
                    return Container();
                      }

                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
