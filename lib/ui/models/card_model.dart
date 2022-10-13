import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CardModel extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  const CardModel({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.5,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textScaleFactor: 1.75,
        )),
      ),
    );
  }
}
