class UserModel {
  late int? id;
  late String? name;
  late String? email;

  UserModel({this.id, this.name, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
  }
}
