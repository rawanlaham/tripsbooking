import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project1v5/countries/all_countries.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/components/age_drop_down.dart';
import 'package:project1v5/project_materials/components/custom_form_field.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/billing_model.dart';
import 'package:project1v5/project_materials/models/booking_model.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';

class BookingPage extends StatefulWidget {
  final TripModel tripModel;
  BookingModel? bookingModel;
  final BillingModel? billingModel;
  BookingPage(
      {super.key,
      required this.tripModel,
      this.bookingModel,
      this.billingModel});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  GlobalKey<FormState> formstate2 = GlobalKey();

  TextEditingController billingFirstName = TextEditingController();
  TextEditingController billingLastName = TextEditingController();
  TextEditingController billingPhoneNumber = TextEditingController();
  TextEditingController billingEmail = TextEditingController();
  TextEditingController billingAddress = TextEditingController();

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

  Future<void> sendBookingData3() async {
    String userId = sharedPref.getString("id")!;
    String? token = sharedPref.getString("token");

    if (formstate.currentState!.validate()) {
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
        // print("Response status: ${response.toString()}");
        // print("Response body: ${response.statusCode}");

        setState(() {
          isLoading = false;
        });

        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => BillingPage()));
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AllCountries()));

        /*
        edited code
        BookingModel booking = BookingModel(
          userId: int.parse(userId),
          tripId: int.parse(widget.tripModel.id!),
          numAdult: numAdults,
          numChild: numChildren,
          numInfant: numInfants,
          startDate: widget.tripModel.attributes!.firstDate,
          endDate: widget.tripModel.attributes!.endDate,
        );
        Map<String, dynamic> bookingData = booking.toJson();

        var response = await crud.postRequest(
            "$linkBookTrips/${widget.tripModel.id}", bookingData);

        setState(() {
          isLoading = false;
        });

        // استخدام booking_id من الاستجابة إذا كان موجودًا
        int bookingId = response['id'];

        // الانتقال إلى صفحة الفوترة BillingPage مع تمرير bookingId
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BillingPage(bookingId: bookingId)),
        );
        */
      } catch (e, h) {
        print("sendBookingData3 Error: $e, $h");
      }
    }

    /*
    if (formstate2.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
      var response = await crud.postRequest("$linkAddBillingData/${widget.bookingModel!.id}", {
        "first_name": widget.billingModel?.firstName,
            "last_name": widget.billingModel?.lastName,
            "phone_number": widget.billingModel?.phoneNumber,
            "email": widget.billingModel?.email,
            "address": widget.billingModel?.address,
            "booking_id": widget.bookingModel?.id
      });
      setState(() {
          isLoading = false;
      });
    } catch (e) {
      print("sendBillingData Error: $e");
    }
    }
    */
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
            Form(
              key: formstate,
              child: CustomFormField(
                  fieldEntry: "fieldEntry", myController: billingFirstName),
            ),
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
                    //padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    await sendBookingData3();
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


/*import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project1v5/booking/billing_page.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/booking_model.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';
import 'package:project1v5/trip/trippagetest.dart';

class BookingPage extends StatefulWidget {
  final TripModel tripModel;
  final BookingModel? bookingModel;

  const BookingPage({super.key, required this.tripModel, this.bookingModel});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  // GlobalKey<FormState> formstate2 = GlobalKey();
  GlobalKey<FormState> formstate3 = GlobalKey();
  Crud crud = Crud();

  // TextEditingController trvFirstName = TextEditingController();
  // TextEditingController trvLastName = TextEditingController();
  // TextEditingController trvAge = TextEditingController();
  // TextEditingController trvPhoneNumber = TextEditingController();

  // TextEditingController contactFirstName = TextEditingController();
  // TextEditingController contactLastName = TextEditingController();
  // TextEditingController contactEmail = TextEditingController();
  // TextEditingController contactPhoneNumber = TextEditingController();
  // TextEditingController contactCountry = TextEditingController();
  // TextEditingController contactAddress = TextEditingController();

  TextEditingController billingFirstName = TextEditingController();
  TextEditingController billingLastName = TextEditingController();
  TextEditingController billingPhoneNumber = TextEditingController();
  TextEditingController billingEmail = TextEditingController();
  //TextEditingController billingCountry = TextEditingController();
  TextEditingController billingAddress = TextEditingController();

  int numAdults = 0;
  int numChildren = 0;
  int numInfants = 0;

  int get totalPrice {
    return (numAdults * (widget.tripModel.attributes.adultPrice)) +
        (numChildren * (widget.tripModel.attributes.childrenPrice)) +
        (numInfants * (widget.tripModel.attributes.infantPrice));
  }

  int get availableNumbers => widget.tripModel.attributes.avibality;

  int get totalNumbers {
    return (numAdults + numChildren + numInfants);
  }

  bool isLoading = false;

  sendBookingData() async {
    if (formstate.currentState!.validate()) {
      String? userId = sharedPref.getString("id");
      String? token = sharedPref.getString("token"); //

      if (userId == null || token == null) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'خطأ',
          desc: 'لم يتم تسجيل الدخول. الرجاء تسجيل الدخول أولاً.',
          btnOkOnPress: () {},
        ).show();
        return;
      }

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

      //
      setState(() {
        isLoading = true;
      });
      try {
        var response = await crud.postRequest(
          "$linkBookTrips/${widget.tripModel.id}",
          {
            "user_id": userId, //sharedPref.getString("user_id"),
            "trip_id": widget.tripModel.id.toString(),
            "adult": numAdults.toString(),
            "children": numChildren.toString(),
            "infant": numInfants.toString(),
            "start_date": widget.tripModel.attributes.firstDate,
            "end_date": widget.tripModel.attributes.endDate,
          },
        );

        //isLoading = false;
        setState(() {
          isLoading = false;
        });

        if (response['status'] == 'success') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BillingPage()));
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: 'خطأ',
            desc: 'فشل في إرسال بيانات الحجز. حاول مجدداً.',
            btnOkOnPress: () {},
          ).show();
        }
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Trippagetest()));
      } catch (e) {
        print("sendBookingData Error: $e");
      }
    }
  }

  /*
  sendContactData() async {
    if (formstate2.currentState!.validate()) {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = sharedPref.getString("id");
      String? token = sharedPref.getString("token"); //

      if (userId == null || token == null) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'خطأ',
          desc: 'لم يتم تسجيل الدخول. الرجاء تسجيل الدخول أولاً.',
          btnOkOnPress: () {},
        ).show();
        return;
      }

      //
      setState(() {
        isLoading = true;
      });
      try {
        var response = await crud.postRequest(
          "$linkBookTrips/${widget.tripModel.id}",
          {
            "user_id": userId, //sharedPref.getString("user_id"),
            "trip_id": widget.tripModel.id.toString(),
            "adult": numAdults.toString(),
            "children": numChildren.toString(),
            "infant": numInfants.toString(),
            "start_date": widget.tripModel.attributes.firstDate,
            "end_date": widget.tripModel.attributes.endDate,
          },
        );

        //isLoading = false;
        setState(() {
          isLoading = false;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Trippagetest()));
      } catch (e) {
        print("sendBookingData Error: $e");
      }
    }
  }
  */

  sendBillingData() async {
    if (formstate3.currentState!.validate()) {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = sharedPref.getString("id");
      String? token = sharedPref.getString("token"); //

      if (userId == null || token == null) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'خطأ',
          desc: 'لم يتم تسجيل الدخول. الرجاء تسجيل الدخول أولاً.',
          btnOkOnPress: () {},
        ).show();
        return;
      }

      //
      setState(() {
        isLoading = true;
      });
      try {
        var response = await crud.postRequest(
          "$linkAddBillingData/${widget.bookingModel!.id!}", //
          {
            "booking_id": widget.bookingModel!.id!,
            "first_name": billingFirstName.text,
            "last_name": billingLastName.text,
            "phone_number": billingPhoneNumber.text,
            "email": billingEmail.text,
            "address": billingAddress.text,
          },
        );

        //isLoading = false;
        setState(() {
          isLoading = false;
        });
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Trippagetest()));
        if (response['status'] == 'success') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Trippagetest()));
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: 'خطأ',
            desc: 'فشل في إرسال بيانات الفوترة. حاول مجدداً.',
            btnOkOnPress: () {},
          ).show();
        }
      } catch (e) {
        print("sendBookingData Error: $e");
      }
    }
  }

  // List<TextEditingController> participantControllers =
  //     []; // قائمة لتخزين Controllers لكل مشارك

  // @override
  // void initState() {
  //   super.initState();
  //   // ملء القائمة بالـ Controllers بناءً على عدد المشاركين
  //   for (int i = 0; i < totalNumbers; i++) {
  //     participantControllers.add(TextEditingController());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: ,
    //   builder: (context, snapshot) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Trip"),
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "_________________________________________________________",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            /*
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Travellers Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            */
            /*
            ListView.builder(
                shrinkWrap: true, // يسمح لـ ListView بأن يأخذ الحجم الصحيح
                physics: NeverScrollableScrollPhysics(), // يمنع التمرير
                itemCount: totalNumbers,
                itemBuilder: (contex, i) {
                  Form(
                    key: formstate,
                    child: Column(
                      children: [
                        CustomFormField(
                          fieldEntry: "First Name Participant ${i + 1}",
                          myController: participantControllers[i],
                        ),
                        CustomFormField(
                          fieldEntry: "Last Name Participant ${i + 1}",
                          myController: participantControllers[i],
                        ),
                        CustomFormField(
                          fieldEntry: "Age",
                          myController: trvAge,
                        ),
                        CustomFormField(
                          fieldEntry: "Age Participant ${i + 1}",
                          myController: participantControllers[i],
                        ),
                      ],
                    ),
                  );
                }),
            */
            /*
            Form(
              key: formstate,
              child: Column(
                children: [
                  CustomFormField(
                    fieldEntry: "First Name",
                    myController: trvFirstName,
                  ),
                  CustomFormField(
                    fieldEntry: "Last Name",
                    myController: trvLastName,
                  ),
                  CustomFormField(
                    fieldEntry: "Age",
                    myController: trvAge,
                  ),
                  CustomFormField(
                    fieldEntry: "Phone Number",
                    myController: trvPhoneNumber,
                  ),
                ],
              ),
            ),
            */
            /*
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "_________________________________________________________",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Contact Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: formstate2,
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
                    fieldEntry: "Country",
                    myController: contactCountry,
                  ),
                  CustomFormField(
                    fieldEntry: "Address",
                    myController: contactAddress,
                  ),
                ],
              ),
            ),
            */
            /*
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "_________________________________________________________",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Billing Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: formstate3,
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
            */
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shadowColor: Colors.black,
                    overlayColor: Colors.red,
                    minimumSize: const Size(200, 50),
                    //padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //elevation: 2,
                  ),
                  //height: 50,
                  //color: Colors.redAccent[700],
                  onPressed: () async {
                    await sendBookingData();
                    // await sendBillingData();
                    // bool bookingSuccess = await sendBookingData();
                    // if (bookingSuccess) {
                    //   bool billingSuccess = await sendBillingData();
                    //   if (billingSuccess) {
                    //     // كل شيء نجح
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => Trippagetest()));
                    //   }
                    // }
                    /*
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => BookingPage(
                                  tripModel: widget.tripModel,
                                  //bookingModel: widget.bookingModel,
                                ))));
                        */
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
    //   }
    // );
  }
}
*/


/*
  Future<void> sendBookingData2() async {
    // print("bookingModel: ${widget.bookingModel}");
    // print("billingModel: ${widget.billingModel}");
    String? userId = sharedPref.getString("id");
    String? token = sharedPref.getString("token");
    // if (formstate.currentState!.validate()) {
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
    setState(() {
      isLoading = true;
    });

    try {
      var response = await crud.postRequest(
        "$linkBookTrips/${widget.tripModel.id}",
        {
          "user_id": userId, //
          "trip_id": widget.tripModel.id.toString(), //
          "adult": numAdults.toString(), //
          "children": numChildren.toString(), //
          "infant": numInfants.toString(), //
          "start_date": widget.tripModel.attributes!.firstDate, //
          "end_date": widget.tripModel.attributes!.endDate, //

          //"id": widget.bookingModel!.id
        },
        // headers: {
        //   'Authorization': 'Bearer $token'
        // }
      );
      print("response: $response");
      print("Sending request to: $linkBookTrips/${widget.tripModel.id}");

      setState(() {
        isLoading = false;
      });

      // print("Response: $response");
      // BookingModel bookingModel = BookingModel(
      //   id: response['data']['id'], // استخدم البيانات القادمة من الـ API
      //   // يمكنك إضافة المزيد من الحقول هنا إذا لزم الأمر
      // );

      // print("Before navigating: bookingModel: ${widget.bookingModel}");
      // print("Before navigating: billingModel: ${widget.billingModel}");
      BookingModel bookingModel = BookingModel(
        id: response['id'],
        // أضف المزيد من الحقول إذا لزم الأمر
      );
      print("Before navigating: bookingModel: $bookingModel");

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              //  BillingPage(
              //       billingModel: widget.billingModel,
              //       bookingModel: bookingModel,
              //     )
              Trippagetest()));
    } catch (e) {
      print("sendBookingData1 Error: $e");
    }
    // }

    /*
    if (formstate2.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      // print("${widget.bookingModel?.id}");

      try {
        var response = await crud
            .postRequest("$linkAddBillingData/${widget.bookingModel?.id}", {
          "first_name": widget.billingModel?.firstName,
          "last_name": widget.billingModel?.lastName,
          "phone_number": widget.billingModel?.phoneNumber,
          "email": widget.billingModel?.email,
          "address": widget.billingModel?.address,
          "booking_id": widget.bookingModel?.id
        });

        BillingModel billingModel = BillingModel(
          id: response['id'],
          // أضف المزيد من الحقول إذا لزم الأمر
        );
        print("Before navigating: billingModel: $billingModel");

        setState(() {
          isLoading = false;
        });

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Trippagetest2()));
      } catch (e) {
        print("sendBookingData2 Error: $e");
      }
    }
    */
  }

*/