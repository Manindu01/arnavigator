import 'package:login_signup_ui/services/storage_service.dart';

class UserService {
  static const String _userKey = 'auth_user';

  // Save complete user payload returned by backend
  static Future<void> saveUserData(Map<String, dynamic> data) async {
    await StorageService.setJson(_userKey, data);
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final data = await StorageService.getJson(_userKey);
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return null;
  }

  static Future<String?> getRole() async {
    final user = await getUserData();
    final role = user?['userRoles'];
    return role?.toString();
  }

  static Future<bool> isLoggedIn() async {
    return (await getUserData()) != null;
  }

  static Future<void> logout() async {
    await StorageService.remove(_userKey);
  }
}
