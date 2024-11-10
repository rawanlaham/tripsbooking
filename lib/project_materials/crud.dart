import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project1v5/main.dart';

class Crud {
  /*
  getRequest(String uri, //////worked
      {Map<String, dynamic>? queryParameters,
      bool printResponse = false}) async {
    try {
      if (printResponse) {
        print('url: ------------- $uri');
      }
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (printResponse)
          print('url: $uri \n responseBody ----------------- ${responseBody}');
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }
  */

  getRequest(String uri,
      {Map<String, dynamic>? queryParameters,
      bool printResponse = false}) async {
    final token = sharedPref.getString("token");
    if (token == null) {
      print("No token found. Please try again");
      return null;
    }

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    try {
      if (printResponse) {
        print('url: ------------- $uri');
      }
      var response = await http.get(Uri.parse(uri), headers: headers);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (printResponse)
          print('url: $uri \n responseBody ----------------- ${responseBody}');
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  postRequest(String uri, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    // await Future.delayed(Duration(seconds: 2));
    // print('token:   ${sharedPref.getString("token")} ');
    // print('data: ------------------- $data');
    final defaultHeaders = {
      'Authorization':
          'Bearer 2|yajvcntTfMjqSlcVaQKAQfeg6J3ajeAq2VEdLCcY44c0bf82',
      // 'Accept': 'application/json',
      //"Content-Type": "application/json",
    };
    final allHeaders =
        headers != null ? {...defaultHeaders, ...headers} : defaultHeaders;

    try {
      var response = await http.post(Uri.parse(uri), body: data, headers: {
        'Authorization': 'Bearer ${sharedPref.getString('token')}',
        'Accept': 'application/json',
        //"Content-Type": "application/json",
      });

      print('post response -------------------------------');
      print(response.body);
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

  /*
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
  */
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
  
