import 'package:flutter/material.dart';
import 'package:yacine_tv/services/yacine_api.dart';
import 'package:yacine_tv/ui/models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  //final String _categories = 'n';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: FutureBuilder(
        future: YacineAPI().getCategories(),
        builder: ((context, snapshot) {
          //return Text(snapshot.data![0]['name']);
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return CardModel(
                    name: snapshot.data?[index]['name'],
                    id: snapshot.data?[index]['id']);
              });
        }),
      ),
    );
  }
}
