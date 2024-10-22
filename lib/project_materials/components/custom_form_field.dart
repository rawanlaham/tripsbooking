import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.fieldEntry,
    required this.myController,
    //this.onChanged,
  });

  final String fieldEntry;
  final TextEditingController myController;
  //final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SizedBox(
            width: 55,
            child: Text(
              fieldEntry,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 300,
            child: TextFormField(
              //controller: myController,
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
              //onChanged: onChanged,
              //onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
