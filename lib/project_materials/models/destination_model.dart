class DestinationModel {
  final int? id;
  final String? name;
  final int? countryId;
  final int? latitude;
  final int? longitude;

  DestinationModel({
    this.id,
    this.name,
    this.countryId,
    this.latitude,
    this.longitude,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json["id"],
      name: json["name"],
      countryId: json["country_id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}
