import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:klimb_148/util/constants/design-constants.dart';
import 'package:klimb_148/util/db-helper.dart';
import 'package:klimb_148/view/profile-page.dart';

import '../model/device-profile-model.dart';
import '../util/constants/color-constant.dart';

class AddLocation extends StatefulWidget {
  // final bool newUser;
  final String? longitude;
  final String? latitude;
  final List<DeviceProfileModel> allProfiles;
  const AddLocation({
    super.key,
    // required this.newUser,
    required this.allProfiles,
    this.longitude,
    this.latitude,
    //false,
  });

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final _formKey = GlobalKey<FormState>();
  var validateMode = AutovalidateMode.disabled;

  bool newUser = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController fontSizeController = TextEditingController();
  Color pickerColor = const Color(0xff770dac);

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

  // Future<void> fetchDeviceProfiles() async {
  //   final dataList = await DBHelper.getAllData('profiles');
  //   dataList
  //       .map((item) => DeviceProfileModel(
  //           name: item['name'],
  //           email: item['email'],
  //           phone: item['phone'],
  //           fontSize: item['fontSize'],
  //           color: item['color'],
  //           longitude: item['longitude'],
  //           latitude: item['latitude']))
  //       .toList();
  //
  //   print("🎃🎃🎃");
  //   print(dataList[0]);
  // }

  @override
  void initState() {
    if (widget.longitude != null && widget.latitude != null) {
      longitudeController.text = widget.longitude!;
      latitudeController.text = widget.latitude!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device Profile'),
        backgroundColor: ColorConstant.primaryGreen,
        centerTitle: true,
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(15),
          // color: ColorConstant.secondaryGreen,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      label: const Text("Enter Latitude"),
                    ),
                    controller: latitudeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,6}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field should be non empty';
                      } else if (double.parse(value) <= -90 ||
                          double.parse(value) >= 90) {
                        return 'Enter valid latitude';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      label: const Text("Enter Longitude"),
                    ),
                    controller: longitudeController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,6}')),
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field should be non empty';
                      } else if (double.parse(value) <= -180 ||
                          double.parse(value) >= 180) {
                        return 'Enter valid longitude';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Visibility(
                    visible: newUser,
                    child: Column(children: [
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          label: const Text('Name'),
                          //errorText: 'Enter valid email'
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (newUser && (value == null || value.isEmpty)) {
                            return 'Please provide name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          label: const Text('Email'),
                          //errorText: 'Enter valid email'
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (newUser) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide email';
                            } else if (!value.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                              return 'Incorrect email';
                            }
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          label: const Text('Phone'),
                          //errorText: 'Enter valid email'
                        ),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (newUser) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide phone number';
                            } else if (value.length != 10) {
                              return 'Invalid phone number';
                            }
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          label: const Text('Font Size'),
                          //errorText: 'Enter valid email'
                        ),
                        controller: fontSizeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide font size';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Text(
                            'Pick Theme color',
                            style: TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                                color: ColorConstant.primaryGreen),
                          ),
                          const SizedBox(width: 40),
                          CircleAvatar(
                            backgroundColor: pickerColor,
                            radius: 15,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 200,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstant.primaryGreen),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18))
                            //           BoxShape.all<RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.circular(18.0),
                            //                 side: const BorderSide(
                            //                   color: ColorConstant.primaryGreen,
                            //                 )),
                            //           ),
                            ),
                        child: MaterialPicker(
                          pickerColor: pickerColor,
                          enableLabel: true, // only on portrait mode
                          onColorChanged: (Color color) {
                            print("🎫🎫");
                            print(Color(pickerColor.value).withOpacity(1));
                            print(pickerColor.toString());
                            // print(pickerColor);
                            setState(() => pickerColor = color);
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                    ]),
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: kButtonDecoration,
                      onPressed: () async {
                        validate();
                        _submit();

                        print("🧧🧧🧧🧧");

                        bool flag = false;
                        // DeviceProfileModel profile=
                        widget.allProfiles.map((value) {
                          if (value.latitude == latitudeController.text &&
                              value.longitude == longitudeController.text) {
                            setState(() {
                              print("Came HERE ");
                              flag = true;
                              // return value;
                            });
                          }
                        }) as DeviceProfileModel;

                        if (flag) {
                          await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('New Latitude & Longitude'),
                              content: const Text('Add new device profile'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      newUser = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          Map<String, Object> data = {
                            'name': nameController.text,
                            'email': emailController.text,
                            'phone': phoneController.text,
                            'fontSize': fontSizeController.text,
                            'color': pickerColor.value,
                            'longitude': longitudeController.text,
                            'latitude': latitudeController.text
                          };

                          DBHelper.insert('profiles', data);
                          print("Saved");
                        } else {}
                      },
                      // },
                      child: const Text('Save',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
