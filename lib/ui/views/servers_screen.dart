import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yacine_tv/ui/models/models.dart';
import 'package:yacine_tv/services/yacine_api.dart';
import 'package:open_file/open_file.dart';

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
    String finalUrl = "";
    String finalUserAgent = "";
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
                    name: snapshot.data![index]['name'] != null
                        ? snapshot.data![index]['url'].split('.')[1] +
                            ' (' +
                            snapshot.data![index]['name'] +
                            ')'
                        : snapshot.data![index]['error'].split(":")[0],
                    onTap: () async {
                      if (snapshot.data![index]['name'] != null) {
                        final Directory tempDirectory =
                            await getTemporaryDirectory();
                        final File file =
                            File('${tempDirectory.path}/temp.m3u');
                        finalUrl = snapshot.data![index]['url'];
                        finalUserAgent = snapshot.data![index]['user_agent'];
                        await file.writeAsString('''
#EXTM3U
#EXTINF:-1,$channelName
#EXTVLCOPT:http-user-agent=$finalUserAgent
$finalUrl
''');
                        OpenFile.open('${tempDirectory.path}/temp.m3u');
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => DialogBox(
                            title: 'Error',
                            content: snapshot.data![index]['error'],
                            buttons: const [],
                          ),
                        );
                      }
                    },
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () async =>
                await Clipboard.setData(ClipboardData(text: finalUrl)),
            child: const Text("Copy URL"),
          ),
          TextButton(
            onPressed: () async =>
                await Clipboard.setData(ClipboardData(text: finalUserAgent)),
            child: const Text("Copy User Agent"),
          ),
        ],
      ),
    );
  }
}
