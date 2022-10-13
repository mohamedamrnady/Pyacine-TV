import 'package:flutter/material.dart';
import 'package:yacine_tv/ui/models/models.dart';
import 'package:yacine_tv/services/yacine_api.dart';
import 'package:url_launcher/url_launcher.dart';

class ServersScreen extends StatelessWidget {
  final int id;
  final String channelName;
  const ServersScreen({super.key, required this.id, required this.channelName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(channelName),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: YacineAPI().getChannel(id),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final Uri url = Uri.parse(snapshot.data![index]['url']);
                  return CardModel(
                    name: snapshot.data![index]['name'],
                    onTap: () async {
                      await launchUrl(url,
                          webViewConfiguration: const WebViewConfiguration(
                              headers: {
                                "user_agent":
                                    "HDPlayer/3.5.47 (Linux;Android 12) ExoPlayerLib/2.14.1"
                              }));
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
