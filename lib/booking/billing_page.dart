import 'package:flutter/material.dart';
import 'package:project1v5/booking/contact_page.dart';
import 'package:project1v5/project_materials/components/custom_form_field.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/billing_model.dart';
import 'package:project1v5/project_materials/models/booking_model.dart';

class BillingPage extends StatefulWidget {
  final BookingModel? bookingModel;
  BillingModel? billingModel;
  // final int bookingId;

  BillingPage(
      {super.key,
      // required this.bookingId,
      this.bookingModel,
      this.billingModel});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController billingFirstName = TextEditingController();
  TextEditingController billingLastName = TextEditingController();
  TextEditingController billingPhoneNumber = TextEditingController();
  TextEditingController billingEmail = TextEditingController();
  TextEditingController billingAddress = TextEditingController();

  bool isLoading = false;
  Crud crud = Crud();

  Future<void> sendBookingData4() async {
    // String? userId = sharedPref.getString("id");
    // String? token = sharedPref.getString("token");
    if (formstate.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await crud
            .postRequest("$linkAddBillingData/${widget.bookingModel!.id}", {
          "first_name": billingFirstName.text,
          "last_name": billingLastName.text,
          "phone_number": billingPhoneNumber.text,
          "email": billingEmail.text,
          "address": billingAddress.text,
          // "booking_id": (widget.bookingModel!.id).toString()
        });
        // print("Response: $response");
        setState(() {
          isLoading = false;
        });

        /*
        widget.billingModel = BillingModel.fromJson(response);
        print("=============================== ${widget.billingModel!.id}");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactPage(
                  billingModel: widget.billingModel,
                )));
        */
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactPage(
                  bookingModel: widget.bookingModel,
                )));
      } catch (e, h) {
        print("sendBookingData Error: $e + $h");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Billing Details"),
        backgroundColor: Colors.teal[50],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Please enter your billing details',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: formstate,
                child: Column(
                  children: [
                    CustomFormField(
                      fieldEntry: "First Name",
                      myController: billingFirstName,
                      // valid: (val) {
                      //   return validInput(val, min, max);
                      // },
                    ),
                    CustomFormField(
                      fieldEntry: "Last Name",
                      myController: billingLastName,
                      // valid: (val) {
                      //   return validInput(val, min, max);
                      // },
                    ),
                    CustomFormField(
                      fieldEntry: "Email",
                      myController: billingEmail,
                    ),
                    CustomFormField(
                      fieldEntry: "Phone Number",
                      myController: billingPhoneNumber,
                      // valid: (val) {
                      //   return validInput(val, min, max);
                      // },
                    ),
                    CustomFormField(
                      fieldEntry: "Address",
                      myController: billingAddress,
                      // valid: (val) {
                      //   return validInput(val, min, max);
                      // },
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
                      overlayColor: Colors.red,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      await sendBookingData4();
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
      ),
    );
  }
}
