import 'package:flutter/material.dart';
import 'package:project1v5/booking/my_booking_page.dart';
import 'package:project1v5/countries/all_countries.dart';
import 'package:project1v5/countries/country_page.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/components/conutry_card.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/country_model.dart';

class HomePage extends StatefulWidget {
  final CountryModel? countryModel;
  const HomePage({super.key, this.countryModel});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Crud crud = Crud();
  int currentIndex = 0;
  TextEditingController searchController = TextEditingController();
  final List<Widget> pages = [
    HomePage(),
    AllCountries(),
    MyBookingPage(),
  ];

  Future<dynamic> searchTrips(String data) async {
    if (data.isEmpty) return;

    var response = await crud.getRequest('$searchTrip?search=$data',
        printResponse: true, queryParameters: {'search': data});
    // print(response);
    return response;
  }

  Future<dynamic> getCountry() async {
    late final imageResponse;
    try {
      var response = await crud.getRequest(linkViewCountry);
      List<dynamic> data = response['data'];
      List<CountryModel> countries =
          data.map((item) => CountryModel.fromJson(item)).toList();

      try {
        imageResponse = await crud.getRequest(
            "$linkViewCountryProfileImages/${widget.countryModel!.id}");
        print("imageResponse        $imageResponse");
        widget.countryModel!.image =
            'http://10.0.2.2:8000/storage/1/01JC17MBJYY1VYB53AR3WEA8PG.webp';
      } catch (e) {
        print("getCountryProfileImages Error is:        $e");
      }
      return countries;
    } catch (e) {
      print("GetCountry error is: $e");
    }
    return imageResponse;
  }

  /*
  Future<List<CountryModel>> getCountry() async {
    try {
      var response = await crud.getRequest(linkViewCountry);
      List<dynamic> data = response['data'];
      List<CountryModel> countries =
          data.map((item) => CountryModel.fromJson(item)).toList();
      return countries;
    } catch (e) {
      print("GetCountry error is: $e");
    }
    return [];
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              color: Colors.teal,
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context).pushNamed("login");
              },
              icon: const Icon(Icons.exit_to_app))
        ],
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
              break;
            case 1:
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllCountries()));
              break;
            case 2:
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyBookingPage()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.teal),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.teal),
            label: 'Countries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.teal),
            label: 'MyBookings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset('images/paris.jpg'),
                Positioned(
                  top: 30,
                  left: 30,
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: searchController,
                      onSubmitted: (text) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          filled: true,
                          fillColor: Colors.grey[50],
                          hintText: "Where are you going?",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.teal),
                    ),
                  ),
                ),
                Positioned(
                  top: 77,
                  left: 38,
                  child: SizedBox(
                    height: 180,
                    width: 280,
                    child: FutureBuilder(
                        future: searchTrips(searchController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasData) {
                            return ListView.separated(
                                // scrollDirection: Axi,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.location_on,
                                        color: Colors.teal,
                                      ),
                                      tileColor: Colors.grey[100],
                                      title: Text(
                                        snapshot.data[index]['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 0,
                                    ),
                                itemCount: snapshot.data.length);
                          }
                          return const SizedBox(
                            height: 0,
                            width: 0,
                          );
                        }),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 16, bottom: 16),
              child: Text(
                'Popular Countries',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            FutureBuilder(
              future: getCountry(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CountryModel> countries = snapshot.data!;
                  return ListView.builder(
                    itemCount: countries.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CountryPage(
                                    countryModel: countries[i],
                                  )));
                        },
                        child: CountryCard(countryModel: countries[i]),
                      );
                    },
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
          ],
        ),
      ),
    );
  }
}
