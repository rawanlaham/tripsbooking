import 'package:flutter/material.dart';
import 'package:project1v5/project_materials/components/get_trips_of_country.dart';
import 'package:project1v5/project_materials/components/get_trips_of_country_func.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';

class CountryPage extends StatefulWidget {
  final String countryName;
  const CountryPage({super.key, required this.countryName});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final NewGetTripsOfCountry newy = NewGetTripsOfCountry();

  Crud crud = Crud();
  getTripsOfCountry() async {
    try {
      var response = await crud.getRequest(linkViewTripsOfCountry);
      //"id": sharedPref.getString("id"), // to show the owned items
      return response;
    } catch (e) {
      print("GetTripsOfCountry error is: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getTripsOfCountry(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: "Explore"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border), label: "Trips"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined), label: "Profile"),
                ],
              ),
              appBar: AppBar(
                title: Text(widget.countryName),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: (snapshot.data as Map<String, dynamic>)["data"]
                          .length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return GetTripsOfCountry(
                          tripDescription:
                              (snapshot.data as Map<String, dynamic>)["data"][i]
                                  ["attributes"]["description"],
                          tripDuration:
                              (snapshot.data as Map<String, dynamic>)["data"][i]
                                  ["attributes"]["duration"],
                          //tripDuration: (snapshot.data as List<dynamic>)[i]["name"],
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text("Is loading..."),
          );
        },
      ),
    );
  }
}
