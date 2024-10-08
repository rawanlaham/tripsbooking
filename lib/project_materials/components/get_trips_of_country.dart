import 'package:flutter/material.dart';
import 'package:project1v5/trip/trip_page.dart';

class GetTripsOfCountry extends StatelessWidget {
  final String tripId;
  final String? tripDescription;
  final int? tripDuration;
  const GetTripsOfCountry(
      {super.key,
      this.tripDescription,
      this.tripDuration,
      required this.tripId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TripPage(tripId: tripId!)));
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  //tripListDetails[index]['image']!,
                  "images/malaysia.jpg",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            //tripListDetails[index]['Description']!,
                            "$tripDescription", // the location of the trip
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.alarm),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            //tripListDetails[index]['Days number']!,
                            "$tripDuration",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
