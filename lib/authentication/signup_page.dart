import 'package:flutter/material.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/valid.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();

  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    try {
      if (formstate.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await _crud.postRequest(linkSignUp, {
          "name": username.text,
          "email": email.text,
          "password": password.text,
        });
        sharedPref.setString("id", response["data"]["id"].toString());
        sharedPref.setString("username", response["data"]["name"]);
        sharedPref.setString("email", response["data"]["email"]);
        sharedPref.setString("token", response["access_token"]); // تخزين التوكن
        isLoading = false;
        setState(() {});
        Navigator.of(context).pushNamed("home");
      }
    } catch (e) {
      print("Signup Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      backgroundColor: Colors.white,
      body: (isLoading == true)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: ListView(
                children: [
                  Form(
                    key: formstate,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Center(
                            child: Image.asset(
                              "images/handsHoldingMobile.jpg",
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Text(
                            "SignUp",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Text(
                            "Enter your data to register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SignUpField(
                            valid: (val) {
                              return validInput(val!, 6, 20);
                            },
                            myController: username,
                            fieldEntry: 'Full Name',
                            hint: 'Mohammad Ahmad'),
                        SignUpField(
                            valid: (val) {
                              return validInput(val!, 15, 40);
                            },
                            myController: email,
                            fieldEntry: 'Email',
                            hint: 'mohammad_ahmad@gmail.com'),
                        SignUpField(
                            valid: (val) {
                              return validInput(val!, 6, 20);
                            },
                            myController: password,
                            fieldEntry: 'Password',
                            hint: 'mohammad_2001'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.teal,
                      onPressed: () async {
                        await signUp();
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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

class SignUpField extends StatelessWidget {
  const SignUpField(
      {super.key,
      this.hint,
      required this.fieldEntry,
      required this.myController,
      required this.valid});
  final String? hint;
  final String fieldEntry;
  final TextEditingController myController;
  final String? Function(String?) valid;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              validator: valid,
              controller: myController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            left: 25.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              color: Colors.white,
              child: Text(
                fieldEntry,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
