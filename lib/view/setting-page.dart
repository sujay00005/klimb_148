import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../util/constants/color-constant.dart';
import '../util/constants/design-constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController fontSizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  Color pickerColor = const Color(0xff770dac);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryGreen,
        centerTitle: true,
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Save the settings for selected user
            },
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  label: const Text('Font Size'),
                  //errorText: 'Enter valid email'
                ),
                controller: fontSizeController,
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
                    border: Border.all(color: ColorConstant.primaryGreen),
                    borderRadius: const BorderRadius.all(Radius.circular(18))
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
                    // print(pickerColor.value);
                    print(pickerColor.toString());
                    // print(pickerColor);
                    setState(() => pickerColor = color);
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
