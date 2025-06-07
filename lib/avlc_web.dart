import 'package:avlcweb/src/api_helper.dart';
import 'package:avlcweb/src/avlcweb_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvlcWeb {
  late SharedPreferences preferences;
  late String email, password;
  Function(bool isInitialized, {String? error}) onInitialize;
  final ApiHelper apiHelper = ApiHelper();

  AvlcWeb({
    required this.email,
    required this.password,
    required this.onInitialize,
  }) {
    loginUser();
  }

  Future<String?> getPlatformVersion() {
    return AvlcwebPlatform.instance.getPlatformVersion();
  }

  /// Login user
  /// @param email
  /// @param password
  Future<void> loginUser() async {
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {"email": email, "password": password};
    final result = await apiHelper.loginUser(data);
    if (result != null) {
      if (result['success'] == true) {
        preferences.setString("access_token", result['access_token']);
        preferences.setString("refresh_token", result['refresh_token']);
        onInitialize(true);
      } else if (result['success'] == false) {
        onInitialize(false, error: result['message']);
      }
    }
  }

  /// Send otp
  /// @param data, data should be like this {"email":"adminton@gmail.com"} or {"phone":"+91123456789"}
  /// @param response
  Future<void> sendOtp(Map<String, dynamic> data, Function(dynamic) response) async {
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
  Future<void> verifyOtp(Map<String, dynamic> data, Function(dynamic) response) async {
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
