import 'package:flutter/material.dart';
import 'package:project1v5/countries/all_countries.dart';
import 'package:project1v5/home_page.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({super.key});

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  Crud crud = Crud();
  int currentIndex = 0;
  final List<Widget> pages = [
    HomePage(),
    AllCountries(),
    MyBookingPage(),
  ];

  Future<dynamic> getMyBookingData() async {
    try {
      var response =
          await crud.getRequest(linkMyBookingData, printResponse: true);
      if (response != null) {
        print("linkMyBookingData =      $linkMyBookingData");
        print('My Booking Data: $response');
        return response;
      } else {
        print("No booking data found or error occurred.");
      }
    } catch (e) {
      print("getMyBookingData Error:      $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
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
      body: FutureBuilder(
          future: getMyBookingData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List bookings = snapshot.data;
              return ListView.separated(
                  itemCount: bookings.length,
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                        height: 30,
                        thickness: 0.4,
                      ),
                  itemBuilder: (context, index) {
                    var booking = bookings[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          title: Text(
                            booking["trip"]["name"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Type: ${booking["trip"]["type"]}\n"
                              "Booking ID: ${booking["booking_id"]}\n"
                              "Date: ${booking["created_at"]}"),
                          leading: const Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 20,
                          ),
                          trailing: const Icon(Icons.airplanemode_active,
                              color: Colors.teal)),
                    );
                  });
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            return const Center(
              child: Text("No bookings found."),
            );
          }),
    );
  }
}
