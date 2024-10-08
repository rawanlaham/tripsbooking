import 'package:flutter/material.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/components/get_conutries.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Crud crud = Crud();

  getCountry() async {
    try {
      var response = await crud.getRequest(linkViewCountry);
      //"id": sharedPref.getString("id"), // to show the owned items
      return response;
    } catch (e) {
      print("GetCountry error is: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("Login Page", (route) => false);
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      
      */

      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context).pushNamed("login");
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Countries',
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
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
                  ),
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
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: (snapshot.data as Map<String, dynamic>)["data"]
                          .length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return GetCountries(
                          ontap: () {},
                          countryName: (snapshot.data
                              as Map<String, dynamic>)["data"][i]["name"],
                          /*countryName:
                              "${(snapshot.data as List<dynamic>)[i]["name"]}",*/
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
                future: getCountry(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//////

/*

class CountryList extends StatelessWidget {
  const CountryList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8),
        scrollDirection: Axis.horizontal,
        itemCount: countriesTrips.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CountryPage(index: index)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 150,
                  width: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      countriesTrips[index]['Image']!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 30,
                child: Text(
                  countriesTrips[index]['Country']!,
                  style: const TextStyle(
                      color: Colors.black,
                      backgroundColor: Color.fromARGB(255, 237, 235, 235),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FamousTripsCardList extends StatelessWidget {
  FamousTripsCardList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1070,
      child: ListView.builder(
        itemCount: tripListDetails.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TripPage(
                          index: index,
                        )));
              },
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          tripListDetails[index]['image']!,
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      tripListDetails[index]['Description']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.alarm),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      tripListDetails[index]['Days number']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.date_range),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      tripListDetails[index]['Start Date']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/
//////////



/*
class bottomNavigation extends StatefulWidget {
  const bottomNavigation({super.key});

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> body = [
    HomePage(),
    const ListofHotels(),
    const LoginPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Countries',
          ),
        ],
      ),
      body: HomePage(),
    );
  }
}


*/
