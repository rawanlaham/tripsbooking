import 'package:flutter/material.dart';
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
  final List<Widget> pages = [
    HomePage(),
    AllCountries(),
  ];

  Future<List<CountryModel>> getCountry() async {
    try {
      var response = await crud.getRequest(linkViewCountry);
      //"id": sharedPref.getString("id"), // to show the owned items
      List<dynamic> data = response['data'];
      List<CountryModel> countries =
          data.map((item) => CountryModel.fromJson(item)).toList();
      return countries;
    } catch (e) {
      print("GetCountry error is: $e");
    }
    return [];
  }

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
              future: getCountry(),
            ),
          ],
        ),
      ),
    );
  }
}
