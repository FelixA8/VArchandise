import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//GET HISTORY
Future getUserHistory(String userID) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/AllUserHistory'),
      headers: {"Accept": "Application/json"}, body: {'userID': userID});
  var decodedData = jsonDecode(response.body);
  print(decodedData);
  var dateTime =
      DateFormat('yyyy-MM-ddThh:mm:ss').parse(decodedData[0]["DatePurchased"]);
  print(dateTime);
  return decodedData;
}

DateTime decomposeDate(String date) {
  var newDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(date);
  return newDate;
}
