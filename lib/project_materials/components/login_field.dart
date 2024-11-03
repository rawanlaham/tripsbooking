import 'package:flutter/material.dart';

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
