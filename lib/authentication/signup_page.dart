import 'package:flutter/material.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/components/login_field.dart';
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
        sharedPref.setString("token", response["access_token"]);
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
                        Center(
                          child: Image.asset(
                            "images/handsHoldingMobile.jpg",
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
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
                        LoginField(
                          fieldEntry: "Full Name",
                          myController: username,
                          hint: "Rawan Allaham",
                          valid: (val) {
                            return validInput(val!, 6, 20);
                          },
                        ),
                        LoginField(
                          fieldEntry: "Email",
                          myController: email,
                          hint: "rawanallaham@hotmail.com",
                          valid: (val) {
                            return validInput(val!, 15, 40);
                          },
                        ),
                        LoginField(
                          fieldEntry: "Password",
                          isPassword: true,
                          myController: password,
                          hint: "Rawan@12",
                          valid: (val) {
                            return validInput(val!, 6, 20);
                          },
                        ),
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
