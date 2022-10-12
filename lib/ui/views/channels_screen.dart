import 'package:flutter/material.dart';
import 'package:yacine_tv/ui/models/models.dart';
import 'package:yacine_tv/services/yacine_api.dart';

class ChannelsScreen extends StatelessWidget {
  final int id;
  final String categoryName;
  const ChannelsScreen(
      {super.key, required this.id, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: YacineAPI().getCategoryChannels(id),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CardModel(
                    name: snapshot.data![index]['name'],
                    id: snapshot.data![index]['id'],
                    onTap: () {},
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
