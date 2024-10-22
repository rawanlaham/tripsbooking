import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project1v5/main.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/valid.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formstate = GlobalKey();

  Crud _crud = Crud();
  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
        sharedPref.setString("id", response["data"]["id"].toString());
        sharedPref.setString("username", response["data"]["name"]);
        sharedPref.setString("email", response["data"]["email"]);
        sharedPref.setString("token", response["token"]); //
        Navigator.of(context).pushNamed("home");
      } catch (e) {
        isLoading = false;
        setState(() {
          // تعيينه إلى false عند حدوث خطأ
        });
        AwesomeDialog(
                context: context,
                title: 'Warning',
                body: const Text(
                    'Email address or password is invalid, or the account is not existing.'))
            .show();
        print("Login Error: $e");
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
                          valid: (val) {
                            return validInput(val!, 5, 30);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LoginField(
                            fieldEntry: "Password",
                            myController: password,
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

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.fieldEntry,
    required this.myController,
    required this.valid,
  });

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


/*
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project1v3/authentication/get_otp.dart';
import 'package:project1v3/authentication/signup_page.dart';
import 'package:project1v3/main.dart';
import 'package:project1v3/project_materials/constants/linkapi.dart';
import 'package:project1v3/project_materials/crud.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formState = GlobalKey(); //

  TextEditingController email = TextEditingController(); //
  TextEditingController password = TextEditingController(); //

  Crud crud = Crud(); //

  bool isLoading = false;

  //
  login() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(
          linkLogIn, {"email": email.text, "password": password.text});
      isLoading = false;
      setState(() {});
      if (response["status"] == 'success') {
        sharedPref.setString('id', response['data']['id']).toString();
        sharedPref.setString('email', response['data']['email']);
        sharedPref.setString('password', response['data']['password']);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => GetOtpPage()));
      } else {
        AwesomeDialog(
            context: context,
            title: 'Warning',
            body: const Text(
                'Email address or password is invalid, or the account is not existing.'))
          ..show();
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
        child: isLoading == true //
            ? Center(
                child: CircularProgressIndicator(),
              ) //
            : ListView(
                children: [
                  Form(
                    key: formState,
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
                          myController: email,
                          fieldEntry: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LoginField(
                          myController: password,
                          fieldEntry: 'Password',
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUpPage()));
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.teal,
                    onPressed: () async {
                      await login();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.fieldEntry,
    required this.myController,
  });

  final String fieldEntry;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: myController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
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
*/