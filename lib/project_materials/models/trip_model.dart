class TripModel {
  late String id;
  late AttributesModel attributes;

  TripModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    attributes = AttributesModel.fromJson(json['attributes']);
  }
}

class AttributesModel {
  late String name;
  late String description;
  late String startDate;
  late String endDate;
  late int duration;
  late double adultPrice;
  late double childrenPrice;
  late double infantPrice;
  late String type;
  late int availability;

  AttributesModel({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.adultPrice,
    required this.childrenPrice,
    required this.infantPrice,
    required this.type,
    required this.availability,
  });

  AttributesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration = json['duration'];
    adultPrice = json['adultPrice'];
    childrenPrice = json['childrenPrice'];
    infantPrice = json['infantPrice'];
    type = json['type'];
    availability = json['availability'];
  }
}
