
import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static Future saveUser(String name,
      String phone,
      String avatar,) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    await prefs.setString("phone", phone);
    await prefs.setString("avatar", avatar);
  }

  static Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "name": prefs.getString("name") ?? "",
      "phone": prefs.getString("phone") ?? "",
      "avatar" : prefs.getString("avatar") ?? "" ,

    };
  }
}
