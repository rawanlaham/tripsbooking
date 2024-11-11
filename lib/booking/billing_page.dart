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

  BillingPage({super.key, this.bookingModel, this.billingModel});

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

  Future<void> sendBillingData() async {
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
        });
        setState(() {
          isLoading = false;
        });

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactPage(
                  bookingModel: widget.bookingModel,
                )));
      } catch (e, h) {
        print("sendBillingData Error: $e + $h");
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
                    ),
                    CustomFormField(
                      fieldEntry: "Last Name",
                      myController: billingLastName,
                    ),
                    CustomFormField(
                      fieldEntry: "Email",
                      myController: billingEmail,
                    ),
                    CustomFormField(
                      fieldEntry: "Phone Number",
                      myController: billingPhoneNumber,
                    ),
                    CustomFormField(
                      fieldEntry: "Address",
                      myController: billingAddress,
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
                      await sendBillingData();
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
