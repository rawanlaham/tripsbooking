import 'package:flutter/material.dart';
import 'package:project1v5/booking/booking_page.dart';
import 'package:project1v5/project_materials/components/trip_info.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';

class TripPage extends StatefulWidget {
  final TripModel tripModel;

  const TripPage({
    super.key,
    required this.tripModel,
  });

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  @override
  Widget build(BuildContext context) {
    final String id = widget.tripModel.id!;
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
        appBar: AppBar(
            //title: Text(widget.countryName)),
            ),
        body: SingleChildScrollView(
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
                        info: "${widget.tripModel.attributes!.duration} days",
                      ),
                      TripInfo(
                        description: "Adult Price",
                        info: "${widget.tripModel.attributes!.adultPrice} \$",
                      ),
                      TripInfo(
                        description: "Children Price",
                        info:
                            "${widget.tripModel.attributes!.childrenPrice} \$",
                      ),
                      TripInfo(
                        description: "Infant Price",
                        info: "${widget.tripModel.attributes!.infantPrice} \$",
                      ),
                      TripInfo(
                        /// need work
                        description: "Avaiability",
                        info: "${widget.tripModel.attributes!.avibality}",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Features",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                        title: Text(widget.tripModel.dayPlans![i].dayPlan),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Price include:",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                        title:
                            Text(widget.tripModel.advantages![i].priceInclud),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Price exclude:",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                        leading: const Icon(Icons.indeterminate_check_box),
                        title:
                            Text(widget.tripModel.advantages![i].priceUninclud),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                /*
                SizedBox(
                  height: 170,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      TripImages(),
                      const SizedBox(
                        height: 170,
                        width: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                */
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
            )));
  }
}
