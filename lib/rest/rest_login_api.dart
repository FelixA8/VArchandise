import 'dart:convert';

import 'package:http/http.dart' as http;

//LOGIN USER
Future userLogin(String email, String password) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/login'),
      headers: {"Accept": "Application/json"},
      body: {'email': email, 'password': password});
  var decodedData = jsonDecode(response.body);

  return decodedData;
}

//GET USER HIGHEST ID
Future getUserID() async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.get(
    Uri.parse('$baseUrl/users/getUserHighestID'),
    headers: {"Accept": "Application/json"},
  );
  var decodedData = jsonDecode(response.body.toString());
  print(decodedData);
  return decodedData;
}

//GET HIGHEST ID NUMBER
int extractAndIncrement(String input) {
  RegExp regex = RegExp(r'\d+');
  Match match = regex.firstMatch(input) as Match;
  String? numbersOnly = match.group(0);

  int currentNumber = int.parse(numbersOnly!);
  int incrementedNumber = currentNumber + 1;

  return incrementedNumber;
}

//REGISTER USER
Future userRegister(
    String username, String address, String email, String password) async {
  String baseUrl = "http://10.0.2.2:3000";
  var data = await getUserID();
  var newID = data[0]["CustomerID"];
  int inputID = extractAndIncrement(newID);
  var id = 'CU${inputID.toString().padLeft(3, '0')}';
  //LAST CHECKPOINT
  final response = await http.post(Uri.parse('$baseUrl/users/register'), body: {
    'name': username,
    'email': email,
    'id': id,
    'password': password,
    'address': address
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}
