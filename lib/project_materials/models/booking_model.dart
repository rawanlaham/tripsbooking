class BookingModel {
  int? id;
  int? userId;
  int? tripId;
  int? numAdult;
  int? numChild;
  int? numInfant;
  String? startDate;
  String? endDate;

  BookingModel({
    this.id,
    this.userId,
    this.tripId,
    this.numAdult,
    this.numChild,
    this.numInfant,
    this.startDate,
    this.endDate,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    userId = json["user_id"] ?? 0;
    tripId = json["trip_id"] ?? 0;

    numAdult = int.tryParse(json["adult"] ?? "0") ?? 0;
    numChild = int.tryParse(json["children"] ?? "0") ?? 0;
    numInfant = int.tryParse(json["infant"] ?? "0") ?? 0;

    startDate = json["start_date"] ?? "";
    endDate = json["end_date"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['trip_id'] = tripId;
    data['adult'] = numAdult.toString();
    data['children'] = numChild.toString();
    data['infant'] = numInfant.toString();
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}



// TripModel.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     attributes = AttributesModel.fromJson(json['attributes']);

//   BookingModel(
//       {this.id,
//       this.userId,
//       this.tripId,
//       this.numAdult,
//       this.numChild,
//       this.numInfant,
//       this.startDate,
//       this.endDate});

//   factory BookingModel.fromJson(Map<String, dynamic> json) {
//     return BookingModel(
//         id: json['id'] ?? 0,
//         userId: json['user_id'] ?? 0,
//         tripId: json['trip_id'] ?? 0,
//         numAdult: json['adult'] ?? 0,
//         numChild: json['children'] ?? 0,
//         numInfant: json['infant'] ?? 0,
//         startDate: json['start_date'] as String? ?? "",
//         endDate: json['end_date'] as String? ?? "");
//   }
// }
