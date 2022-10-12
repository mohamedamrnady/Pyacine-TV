// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:yacine_tv/services/yacine_api.dart';
import 'package:yacine_tv/ui/models/models.dart';
import 'package:yacine_tv/ui/views/views.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  //final String _categories = 'n';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pyacine TV'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: YacineAPI().getCategories(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CardModel(
                    name: snapshot.data![index]['name'],
                    id: snapshot.data![index]['id'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChannelsScreen(id: snapshot.data![index]['id']),
                        ),
                      );
                    },
                  );
                });
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          }
        }),
      ),
    );
  }
}
