class TripModel {
  late String? id;
  late AttributesModel? attributes;
  late List<FeatureModel>? features;
  late List<DayPlanModel>? dayPlans;
  late List<AdvantageModel>? advantages;

  TripModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    attributes = AttributesModel.fromJson(json['attributes']);

    if (json['features'] != null) {
      features = (json['features'] as List)
          .map((item) => FeatureModel.fromJson(item))
          .toList();
    } else {
      features = [];
    }

    if (json['day_plans'] != null) {
      dayPlans = (json['day_plans'] as List)
          .map((item) => DayPlanModel.fromJson(item))
          .toList();
    } else {
      dayPlans = [];
    }

    if (json['advantages'] != null) {
      advantages = (json['advantages'] as List)
          .map((item) => AdvantageModel.fromJson(item))
          .toList();
    } else {
      advantages = [];
    }
    // features =
    //     json['features']?.map((e) => FeatureModel.fromJson(e)).toList() ?? [];
    // dayPlans =
    //     json['day_plans']?.map((e) => DayPlanModel.fromJson(e)).toList() ?? [];
    // advantages =
    //     json['advantages']?.map((e) => AdvantageModel.fromJson(e)).toList() ??
    //         [];
  }
}

// Model for attributes
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

// Model for features
class FeatureModel {
  late String id;
  late String name;

  FeatureModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}

// Model for day plans
class DayPlanModel {
  late String id;
  late String dayPlan;

  DayPlanModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    dayPlan = json["day_plan"];
  }
}

// Model for advantages
class AdvantageModel {
  late String id;
  late String priceInclud;
  late String priceUninclud;

  AdvantageModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    priceInclud = json["price_includ"];
    priceUninclud = json["price_uninclude"];
  }
}

/*class TripModel {
  late String? id;
  late AttributesModel? attributes;
  late List<FeatureModel>? features;
  late List<DayPlanModel>? dayPlans;
  late List<AdvantageModel>? advantages;

  TripModel.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    attributes = json['attributes'] != null
        ? AttributesModel.fromJson(json['attributes'])
        : null; // التحقق من وجود attributes

    features = json['features'] != null
        ? (json['features'] as List)
            .map((item) => FeatureModel.fromJson(item))
            .toList()
        : [];

    dayPlans = json['day_plans'] != null
        ? (json['day_plans'] as List)
            .map((item) => DayPlanModel.fromJson(item))
            .toList()
        : [];

    advantages = json['advantages'] != null
        ? (json['advantages'] as List)
            .map((item) => AdvantageModel.fromJson(item))
            .toList()
        : [];

    // features =
    //     json['features']?.map((e) => FeatureModel.fromJson(e)).toList() ?? [];
    // dayPlans =
    //     json['day_plans']?.map((e) => DayPlanModel.fromJson(e)).toList() ?? [];
    // advantages =
    //     json['advantages']?.map((e) => AdvantageModel.fromJson(e)).toList() ??
    //         [];
  }
}

// Model for attributes
class AttributesModel {
  String name;
  String description;
  String firstDate;
  String endDate;
  int duration;
  int adultPrice;
  int childrenPrice;
  int infantPrice;
  String type;
  int avibality;

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

  AttributesModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        description = json['description'] ?? "",
        firstDate = json['start_date'] ?? "",
        endDate = json['end_date'] ?? "",
        duration = json['duration'] ?? 0,
        adultPrice = json['adult_price'] ?? 0,
        childrenPrice = json['children_price'] ?? 0,
        infantPrice = json['infant_price'] ?? 0,
        type = json['type'] ?? "",
        avibality = json['avibality'] ?? 0;
}

// Model for features
class FeatureModel {
  late String id;
  late String name;

  FeatureModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}

// Model for day plans
class DayPlanModel {
  late String id;
  late String dayPlan;

  DayPlanModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    dayPlan = json["day_plan"];
  }
}

// Model for advantages
class AdvantageModel {
  late String id;
  late String priceInclud;
  late String priceUninclud;

  AdvantageModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    priceInclud = json["price_includ"];
    priceUninclud = json["price_uninclude"];
  }
}
*/

class OneTripModel {
  final int id;
  final String name;
  final String description;
  final int adultPrice;
  final int childrenPrice;
  final int infantPrice;
  final String type;
  final String date;
  final String firstDate;
  final String endDate;
  final int avibality;
  //final int destinationId;
  final int duration;
  //final String createdAt;
  //final String updatedAt;

  OneTripModel({
    required this.id,
    required this.name,
    required this.description,
    required this.adultPrice,
    required this.childrenPrice,
    required this.infantPrice,
    required this.type,
    required this.date,
    required this.firstDate,
    required this.endDate,
    required this.avibality,
    //this.destinationId,
    required this.duration,
    // this.createdAt,
    // this.updatedAt
  });

  factory OneTripModel.fromJson(Map<String, dynamic> json) {
    return OneTripModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      adultPrice: json["adult_price"],
      childrenPrice: json["children_price"],
      infantPrice: json["infant_price"],
      type: json["type"],
      date: json["date"],
      firstDate: json["first_date"],
      endDate: json["end_date"],
      avibality: json["avibality"],
      //destinationId: json["destination_id"],
      duration: json["duration"],
      //createdAt: json["created_at"],
      //updatedAt: json["updated_at"]
    );
  }
}
