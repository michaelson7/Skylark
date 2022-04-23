import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylark/model/core/UsersModel.dart';

import '../view/constants/enum.dart';
import '../view/widgets/loggerWidget.dart';

class SharedPreferenceProvider {
  addUserData(UsersModel model) async {
    try {
      var userId = getEnumValue(UserDetails.userId);
      var userName = getEnumValue(UserDetails.userName);
      var userEmail = getEnumValue(UserDetails.userEmail);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(userName, model.names);
      prefs.setString(userEmail, model.email);
      prefs.setString(userId, model.id.toString());
    } catch (e) {
      loggerError(message: "Error on sharedPreferences: $e");
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userVal = prefs.containsKey(getEnumValue(UserDetails.userId));
    return userVal;
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<String?> getStringValue(String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? spItem = prefs.getString(value);
      return spItem;
    } catch (e) {
      loggerError(message: 'Error on sharedPreferences [getStringValue]: $e');
    }
  }

  Future<int> getIntValue(String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? spItem = prefs.getInt(value);
      if (spItem != null) {
        return spItem;
      } else {
        return 1;
      }
    } catch (e) {
      loggerError(message: 'Error on sharedPreferences [getStringValue]: $e');
      throw Exception('Error on sharedPreferences [getStringValue]: $e');
    }
  }

  //remove
  removeValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(value);
  }
}
