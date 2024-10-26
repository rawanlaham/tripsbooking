import 'package:flutter/material.dart';
import 'package:project1v5/home_page.dart';
import 'package:project1v5/project_materials/components/conutry_card.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/country_model.dart';

class AllCountries extends StatefulWidget {
  AllCountries({super.key});

  @override
  State<AllCountries> createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  Crud crud = Crud();
  int currentIndex = 0;
  final List<Widget> pages = [HomePage(), AllCountries()];

  Future<List<CountryModel>> getCountry() async {
    try {
      var response = await crud.getRequest(linkViewCountry);
      List<dynamic> data = response['data'];
      List<CountryModel> countries =
          data.map((item) => CountryModel.fromJson(item)).toList();
      return countries;
    } catch (e) {
      print("GetAllCountries error is: $e");
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries"),
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
              Navigator.of(context).pushReplacement(
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
            icon: Icon(
              Icons.map,
              color: Colors.teal,
            ),
            label: 'Countries',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        return CountryCard(
                          countryModel: countries[i],
                        );
                      });
                }

                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
