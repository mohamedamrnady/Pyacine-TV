import 'package:flutter/material.dart';
import 'package:yacine_tv/ui/models/models.dart';
import 'package:yacine_tv/services/yacine_api.dart';
import 'package:yacine_tv/ui/views/views.dart';

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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServersScreen(
                            id: snapshot.data![index]['id'],
                            channelName: snapshot.data![index]['name'],
                          ),
                        ),
                      );
                      /*
                      FutureBuilder(
                        future:
                            YacineAPI().getChannel(snapshot.data![index]['id']),
                        builder: (context, snapshot) {
                          return DialogBox(
                            title: channelName,
                            content: 'Choose a server',
                            buttons: ,
                          );
                        },
                      );
                      */
                    },
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
