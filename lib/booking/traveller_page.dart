import 'package:flutter/material.dart';
import 'package:project1v5/project_materials/components/custom_form_field.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/booking_model.dart';

class TravellerPage extends StatefulWidget {
  final int? totalPrice;
  final BookingModel? bookingModel;
  const TravellerPage({super.key, this.bookingModel, this.totalPrice});

  @override
  State<TravellerPage> createState() => _TravellerPageState();
}

class _TravellerPageState extends State<TravellerPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud crud = Crud();

  TextEditingController travellerFirstName = TextEditingController();
  TextEditingController travellerLastName = TextEditingController();
  TextEditingController travellerAge = TextEditingController();
  TextEditingController travellerPhoneNumber = TextEditingController();

  bool isLoading = false;

  Future<void> sendTravellerData() async {
    if (formstate.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        var response = await crud
            .postRequest("$linkAddContactData/${widget.bookingModel!.id}", {
          "first_name": travellerFirstName.text,
          "last_name": travellerLastName.text,
          "age": travellerAge.text,
          "phone_number": travellerPhoneNumber.text,
        });

        setState(() {
          isLoading = false;
        });
      } catch (e, h) {
        print("sendTravellerData Error: $e + $h");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travellers Details"),
        backgroundColor: Colors.teal[50],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pleaes enter travellers details',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              itemCount: 3, //widget.bookingModel!.totalNumber,
              itemBuilder: (context, snapshot) {
                return Container(
                  color: Colors.grey[200],
                  child: Form(
                    key: formstate,
                    child: ListView(
                      children: [
                        CustomFormField(
                          fieldEntry: "First Name",
                          myController: travellerFirstName,
                          // valid: (val) {
                          //   return validInput(val, min, max);
                          // },
                        ),
                        CustomFormField(
                          fieldEntry: "Last Name",
                          myController: travellerLastName,
                          // valid: (val) {
                          //   return validInput(val, min, max);
                          // },
                        ),
                        CustomFormField(
                          fieldEntry: "Phone Number",
                          myController: travellerPhoneNumber,
                          // valid: (val) {
                          //   return validInput(val, min, max);
                          // },
                        ),
                        CustomFormField(
                          fieldEntry: "Age",
                          myController: travellerAge,
                          // valid: (val) {
                          //   return validInput(val, min, max);
                          // },
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                    await sendTravellerData();
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
