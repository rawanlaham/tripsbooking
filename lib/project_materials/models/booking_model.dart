class BookingModel {
  int? id;
  int? userId;
  int? tripId;
  int? numAdult;
  int? numChild;
  int? numInfant;
  String? startDate;
  String? endDate;
  // int? totalNumber;

  BookingModel({
    this.id,
    this.userId,
    this.tripId,
    this.numAdult,
    this.numChild,
    this.numInfant,
    this.startDate,
    this.endDate,
    // this.totalNumber,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    tripId = json["trip_id"];

    numAdult = int.parse(json["adult"]);
    numChild = int.parse(json["children"]);
    numInfant = int.parse(json["infant"]);

    startDate = json["start_date"];
    endDate = json["end_date"];
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

  // int get totalNumber {
  //   return (numAdult ?? 0) + (numChild ?? 0) + (numInfant ?? 0);
  // }

  @override
  String toString() {
    return '{id: $id, start_date: $startDate, end_date: $endDate}';
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
