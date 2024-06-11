import 'package:get/get.dart';

class SettingsController extends GetxController {
  var userName = ''.obs;
  var version = ''.obs;
  var buildName = ''.obs;
  var buildNumber = 0.obs;

  void setUserName(String newUserName) {
    userName.value = newUserName;
  }

  void setNewVersion(
      String newVersion, String newBuildName, int newBuildNumber) {
    version.value = newVersion;
    buildName.value = newBuildName;
    buildNumber.value = newBuildNumber;
  }
}
