import 'package:flutter/material.dart';
import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/models/country_model.dart';

class CountryCard extends StatelessWidget {
  final void Function()? ontap;
  final CountryModel countryModel;

  const CountryCard({super.key, this.ontap, required this.countryModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 150,
              width: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "$publishedBaseUrl/storage/4/01JCC3NE8462MS1R6518610TP1.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 30,
            child: Text(
              countryModel.name!,
              style: const TextStyle(
                color: Colors.black,
                backgroundColor: Color.fromARGB(255, 237, 235, 235),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
