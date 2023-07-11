class DeviceProfileModel {
  String? name;
  String? email;
  String? phone;
  String? fontSize;
  String? color;
  late String latitude;
  late String longitude;

  DeviceProfileModel({
    this.name,
    this.email,
    this.phone,
    this.fontSize,
    this.color,
    required this.latitude,
    required this.longitude,
  });

  DeviceProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? json['name'] : '';
    email = json['email'] != null ? json['email'] : '';
    phone = json['phone'] != null ? json['phone'] : '';
    fontSize = json['fontSize'] != null ? json['fontSize'] : '';
    color = json['color'] != null ? json['color'] : '';
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name ?? '',
      'email': email ?? '',
      'phone': phone ?? '',
      'fontSize': fontSize ?? '',
      'color': color ?? '',
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
