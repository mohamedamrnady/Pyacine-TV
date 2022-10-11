import 'package:flutter/material.dart';

class CardModel extends StatelessWidget {
  final String name;
  final int id;
  const CardModel({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(2))),
      child: Column(
        children: [
          Expanded(child: Center(child: Text(name))),
          const VerticalDivider(
            color: Colors.black,
            width: 20.0,
          )
        ],
      ),
    );
  }
}
