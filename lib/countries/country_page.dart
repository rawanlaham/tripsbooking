import 'package:flutter/material.dart';
import 'package:project1v5/project_materials/components/trip_card.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';

class CountryPage extends StatefulWidget {
  final TripModel? tripModel;
  final OneTripModel? oneTripModel;

  ///
  const CountryPage({super.key, this.tripModel, this.oneTripModel});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Crud crud = Crud();

  ///
  Future<List<TripModel>> getTripsOfCountry() async {
    try {
      var response = await crud.getRequest(linkViewTripsOfCountry);
      //"id": sharedPref.getString("id"), // to show the owned items
      List<dynamic> data = response['data'];
      List<TripModel> trips =
          data.map((item) => TripModel.fromJson(item)).toList();
      return trips;
    } catch (e) {
      print("GetTripsOfCountry error is: $e");
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getTripsOfCountry(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TripModel> trips = snapshot.data!;

            ///
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
                title: const Text("this is appBar!"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: trips.length,

                        ///
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return TripCard(
                            tripModel: trips[i],
                            //oneTripModel: widget.oneTripModel,
                            ///
                          );
                        },
                      )
                    ],
                  ),
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
