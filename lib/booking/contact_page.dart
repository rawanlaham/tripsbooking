import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project1v5/project_materials/components/custom_form_field.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/booking_model.dart';

class ContactPage extends StatefulWidget {
  final BookingModel? bookingModel;
  const ContactPage({super.key, this.bookingModel});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud crud = Crud();

  TextEditingController contactFirstName = TextEditingController();
  TextEditingController contactLastName = TextEditingController();
  TextEditingController contactEmail = TextEditingController();
  TextEditingController contactPhoneNumber = TextEditingController();
  TextEditingController contactAddress = TextEditingController();

  bool isLoading = false;

  Future<void> sendContactData() async {
    if (formstate.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        var response = await crud
            .postRequest("$linkAddContactData/${widget.bookingModel!.id}", {
          "first_name": contactFirstName.text,
          "last_name": contactLastName.text,
          "email": contactEmail.text,
          "phone_number": contactPhoneNumber.text,
          "address": contactAddress.text,
        });

        setState(() {
          isLoading = false;
        });

        AwesomeDialog(
                context: context,
                title: 'Success',
                body: const Text('you have successfully booked the trip!'))
            .show();
      } catch (e, h) {
        print("sendContactData Error: $e + $h");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
        backgroundColor: Colors.teal[50],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pleaes enter your contact details',
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
                    myController: contactFirstName,
                  ),
                  CustomFormField(
                    fieldEntry: "Last Name",
                    myController: contactLastName,
                  ),
                  CustomFormField(
                    fieldEntry: "Email",
                    myController: contactEmail,
                  ),
                  CustomFormField(
                    fieldEntry: "Phone Number",
                    myController: contactPhoneNumber,
                  ),
                  CustomFormField(
                    fieldEntry: "Address",
                    myController: contactAddress,
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
                    await sendContactData();
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
