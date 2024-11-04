import 'package:flutter/material.dart';
import 'package:project1v5/booking/booking_page.dart';
import 'package:project1v5/project_materials/components/trip_info.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';

class TripPage extends StatefulWidget {
  TripModel tripModel;

  TripPage({
    super.key,
    required this.tripModel,
  });

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  Crud crud = Crud();
  bool isLoading = false;
  bool imageLoading = false;

  Future<dynamic> getTripsDetails() async {
    late final imageResponse;
    try {
      var response =
          await crud.getRequest("$linkViewOneTrip/${widget.tripModel.id}");
      //"id": sharedPref.getString("id"), // to show the owned items
      widget.tripModel = TripModel.fromJson(response['data'][0]);
      // setState(() {
      //   imageLoading = true;
      // });

      try {
        imageResponse =
            await crud.getRequest("$linkViewTripImages/${widget.tripModel.id}");
        print(imageResponse);
        //   setState(() {
        //     imageLoading = false;
        //   });
        widget.tripModel.attributes!.image =
            imageResponse['741e30c3-2e1c-4c5f-a4d0-d05fa0268192']
                ['original_url'];
        // widget.tripModel.attributes!.image =
        //     'https://i.ibb.co/JzkrC0j/ab-samra.png';
      } catch (e) {
        print("getTripImages Error is:        $e");
      }
    } catch (e) {
      print("getTripsForOneCountry Error is:        $e");
    }
    return imageResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //title: Text(widget.countryName)),
            ),
        body: FutureBuilder(
            future: getTripsDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(
                    'the image url: ---------- ${widget.tripModel.attributes?.image}');
                return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TripInfo(
                                description: "Trip Name",
                                info: widget.tripModel.attributes!.name,
                              ),
                              TripInfo(
                                description: "Description",
                                info: widget.tripModel.attributes!.description,
                              ),
                              TripInfo(
                                description: "Start Date",
                                info: widget.tripModel.attributes!.firstDate,
                              ),
                              TripInfo(
                                description: "End Date",
                                info: widget.tripModel.attributes!.endDate,
                              ),
                              TripInfo(
                                description: "Duration",
                                info:
                                    "${widget.tripModel.attributes!.duration} days",
                              ),
                              TripInfo(
                                description: "Adult Price",
                                info:
                                    "${widget.tripModel.attributes!.adultPrice} \$",
                              ),
                              TripInfo(
                                description: "Children Price",
                                info:
                                    "${widget.tripModel.attributes!.childrenPrice} \$",
                              ),
                              TripInfo(
                                description: "Infant Price",
                                info:
                                    "${widget.tripModel.attributes!.infantPrice} \$",
                              ),
                              TripInfo(
                                description: "Avaiability",
                                info:
                                    "${widget.tripModel.attributes!.avibality}",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // (imageLoading == true)
                        //     ? const Center(child: CircularProgressIndicator())
                        //     :

                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken,
                              ),
                              child: Image.network(
                                "${widget.tripModel.attributes!.image}",
                                //'https://bsmedia.business-standard.com/_media/bs/img/article/2023-04/17/full/1681718797-2692.jpg',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),

                        /*
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(left: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                width: 250,
                                height: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.darken,
                                    ),
                                    child: Image.network(
                                      'https://bsmedia.business-standard.com/_media/bs/img/article/2023-04/17/full/1681718797-2692.jpg',
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        */
                        const SizedBox(height: 20),
                        const Text(
                          "Features",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView.builder(
                            itemCount: widget.tripModel.features!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Text(widget.tripModel.features![i].name),
                                leading: const Icon(Icons.check),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Day Plans",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView.builder(
                            itemCount: widget.tripModel.dayPlans!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return ListTile(
                                title:
                                    Text(widget.tripModel.dayPlans![i].dayPlan),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Price include:",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView.builder(
                            itemCount: widget.tripModel.advantages!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return ListTile(
                                leading: const Icon(Icons.check_box),
                                title: Text(widget
                                    .tripModel.advantages![i].priceInclud),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Price exclude:",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView.builder(
                            itemCount: widget.tripModel.advantages!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return ListTile(
                                leading:
                                    const Icon(Icons.indeterminate_check_box),
                                title: Text(widget
                                    .tripModel.advantages![i].priceUninclud),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: MaterialButton(
                              height: 50,
                              color: Colors.redAccent[700],
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => BookingPage(
                                          tripModel: widget.tripModel,
                                        ))));
                              },
                              child: const Text(
                                "Book Trip",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            }));
  }
}
