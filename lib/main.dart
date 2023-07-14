import 'package:flutter/material.dart';
import 'package:klimb_148/provider/update-profiles.dart';
import 'package:klimb_148/view/add-location.dart';
import 'package:klimb_148/view/profile-page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UpdatedProfiles()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home:
          // AddLocation()
          const ProfilePage(),
    );
  }
}
