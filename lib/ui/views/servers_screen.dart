import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:yacine_tv/ui/models/models.dart';
import 'package:yacine_tv/services/yacine_api.dart';
import 'package:url_launcher/url_launcher.dart';

class ServersScreen extends StatelessWidget {
  final int id;
  final String channelName;
  const ServersScreen({
    super.key,
    required this.id,
    required this.channelName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(channelName),
      ),
      body: FutureBuilder(
        future: YacineAPI().getChannel(id),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CardModel(
                    name: snapshot.data![index]['url'].split('.')[1] +
                        ' (' +
                        snapshot.data![index]['name'] +
                        ')',
                    onTap: () async {
                      final Directory tempDirectory =
                          await getTemporaryDirectory();
                      final File file = File('${tempDirectory.path}/temp.m3u8');
                      await file.writeAsString(snapshot.data![index]['url']);
                      launchUrl(Uri.parse('${tempDirectory.path}/temp.m3u8'));
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
