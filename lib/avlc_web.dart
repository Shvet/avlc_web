import 'dart:developer';

import 'package:avlcweb/src/api_helper.dart';
import 'package:avlcweb/src/avlcweb_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvlcWeb {
  late SharedPreferences preferences;
  late String appId, appSecret;
  late Function(bool isInitialized, {String? error}) onInitialize;
  final ApiHelper apiHelper = ApiHelper();

  void initialize({
    required String appId,
    required String appSecret,
    required Function(bool isInitialized, {String? error}) onInitialize,
  }) {
    this.appId = appId;
    this.appSecret = appSecret;
    this.onInitialize = onInitialize;
    _loginUser();
  }

  Future<String?> getPlatformVersion() {
    return AvlcwebPlatform.instance.getPlatformVersion();
  }

  /// Login user
  /// @param email
  /// @param password
  Future<void> _loginUser() async {
    log("Login User");
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {"app_id": appId, "app_secret": appSecret};
    final result = await apiHelper.loginUser(data);
    if (result != null) {
      if (result['status'] == 200) {
        preferences.setString("access_token", result['access_token']);
        preferences.setString("refresh_token", result['refresh_token']);
        onInitialize(true);
      } else if (result['status'] == 400) {
        onInitialize(false, error: result['message']);
      }
    }
  }

  /// Send otp
  /// @param data, data should be like this {"email":"adminton@gmail.com"} or {"phone":"+91123456789"}
  /// @param response
  Future<void> sendOtp(
    Map<String, dynamic> data,
    Function(dynamic) response,
  ) async {
    final result = await apiHelper.sendOtp(data);
    if (result != null) {
      if (result['success'] == true) {
        response(result);
      } else if (result['success'] == false) {
        response(result);
      }
    }
  }

  /// verify otp
  /// @param data, data should be like this {"email":"adminton@gmail.com","otp":"123456"} or {"phone":"+91123456789","otp":"123456"}
  /// @param response
  Future<void> verifyOtp(
      Map<String, dynamic> data, Function(dynamic) response) async {
    final result = await apiHelper.sendOtp(data);
    if (result != null) {
      if (result['success'] == true) {
        response(result);
      } else if (result['success'] == false) {
        response(result);
      }
    }
  }
}
