import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';

class NewGetTripsOfCountry {
  Crud crud = Crud();

  Future<dynamic> newGetTripsOfCountry() async {
    try {
      var response = await crud.getRequest(linkViewTripsOfCountry);
      //"id": sharedPref.getString("id"), // to show the owned items
      return response;
    } catch (e) {
      print("GetTripsOfCountry error is: $e");
    }
  }
}


/*
class GetTripsOfCountryFunc extends StatefulWidget {
  const GetTripsOfCountryFunc({super.key});

  @override
  State<GetTripsOfCountryFunc> createState() => _GetTripsOfCountryFuncState();
}

class _GetTripsOfCountryFuncState extends State<GetTripsOfCountryFunc> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
*/