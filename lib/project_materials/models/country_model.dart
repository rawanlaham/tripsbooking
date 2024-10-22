class CountryModel {
  late int id;
  late String name;

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}
