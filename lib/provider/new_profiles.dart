import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:klimb_148/model/device-profile-model.dart';
import '../util/db-helper.dart';

class NewProfiles with ChangeNotifier {
  List<DeviceProfileModel> _items = [];

  List<DeviceProfileModel> get items {
    return [..._items];
  }

  void addProfile(DeviceProfileModel profile) {
    DBHelper.insert('profiles', {
      'name': profile.name ?? '',
      'email': profile.email ?? '',
      'phone': profile.phone ?? '',
      'fontSize': profile.fontSize ?? '',
      'color': profile.color ?? '',
      'longitude': profile.longitude ?? '',
      'latitude': profile.latitude ?? '',
    });

    fetchAndSetProfiles();
    notifyListeners();
    print(_items.length);

    print("🍤🍤 Adding to DB now");
  }

  Future<List<DeviceProfileModel>> fetchAndSetProfiles() async {
    final dataList = await DBHelper.getAllData('profiles');
    print("🥖🥖");

    _items = dataList
        .map((item) => DeviceProfileModel(
              latitude: item['latitude'],
              longitude: item['longitude'],
              name: item['name'],
              email: item['email'],
              phone: item['phone'],
              fontSize: item['fontSize'],
              color: item['color'],
            ))
        .toList();
    print("🥖🥖 ${_items.length}");
    // notifyListeners();

    return _items;
  }
}
