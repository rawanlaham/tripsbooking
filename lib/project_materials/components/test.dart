import 'package:project1v5/project_materials/constants/linkapi.dart';
import 'package:project1v5/project_materials/crud.dart';
import 'package:project1v5/project_materials/models/trip_model.dart';

class TripService {
  final Crud _crud = Crud();

  Future<OneTripModel?> fetchTripById(String id) async {
    String uri = "$linkViewOneTrip/$id";
    var response = await _crud.getRequest(uri);
    return OneTripModel.fromJson(response["data"]);
  }
  /*
    Future<TripModel?> fetchTripById(String id) async {
    try {
      // بناء الرابط الديناميكي باستخدام الـ id
      String uri = "http://10.0.2.2:8000/api/trip/$id";
      var response = await _crud.getRequest(uri);

      if (response != null && response['data'] != null) {
        // إذا كانت الاستجابة تحتوي على مفتاح 'data' كما في جلب جميع الرحلات
        return TripModel.fromJson(response['data']);
      } else if (response != null) {
        // إذا كانت الاستجابة تحتوي على بيانات الرحلة مباشرة بدون مفتاح 'data'
        return TripModel.fromJson(response);
      } else {
        print("No data found for trip with id: $id");
        return null;
      }
    } catch (e) {
      print("FetchTripById error: $e");
      return null;
    }
  }
  
  */
}

List<dynamic> myList(List<dynamic> trip, OneTripModel tripModel) {
  /*
  for (var i = 0; i < trip.length; i++) {
    if (tripModel.id.compareTo(trip[i]["id"]![0]) == -1) {
      trip.add(AttributesModel.fromJson(json['attributes'][i]));

      return trip;
    }
  }
  */

  trip.add({
    'attributes': [
      tripModel.id,
      tripModel.name,
      tripModel.description,
      tripModel.firstDate,
      tripModel.endDate,
      tripModel.duration,
      tripModel.adultPrice,
      tripModel.childrenPrice,
      tripModel.infantPrice,
      tripModel.avibality,
      tripModel.type
    ]
  });

  return trip;
}
/*
List<dynamic> sortList(List<dynamic> list, SingleMovieModel itemModel) {
  for (int i = 0; i < list.length; i++) {
    if (itemModel.title.compareTo(list[i]['title']![0]) == -1) {
      list.insert(i, {
        'title': [
          itemModel.title,
          itemModel.id,
          itemModel.year,
          itemModel.rating,
          itemModel.image
        ]
      });
      return list;
    }
  }
  list.add({
    'title': [
      itemModel.title,
      itemModel.id,
      itemModel.year,
      itemModel.rating,
      itemModel.image
    ]
  });
  return list;
}
*/