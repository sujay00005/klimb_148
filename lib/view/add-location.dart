import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klimb_148/model/device-profile-model.dart';
import 'package:klimb_148/util/constants/design-constants.dart';
import 'package:klimb_148/util/db-helper.dart';

class AddLocation extends StatefulWidget {
  final bool newUser;
  const AddLocation({
    super.key,
    this.newUser = true,
    //false,
  });

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final _formKey = GlobalKey<FormState>();
  var validateMode = AutovalidateMode.disabled;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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

  Future<void> fetchDeviceProfiles() async {
    final dataList = await DBHelper.getAllData('device-profiles');
    dataList
        .map((item) => DeviceProfileModel(
            name: item['name'],
            email: item['phone'],
            phone: item['phone'],
            latitude: item['longitude'],
            longitude: item['longitude']))
        .toList();

    print("🎃🎃🎃");
    print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Visibility(
                      visible: widget.newUser,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: kTextFieldDecoration.copyWith(
                              label: const Text('Name'),
                              //errorText: 'Enter valid email'
                            ),
                            // controller: emailController,
                            validator: (value) {
                              if (widget.newUser &&
                                  (value == null || value.isEmpty)) {
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
                            // controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (widget.newUser) {
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
                            // controller: emailController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (widget.newUser) {
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
                        ],
                      ),
                    ),
                    TextFormField(
                      decoration: kTextFieldDecoration.copyWith(
                        label: const Text("Enter Latitude"),
                      ),
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
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: kButtonDecoration,
                        onPressed: () async {
                          validate();
                          _submit();

                          DBHelper.insert('device-profiles', {
                            'name': nameController.text,
                            'email': emailController.text,
                            'phone': phoneController.text,
                            'longitude': longitudeController.text,
                            'latitude': latitudeController.text
                          });

                          // if (_formKey.currentState!.validate()) {
                          // if (passwordController.text ==
                          //     confirmPasswordController.text) {
                          //   await _secureStorage
                          //       .setUserName(emailController.text);
                          //   await _secureStorage
                          //       .setPassWord(passwordController.text);
                          //
                          //   Navigator.push(context,
                          //       MaterialPageRoute(builder: (context) {
                          //     return Dashboard(email: emailController.text);
                          //   }));
                          // }
                        },
                        // emailController.text = "";
                        // passwordController.text = "";
                        // validateMode = AutovalidateMode.disabled;
                        // },
                        child: const Text('Save',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
