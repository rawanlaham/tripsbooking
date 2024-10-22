class BillingModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? address;

  BillingModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.address,
  });

  factory BillingModel.fromJson(Map<String, dynamic> json) {
    return BillingModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      email: json['email'] ?? "",
      address: json['address'] ?? "",
    );
  }
}
