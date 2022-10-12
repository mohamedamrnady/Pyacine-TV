import 'package:flutter/material.dart';

class CardModel extends StatelessWidget {
  final String name;
  final int id;
  final void Function()? onTap;
  const CardModel(
      {super.key, required this.name, required this.id, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 2.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
