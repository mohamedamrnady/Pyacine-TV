import 'package:flutter/material.dart';
import 'package:yacine_tv/ui/animations/animations.dart';
import 'package:yacine_tv/ui/views/views.dart';

Future main() async {
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
      scrollBehavior: ScrollBehaviorModified(),
      home: const CategoriesScreen(),
    );
  }
}
