import 'package:flutter/material.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';

class TripCard extends StatelessWidget {
  final TripModel? tripModel;
  const TripCard({
    super.key,
    this.tripModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                    //tripListDetails[index]['image']!,
                    // "images/malaysia.jpg",
                    "${tripModel!.attributes!.image}"),
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
                            tripModel!.attributes!.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.date_range),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            "${tripModel!.attributes!.duration}",
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
