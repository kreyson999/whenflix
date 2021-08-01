import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whenflix/screens/screens.dart';
import 'package:whenflix/services/api_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => ApiService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whenflix',
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Color(0xFF4f555c),
        ),
        primaryColor: Color(0xFF4a749e),
        scaffoldBackgroundColor: Color(0xFF11191f),
      ),
      home: HomePage(),
    );
  }
}
