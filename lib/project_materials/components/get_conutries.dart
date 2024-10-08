import 'package:flutter/material.dart';
import 'package:project1v5/countries/country_page.dart';

class GetCountries extends StatelessWidget {
  final void Function()? ontap;
  final String? countryName;
  const GetCountries({super.key, this.ontap, this.countryName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CountryPage(countryName: countryName!)));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 150,
                width: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "images/milan.webp",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 30,
              child: Text(
                "$countryName",
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
      ),
    );
  }
}
