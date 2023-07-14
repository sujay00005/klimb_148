import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klimb_148/util/constants/color-constant.dart';

import '../model/device-profile-model.dart';
import '../util/db-helper.dart';
import 'add-location.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  var validateMode = AutovalidateMode.disabled;
  List<DeviceProfileModel> searchList = [];

  bool showSearchList = false;

  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _formKey.currentState?.save();
  }

  validate() {
    validateMode = AutovalidateMode.onUserInteraction;
  }

  Future<List<DeviceProfileModel>> fetchDeviceProfiles() async {
    final data = await DBHelper.getAllData('profiles');
    final List<DeviceProfileModel> dataList = data.map((item) {
      print('🎇🎇🎇');
      print(item);
      // List<Map<String,dynamic>>
      return DeviceProfileModel(
          name: item['name'],
          email: item['email'],
          phone: item['phone'],
          fontSize: item['fontSize'],
          color: item['color'],
          longitude: item['longitude'],
          latitude: item['latitude']);
    }).toList();

    print("🎃🎃🎃");
    print(dataList[0].name);
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    List<DeviceProfileModel> profiles = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Device Profiles',
          // style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorConstant.primaryGreen,
        centerTitle: true,
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.primaryGreen,
        elevation: 10,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddLocation(
              allProfiles: profiles,
              onAddingData: (List<DeviceProfileModel> newProfiles) {
                setState(() {
                  profiles = newProfiles;
                });
              },
            );
          }));
        },
        child: const Icon(Icons.add, size: 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: fetchDeviceProfiles(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                profiles = snapshot.data;
                print("🎪🎪 $profiles");
                return ListView.builder(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        !showSearchList ? profiles.length : searchList.length,
                    itemBuilder: (context, index) {
                      print("🧶🧶🧶🧶");
                      return ProfileContainers(
                          listName: !showSearchList ? profiles : searchList,
                          index: index);
                    });
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('No data Present'),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class ProfileContainers extends StatelessWidget {
  const ProfileContainers({
    super.key,
    required this.listName,
    required this.index,
  });

  final List<DeviceProfileModel> listName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        color: ColorConstant.secondaryGreen,
        height: 150,
        child: Column(
          children: [
            Text("Name: ${listName[index].name}"),
            listName[index].color == null
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Theme Color: "),
                      const SizedBox(width: 15),
                      CircleAvatar(
                        backgroundColor:
                            Color(int.parse(listName[index].color ?? '0'))
                                .withOpacity(1),
                        //{profiles[index].color},
                        radius: 15,
                      )
                    ],
                  ),
            // Text("Email: ${profiles[index].email}"),
            // Text("Phone: ${profiles[index].phone}"),
            Text("Font Size: ${listName[index].fontSize}"),

            Text("Longitude: ${listName[index].longitude}"),
            Text("Latitude: ${listName[index].latitude}"),
          ],
        ));
  }
}

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  build(BuildContext context) async {
    print("🕳🕳🕳🕳 Came here too");
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Unique Lat & Long'),
        content: const Text('Add new device profile'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
