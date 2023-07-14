import 'package:flutter/material.dart';
import 'package:klimb_148/model/device-profile-model.dart';

class UpdatedProfiles with ChangeNotifier {
  List<DeviceProfileModel> deviceProfiles = [];

  List<DeviceProfileModel> updateProfiles(
      List<DeviceProfileModel> currentProfile) {
    deviceProfiles = [...deviceProfiles, ...currentProfile];

    notifyListeners();
    return deviceProfiles;
  }
}
