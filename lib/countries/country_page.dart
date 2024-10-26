// /*
import 'package:flutter/material.dart';
import 'package:project1v5/countries/all_countries.dart';
import 'package:project1v5/home_page.dart';
import 'package:project1v5/project_materials/components/trip_card.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/country_model.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';

class CountryPage extends StatefulWidget {
  final TripModel? tripModel;
  final OneTripModel? oneTripModel;
  final CountryModel? countryModel;

  ///
  const CountryPage(
      {super.key, this.tripModel, this.oneTripModel, this.countryModel});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Crud crud = Crud();
  int currentIndex = 0;
  final List<Widget> pages = [HomePage(), AllCountries()];

  // /*
  Future<List<TripModel>> getTripsForOneCountry() async {
    try {
      print(linkViewTripsForOneCountry);
      print(widget.countryModel!.id);
      var response = await crud
          .getRequest("$linkViewTripsForOneCountry/${widget.countryModel!.id}");
      //"id": sharedPref.getString("id"), // to show the owned items
      print(
          "linkViewTripsForOneCountry/countryid:         $linkViewTripsForOneCountry/${widget.countryModel!.id}");
      List<dynamic> data = response['data'];
      List<TripModel> trips =
          data.map((item) => TripModel.fromJson(item)).toList();
      return trips;
    } catch (e) {
      print("getTripsForOneCountry Error is:        $e");
    }
    return [];
  }
  // */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getTripsForOneCountry(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TripModel> trips = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: const Text("this is appBar!"),
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: const TextStyle(fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                  switch (index) {
                    case 0:
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                      break;
                    case 1:
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AllCountries()));
                      break;
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: Colors.teal),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.map,
                      color: Colors.teal,
                    ),
                    label: 'Countries',
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Where are you going?",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.black),
                        ),
                      ),
                      ListView.builder(
                        itemCount: trips.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return TripCard(
                            tripModel: widget.tripModel, //trips[i],
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
// */

/*
import 'package:flutter/material.dart';
import 'package:project1v5/countries/all_countries.dart';
import 'package:project1v5/home_page.dart';
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
  int currentIndex = 0;
  final List<Widget> pages = [HomePage(), AllCountries()];

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
              appBar: AppBar(
                title: const Text("this is appBar!"),
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: const TextStyle(fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                  switch (index) {
                    case 0:
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                      break;
                    case 1:
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AllCountries()));
                      break;
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: Colors.teal),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.map,
                      color: Colors.teal,
                    ),
                    label: 'Countries',
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Where are you going?",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.black),
                        ),
                      ),
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
*/
