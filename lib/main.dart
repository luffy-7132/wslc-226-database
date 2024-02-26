// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wslc_226_datbase/Screens/home_screen.dart';
import 'package:wslc_226_datbase/providers/provider.dart';
import 'package:wslc_226_datbase/providers/theme_provider.dart';

import 'app_Themes/app_theme.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => NotesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var isDark = context.watch<ThemeProvider>().themeValue;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: isDark ? lightMode : darkMode,
      home: Home_Screen(),
    );
  }
}
