import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yacine_tv/ui/animations/animations.dart';
import 'package:yacine_tv/ui/views/views.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pyacine TV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      scrollBehavior: ScrollBehaviorModified(),
      home: const CategoriesScreen(categoryId: "", pageTitle: 'Pyacine TV'),
    );
  }
}
