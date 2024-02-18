import 'package:brighter_nepal/values/values.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void launchPhoneApp(String url) async {
  Uri phoneNumber = Uri.parse(url);
  if (await canLaunchUrl(phoneNumber)) {
    await launchUrl(phoneNumber);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

handle_selection_initial(String name, int id) async {
  String todo = "";
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (id == 0) {
    todo = "bridge_course";
  } else if (id == 1) {
    todo = "ctevt";
  } else if (id == 2) {
    todo = "class11";
  } else if (id == 3) {
    todo = "class12";
  } else {
    todo = "see";
  }
  prefs.setString(MyValues.SELECTION, todo);
  return 1;
}
