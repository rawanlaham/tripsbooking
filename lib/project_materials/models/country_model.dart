class CountryModel {
  late int? id;
  late String? name;
  late String? image;

  CountryModel({this.id, this.name, this.image});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json['original_url'] ?? null;
  }
}
