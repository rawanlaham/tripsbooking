import 'package:flutter/material.dart';
import 'package:project1v5/countries/country_page.dart';
import 'package:project1v5/project_materials/models/country_model.dart';

class CountryCard extends StatelessWidget {
  final void Function()? ontap;
  final CountryModel countryModel;

  ///
  const CountryCard({super.key, this.ontap, required this.countryModel});

  ///

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      //CountryPage(countryName: countryModel.name)
                      CountryPage()));

              ///
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 150,
                width: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "images/milan.webp",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 30,
            child: Text(
              countryModel.name,

              ///
              //"$countryName",
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
