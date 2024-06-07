import 'package:get/get.dart';

class SettingsController extends GetxController {
  var userName = ''.obs;
  var version = ''.obs;

  void setUserName(String newUserName) {
    userName.value = newUserName;
  }

  void setNewVersion(String newVersion) {
    version.value = newVersion;
  }
}
