// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:wslc_226_datbase/Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Banner(
            location: BannerLocation.topEnd,
            message: 'Notes App',
            child: Home_Screen(),
            ),
      ),
    );
  }
}