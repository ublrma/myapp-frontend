//main.dart

import 'package:flutter/material.dart';
import 'package:my_app/pages/LoginPage.dart';
import 'package:my_app/provider/provider.dart';
import 'package:my_app/widgets/mainscreen.dart';
import 'package:my_app/testpage.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommonProvider()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      // home: AudioUploadPage(),
    );
  }
}
