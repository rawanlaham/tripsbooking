class TravellerModel {
  final int? id;
  final String? firstname;
  final String? lastname;
  final int? age;
  final String? phoneNumber;

  TravellerModel(
      {this.id, this.firstname, this.lastname, this.age, this.phoneNumber});

  factory TravellerModel.fromJson(Map<String, dynamic> json) {
    return TravellerModel(
        id: json['id'],
        firstname: json['first_name'] as String?,
        lastname: json['last_name'] as String?,
        age: json['age'],
        phoneNumber: json['phone_number'] as String?);
  }
}
