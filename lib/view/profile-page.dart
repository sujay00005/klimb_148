import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klimb_148/util/constants/color-constant.dart';
import 'package:provider/provider.dart';

import '../model/device-profile-model.dart';
import '../provider/new_profiles.dart';
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
            );
          }));
        },
        child: const Icon(Icons.add, size: 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: Provider.of<NewProfiles>(context).fetchAndSetProfiles(),
            builder: (context, AsyncSnapshot snapshot) {
              print("🚠🚠");
              // print(snapshot.data[0].name);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                profiles = snapshot.data;
                print("🎪🎪 $profiles");

                return Consumer<NewProfiles>(
                    child: const Text(
                        'Got no device profiles yet. Start adding some'),
                    builder: (context, allDeviceProfiles, chi) {
                      print("🚉🚉🚉");
                      print(allDeviceProfiles.items.length);
                      return allDeviceProfiles.items.isEmpty
                          ? chi!
                          : ListView.builder(
                              itemCount: allDeviceProfiles.items.length,
                              itemBuilder: (context, index) {
                                print("🧶🧶🧶🧶");
                                return Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.all(15),
                                    color: ColorConstant.secondaryGreen,
                                    height: 150,
                                    child: Column(
                                      children: [
                                        Text(
                                            "Name: ${allDeviceProfiles.items[index].name}"),
                                        allDeviceProfiles.items[index].color ==
                                                null
                                            ? const SizedBox()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text("Theme Color: "),
                                                  const SizedBox(width: 15),
                                                  CircleAvatar(
                                                    backgroundColor: Color(
                                                            int.parse(
                                                                allDeviceProfiles
                                                                        .items[
                                                                            index]
                                                                        .color ??
                                                                    '0'))
                                                        .withOpacity(1),
                                                    radius: 15,
                                                  )
                                                ],
                                              ),
                                        Text(
                                            "Font Size: ${allDeviceProfiles.items[index].fontSize}"),
                                        Text(
                                            "Longitude: ${allDeviceProfiles.items[index].longitude}"),
                                        Text(
                                            "Latitude: ${allDeviceProfiles.items[index].latitude}"),
                                      ],
                                    ));
                              });
                    });
              }

              return const Center(
                child: Text('No data Present'),
              );
            }),
      ),
    );
  }
}
