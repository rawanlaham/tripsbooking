import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project1v5/main.dart';

class Crud {
  getRequest(String uri) async {
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  postRequest(String uri, Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 2));
    // print('token:   ${sharedPref.getString("token")} ');
    // print('data: ------------------- $data');
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: data,
        headers: {
          'Authorization': 'Bearer ${sharedPref.getString("token")}',
          // 'Accept': 'application/json',
          //"Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
        // return response;
      } else if (response.statusCode == 302) {
        print("Response StatusCode302 Error:      ${response.statusCode}");
      } else {
        print("Response StatusCode Error:      ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }
}
/*
import 'dart:convert';

import 'package:http/http.dart' as http;

class Crud {
  getRequest(String uri) async {
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error catch $e');
    }
  }

  postRequest(String uri, Map data) async {
    try {
      var response = await http.post(Uri.parse(uri), body: data);
      if (response.statusCode == response) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error catch $e');
    }
  }
}
*/
  
