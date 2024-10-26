import 'package:flutter/material.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/components/custom_form_field.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';

class BillingPage extends StatefulWidget {
  // final BookingModel? bookingModel;
  // final BillingModel? billingModel;
  // final int bookingId;

  const BillingPage({
    super.key,
    // required this.bookingId,
    // this.bookingModel,
    // this.billingModel
  });

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  GlobalKey<FormState> formstate2 = GlobalKey();

  TextEditingController billingFirstName = TextEditingController();
  TextEditingController billingLastName = TextEditingController();
  TextEditingController billingPhoneNumber = TextEditingController();
  TextEditingController billingEmail = TextEditingController();
  TextEditingController billingAddress = TextEditingController();

  bool isLoading = false;
  Crud crud = Crud();

  sendBookingData4() async {
    String? userId = sharedPref.getString("id");
    String? token = sharedPref.getString("token");
    if (formstate2.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        String? bookingId = sharedPref.getString("booking_id");
        // print("Retrieved booking_id: $bookingId");
        // print(
        //     "linkAddBillingData/bookingId:       $linkAddBillingData/$bookingId");
        // print("bookingId:        $bookingId");
        print("First Name: ${billingFirstName.text}");
        try {
          var response =
              await crud.postRequest("$linkAddBillingData/$bookingId", {
            "first_name": billingFirstName.text,
            "last_name": billingLastName.text,
            "phone_number": billingPhoneNumber.text,
            "email": billingEmail.text,
            "address": billingAddress.text,
            "booking_id": bookingId
          });
          // print("Response status: ${response.statusCode}");
          // print("Response body: ${response.body}");
        } catch (e) {
          print("responseError:      $e");
        }
        // print("$linkAddBillingData/${widget.bookingModel?.id}");
        // print("response:      $response");
        setState(() {
          isLoading = false;
        });

        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Trippagetest2()));
      } catch (e, h) {
        print("sendBookingData2 Error: $e + $h");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Billing Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: formstate2,
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
    );
  }
}



// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:project1v5/booking/booking_page.dart';
// import 'package:project1v5/main.dart';
// import 'package:project1v5/project_materials/constants/linkapi.dart';
// import 'package:project1v5/project_materials/crud.dart';
// import 'package:project1v5/project_materials/models/booking_model.dart';
// import 'package:project1v5/project_materials/models/trip_model.dart';
// import 'package:project1v5/trip/trippagetest.dart';

// class BillingPage extends StatefulWidget {
//   final TripModel? tripModel;
//   final BookingModel? bookingModel;

//   const BillingPage({super.key, this.tripModel, this.bookingModel});

//   @override
//   State<BillingPage> createState() => _BillingPageState();
// }

// class _BillingPageState extends State<BillingPage> {
//   GlobalKey<FormState> formstate3 = GlobalKey();
//   bool isLoading = false;
//   TextEditingController billingFirstName = TextEditingController();
//   TextEditingController billingLastName = TextEditingController();
//   TextEditingController billingPhoneNumber = TextEditingController();
//   TextEditingController billingEmail = TextEditingController();
//   //TextEditingController billingCountry = TextEditingController();
//   TextEditingController billingAddress = TextEditingController();

//   Crud crud = Crud();

//   sendBillingData() async {
//     if (formstate3.currentState!.validate()) {
//       //SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? userId = sharedPref.getString("id");
//       String? token = sharedPref.getString("token"); //

//       if (userId == null || token == null) {
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.error,
//           title: 'خطأ',
//           desc: 'لم يتم تسجيل الدخول. الرجاء تسجيل الدخول أولاً.',
//           btnOkOnPress: () {},
//         ).show();
//         return;
//       }

//       //
//       setState(() {
//         isLoading = true;
//       });
//       try {
//         var response = await crud.postRequest(
//           "$linkAddBillingData/${widget.bookingModel!.id!}", //
//           {
//             "booking_id": widget.bookingModel!.id!,
//             "first_name": billingFirstName.text,
//             "last_name": billingLastName.text,
//             "phone_number": billingPhoneNumber.text,
//             "email": billingEmail.text,
//             "address": billingAddress.text,
//           },
//         );

//         //isLoading = false;
//         setState(() {
//           isLoading = false;
//         });
//         // Navigator.of(context)
//         //     .push(MaterialPageRoute(builder: (context) => Trippagetest()));
//         if (response['status'] == 'success') {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => Trippagetest()));
//         } else {
//           AwesomeDialog(
//             context: context,
//             dialogType: DialogType.error,
//             title: 'خطأ',
//             desc: 'فشل في إرسال بيانات الفوترة. حاول مجدداً.',
//             btnOkOnPress: () {},
//           ).show();
//         }
//       } catch (e) {
//         print("sendBookingData Error: $e");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Billing Page"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'Billing Details',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Form(
//               key: formstate3,
//               child: Column(
//                 children: [
//                   CustomFormField(
//                     fieldEntry: "First Name",
//                     myController: billingFirstName,
//                   ),
//                   CustomFormField(
//                     fieldEntry: "Last Name",
//                     myController: billingLastName,
//                   ),
//                   CustomFormField(
//                     fieldEntry: "Email",
//                     myController: billingEmail,
//                   ),
//                   CustomFormField(
//                     fieldEntry: "Phone Number",
//                     myController: billingPhoneNumber,
//                   ),
//                   CustomFormField(
//                     fieldEntry: "Address",
//                     myController: billingAddress,
//                   ),
//                 ],
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 16, bottom: 8),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     shadowColor: Colors.black,
//                     overlayColor: Colors.red,
//                     minimumSize: const Size(200, 50),
//                     //padding: EdgeInsets.symmetric(horizontal: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     //elevation: 2,
//                   ),
//                   //height: 50,
//                   //color: Colors.redAccent[700],
//                   onPressed: () async {
//                     // await sendBookingData();
//                     // await sendBillingData();
//                     // bool bookingSuccess = await sendBookingData();
//                     // if (bookingSuccess) {
//                     //   bool billingSuccess = await sendBillingData();
//                     //   if (billingSuccess) {
//                     //     // كل شيء نجح
//                     //     Navigator.of(context).push(MaterialPageRoute(
//                     //         builder: (context) => Trippagetest()));
//                     //   }
//                     // }
//                     /*
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: ((context) => BookingPage(
//                                   tripModel: widget.tripModel,
//                                   //bookingModel: widget.bookingModel,
//                                 ))));
//                         */
//                   },
//                   child: const Text(
//                     "Submit",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
