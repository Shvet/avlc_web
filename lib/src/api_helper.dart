import 'dart:convert';
import 'dart:developer';

import 'package:avlcweb/src/constant.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  Future<dynamic> loginUser(Map<String, dynamic> data) async {
    try {
      final result = await post(Uri.parse("${baseUrl}user-login"),
          body: json.encode(data));
      if (result.statusCode == 200) {
        return json.decode(result.body);
      } else if (result.statusCode == 400) {
        return json.decode(result.body);
      } else if (result.statusCode == 401) {
        return json.decode(result.body);
      } else {
        return {
          "success": false,
          "message": "Something went wrong",
          "status": result.statusCode
        };
      }
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "status": 400
      };
    }
  }

  Future<dynamic> sendOtp(Map<String, dynamic> data) async {
    try {
      log("AVLCWeb: Sending OTP....");
      final preference = await SharedPreferences.getInstance();

      final result = await post(
        Uri.parse("${baseUrl}send-otp"),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${preference.getString("access_token")}"
        },
      );
      if (result.statusCode == 200) {
        log("AVLCWeb: Sending OTP Success");
        return json.decode(result.body);
      } else if (result.statusCode == 400) {
        log("AVLCWeb: Sending OTP Failed");
        return json.decode(result.body);
      } else if (result.statusCode == 401) {
        log("AVLCWeb: Sending OTP Failed");
        return json.decode(result.body);
      } else {
        log("AVLCWeb: Sending OTP Failed");
        return {
          "success": false,
          "message": "Something went wrong",
          "status": result.statusCode
        };
      }
    } catch (e) {
      log("AVLCWeb: $e");
      return {
        "success": false,
        "message": "Something went wrong",
        "status": 400
      };
    }
  }

  Future<dynamic> verifyOtp(Map<String, dynamic> data) async {
    try {
      log("AVLCWeb: Verifying OTP...");
      final preference = await SharedPreferences.getInstance();

      final result = await post(
        Uri.parse("${baseUrl}verify-otp"),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${preference.getString('access_token')}"
        },
      );
      if (result.statusCode == 200) {
        log("AVLCWeb: Sending OTP Success");
        return json.decode(result.body);
      } else if (result.statusCode == 400) {
        log("AVLCWeb: Sending OTP Failed");
        return json.decode(result.body);
      } else if (result.statusCode == 401) {
        log("AVLCWeb: Sending OTP Failed");
        return json.decode(result.body);
      } else {
        log("AVLCWeb: Sending OTP Failed");
        return {
          "success": false,
          "message": "Something went wrong",
          "status": result.statusCode
        };
      }
    } catch (e) {
      log("AVLCWeb: $e");
      return {
        "success": false,
        "message": "Something went wrong",
        "status": 400
      };
    }
  }
}
