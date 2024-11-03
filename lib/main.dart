import 'package:flutter/material.dart';
import 'package:project1v5/authentication/login_page.dart';
import 'package:project1v5/authentication/signup_page.dart';
import 'package:project1v5/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookingTrips',
      initialRoute: (sharedPref.getString("id") == null) ? "login" : "home",
      // initialRoute: "home",
      routes: {
        "signup": (context) => SignUpPage(),
        "login": (context) => LoginPage(),
        "home": (context) => HomePage(),
      },
    );
  }
}
