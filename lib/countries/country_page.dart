import 'package:flutter/material.dart';
import 'package:project1v5/booking/my_booking_page.dart';
import 'package:project1v5/countries/all_countries.dart';
import 'package:project1v5/home_page.dart';
import 'package:project1v5/project_materials/components/trip_card.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/country_model.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';
import 'package:project1v5/trip/trip_page.dart';

class CountryPage extends StatefulWidget {
  final TripModel? tripModel;
  final OneTripModel? oneTripModel;
  final CountryModel? countryModel;

  const CountryPage(
      {super.key, this.tripModel, this.oneTripModel, this.countryModel});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Crud crud = Crud();
  int currentIndex = 0;
  bool searchHasData = false;

  final List<Widget> pages = [
    HomePage(),
    AllCountries(),
    MyBookingPage(),
  ];

  Future<dynamic> getTripsForOneCountry() async {
    late final imageResponse;
    print('widget.countryModel!.id ------------- : ${widget.countryModel!.id}');
    try {
      var response = await crud
          .getRequest("$linkViewTripsForOneCountry/${widget.countryModel!.id}");
      try {
        widget.tripModel!.attributes!.image =
            '$publishedBaseUrl/storage/2/01JC17MFZTA7JMVJ46V2WC3T4H.jpg';
      } catch (e, h) {
        print("getTripProfileImages Error is:        $e \n $h");
      }
      print(response);
      List<dynamic> data = response['data'];
      List<TripModel> trips =
          data.map((item) => TripModel.fromJson(item)).toList();

      return trips;
    } catch (e, h) {
      print("getTripsForOneCountry Error is:        $e, \n $h");
      print("getTripsForOneCountry Error is:---------------- $h");
    }
  }

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
                title: Text("${widget.countryModel!.name}"),
                backgroundColor: Colors.teal[50],
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
                    case 2:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyBookingPage()));
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
                  BottomNavigationBarItem(
                    icon: Icon(Icons.map, color: Colors.teal),
                    label: 'MyBookings',
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: trips.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TripPage(tripModel: trips[i])));
                            },
                            child: TripCard(
                              tripModel: trips[i],
                            ),
                          );
                        },
                      ),
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
