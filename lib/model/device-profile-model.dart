class DeviceProfileModel {
  String? name;
  String? email;
  String? phone;
  late String latitude;
  late String longitude;

  DeviceProfileModel({
    this.name,
    this.email,
    this.phone,
    required this.latitude,
    required this.longitude,
  });

  DeviceProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? json['name'] : '';
    email = json['email'] != null ? json['email'] : '';
    phone = json['phone'] != null ? json['phone'] : '';
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name ?? '',
      'email': email ?? '',
      'phone': phone ?? '',
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
