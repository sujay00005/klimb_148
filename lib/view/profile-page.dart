import 'package:flutter/material.dart';
import 'package:klimb_148/util/constants/color-constant.dart';

import 'add-location.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

          // RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15.0),
          // ),
          // flexibleSpace: ,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstant.primaryGreen,
          elevation: 10,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddLocation();
            }));
          },
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                color: ColorConstant.secondaryGreen,
                height: 150,
              );
            }));
  }
}
