class BookingModel {
  final int? id;
  final int? userId;
  final int? tripId;
  final int? numAdult;
  final int? numChild;
  final int? numInfant;
  final String? startDate;
  final String? endDate;

  BookingModel(
      {this.id,
      this.userId,
      this.tripId,
      this.numAdult,
      this.numChild,
      this.numInfant,
      this.startDate,
      this.endDate});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? 0,
        tripId: json['trip_id'] ?? 0,
        numAdult: json['adult'] ?? 0,
        numChild: json['children'] ?? 0,
        numInfant: json['infant'] ?? 0,
        startDate: json['start_date'] as String? ?? "",
        endDate: json['end_date'] as String? ?? ""
      );
  }
}
