import 'package:flutter/material.dart';
import 'package:project1v5/project_materials/crud.dart';

class TripPage extends StatefulWidget {
  final String tripId;
  const TripPage({super.key, required this.tripId});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  Crud crud = Crud();
  getTripsOfCountry() async {
    try {
      var response = await crud.getRequest("http://10.0.2.2:8000/api/trip/5");
      // "id": sharedPref.getString("id"), to show the owned items
      return response;
    } catch (e) {
      print("GetTripsOfCountry error is: $e");
    }
  } //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Trips"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile"),
        ],
      ),
      appBar: AppBar(),
      //title: Text(widget.countryName)),
      body: FutureBuilder(
        future: getTripsOfCountry(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var tripAttributes =
                (snapshot.data as Map<String, dynamic>)["data"]["attributes"];
            return ListView(
              children: [
                ListTile(
                  title: const Text("Description"),
                  subtitle:
                      Text(tripAttributes["description"] ?? "No description"),
                ),
                ListTile(
                  title: const Text("Duration"),
                  subtitle: Text(tripAttributes["duration"].toString()),
                ),
                // أضف هنا المزيد من التفاصيل الخاصة بالرحلة مثل السعر، الموقع، إلخ
              ],
            );

            //List trips = (snapshot.data as Map<String, dynamic>)["data"];
            /*
            var selectedTrip = trips.firstWhere(
                (trip) => trip["id"] == selectedTripId,
                orElse: () => null);
            */
            /*
            return ListView.builder(
              itemCount: trips.length,
              //itemCount: (snapshot.data as Map<String, dynamic>).length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                //return Text((snapshot.data as Map<String, dynamic>)["data"][i]["attributes"]);
                
                /*return ListTile(
                  title: Text(tripAttributes['name'] ?? "No name"),
                  subtitle:
                      Text(tripAttributes['description'] ?? "No description"),
                );
                */

                /*
                TripInfo(
                  description: "Name",
                  info: (snapshot.data as Map<String, dynamic>)["data"][0]
                      ["attributes"]["name"],
                );
                */
              },
            );
            */

            /*
            return ListView.builder(
                itemCount: (snapshot.data as Map<String, dynamic>).length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return const TripInfo(
                    description: "${tripInfo[i]}",
                    info: "info",
                  );
                });
            */

            /*  
                    children: [
                      TripInfo(
                        description: 'description',
                        info: "eeee"
                      //"${(snapshot.data as Map<String, dynamic>)["data"]["attributes"]["description"]}",
                      ),
                    ],
                    */

            /*
            return ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  padding: const EdgeInsets.all(16),
                  height: 270,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView(
                    children: [
                      TripInfo(
                        description: "description11",
                        info: (snapshot.data as Map<String, dynamic>)["data"][""] ,
                      ),
                    ],
                  ),
                ),
              ],
            );
            */
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
