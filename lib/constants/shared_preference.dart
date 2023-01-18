import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

initSharedPreferences() async {
  prefs = await SharedPreferences.getInstance();
}
