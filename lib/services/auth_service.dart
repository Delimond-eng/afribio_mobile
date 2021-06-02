import 'dart:convert';

import 'package:afribio/models/user_model.dart';
import 'package:afribio/models/user_register_model.dart';
import 'package:afribio/services/http_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Authenticate extends HttpService {
  //Customer authenticate
  static Future<UserLogin> loginCustomer(
      {url, String email, String pwd}) async {
    final response = await http.post(
      Uri.parse('${HttpService.url}/acquereurs/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'pass': pwd,
      }),
    );
    if (response.statusCode == 200) {
      return UserLogin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('your post isn\'t sending');
    }
  }

  static Future<UserRegister> registerCustomer(
      {String fullname, String email, String phone, String pwd}) async {
    print('${HttpService.url}/acquereurs/registeraccount');
    final response = await http.post(
      Uri.parse('${HttpService.url}/acquereurs/registeraccount'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nom_complet': fullname,
        'email': email,
        'telephone': phone,
        'pass': pwd,
      }),
    );
    final json = jsonDecode(response.body);
    if(json["error"] != null || json["error"] !=""){
      EasyLoading.showInfo(json["error"]);
      return null;
    }
    if (response.statusCode == 200) {
      return UserRegister.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('your post isn\'t sending');
    }
  }

  static Future verifyUser({userId, code}) async {
    final response = await http.post(
      Uri.parse('${HttpService.url}/acquereurs/verification'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'acheteur_id': userId,
        'code': code,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('your post isn\'t sending');
    }
  }
}
