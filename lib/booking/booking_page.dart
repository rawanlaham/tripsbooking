import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project1v5/booking/billing_page.dart';
import 'package:project1v5/project_materials/components/age_drop_down.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/booking_model.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';

class BookingPage extends StatefulWidget {
  final TripModel tripModel;
  BookingModel? bookingModel;
  BookingPage({
    super.key,
    required this.tripModel,
    this.bookingModel,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Crud crud = Crud();

  int numAdults = 0;
  int numChildren = 0;
  int numInfants = 0;

  int get totalPrice {
    return (numAdults * (widget.tripModel.attributes!.adultPrice)) +
        (numChildren * (widget.tripModel.attributes!.childrenPrice)) +
        (numInfants * (widget.tripModel.attributes!.infantPrice));
  }

  int get availableNumbers => widget.tripModel.attributes!.avibality;

  int get totalNumbers {
    return (numAdults + numChildren + numInfants);
  }

  bool isLoading = false;

  Future<void> sendBookingData() async {
    if (totalNumbers > availableNumbers) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: 'Warning',
        desc:
            'The number of participants exceeds the available number of the trip.',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    if (totalNumbers == 0) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: 'Warning',
        desc: 'Please select one participant at least for the trip.',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var response =
          await crud.postRequest("$linkBookTrips/${widget.tripModel.id}", {
        "adult": numAdults.toString(),
        "children": numChildren.toString(),
        "infant": numInfants.toString(),
        "start_date": widget.tripModel.attributes!.firstDate,
        "end_date": widget.tripModel.attributes!.endDate,
        "trip_id": widget.tripModel.id.toString(),
      });

      setState(() {
        isLoading = false;
      });
      widget.bookingModel = BookingModel.fromJson(response);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BillingPage(
                bookingModel: widget.bookingModel,
              )));
    } catch (e, h) {
      print("sendBookingData Error: $e, $h");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Trip"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Number of Participants",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Adult"),
                            const SizedBox(height: 2),
                            AgeDropDown(
                              onChanged: (value) {
                                setState(() {
                                  numAdults = int.parse(value);
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Children"),
                            const SizedBox(height: 2),
                            AgeDropDown(
                              onChanged: (value) {
                                setState(() {
                                  numChildren = int.parse(value);
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Infant"),
                            const SizedBox(height: 2),
                            AgeDropDown(
                              onChanged: (value) {
                                setState(() {
                                  numInfants = int.parse(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "Total Price: ${totalPrice.toStringAsFixed(2)}\$",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shadowColor: Colors.black,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    await sendBookingData();
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
