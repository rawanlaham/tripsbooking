import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/components/login_field.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/valid.dart';

class LoginPage extends StatefulWidget {
  // final UserModel? userModel;
  const LoginPage({
    super.key,
    // this.userModel
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formstate = GlobalKey(); //

  Crud _crud = Crud();
  bool isLoading = false;

  TextEditingController email = TextEditingController(); //
  TextEditingController password = TextEditingController(); //

  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      try {
        var response = await _crud.postRequest(linkLogin, {
          "email": email.text,
          "password": password.text,
        });
        //isLoading = true;
        isLoading = false;
        setState(() {});
        // widget.userModel!.id = sharedPref.setString("id", response["data"]["id"].toString());
        sharedPref.setString("id", response["data"]["id"].toString());
        sharedPref.setString("username", response["data"]["name"]);
        sharedPref.setString("email", response["data"]["email"]);
        sharedPref.setString("token", response["token"]); //
        Navigator.of(context).pushNamed("home");
      } catch (e, h) {
        isLoading = false;
        setState(() {});
        AwesomeDialog(
                context: context,
                title: 'Warning',
                body: const Text(
                    'Email address or password is invalid, or the account is not existing.'))
            .show();
        print("Login Error: $e, $h");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
        child: (isLoading == true)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Form(
                    key: formstate,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
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
                            "Login",
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
                            "Login to continue using the app",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        LoginField(
                          fieldEntry: "Email",
                          myController: email,
                          hint: "rawanallaham@hotmail.com",
                          valid: (val) {
                            return validInput(val!, 5, 30);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LoginField(
                            fieldEntry: "Password",
                            isPassword: true,
                            myController: password,
                            hint: "Rawan@123",
                            valid: (val) {
                              return validInput(val!, 5, 30);
                            }),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("signup");
                          },
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "Create new account?",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await login();
                    },
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 70),
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.teal,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
