class AllTripModel {
  late String id;
  late AttributesModel attributes;

  AllTripModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    attributes = AttributesModel.fromJson(json['attributes']);
  }
}

class AttributesModel {
  late String name;
  late String description;
  late String firstDate;
  late String endDate;
  late int duration;
  late int adultPrice;
  late int childrenPrice;
  late int infantPrice;
  late String type;
  late int avibality;

  AttributesModel({
    required this.name,
    required this.description,
    required this.firstDate,
    required this.endDate,
    required this.duration,
    required this.adultPrice,
    required this.childrenPrice,
    required this.infantPrice,
    required this.type,
    required this.avibality,
  });

  AttributesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    firstDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    duration = json['duration'] ?? 0;
    adultPrice = json['adult_price'] ?? 0;
    childrenPrice = json['children_price'] ?? 0;
    infantPrice = json['infant_price'] ?? 0;
    type = json['type'] ?? "";
    avibality = json['avibality'] ?? 0;
  }
}
