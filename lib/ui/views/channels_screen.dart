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
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CardModel(
                        name: snapshot.data?[index]['name'] ??
                            snapshot.data![index]['error'].split(":")[0],
                        onTap: () {
                          //var ytv = await YacineAPI()
                          //    .getChannel(snapshot.data![index]['id']);
                          /* ATTEMPT 1
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return FutureBuilder(
                              future: YacineAPI()
                                  .getChannel(snapshot.data![index]['id']),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return VideoApp(
                                    ytv: snapshot.data,
                                  );
                                }
                                return const LoadingScreen();
                              });
                        }),
                      );
                      */
                          // WORKING
                          snapshot.data![index]['name'] != null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServersScreen(
                                      id: snapshot.data![index]['id'],
                                      channelName: snapshot.data![index]
                                          ['name'],
                                    ),
                                  ),
                                )
                              //
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
                              : showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                    title: 'Error',
                                    content: snapshot.data![index]['error'],
                                    buttons: const [],
                                  ),
                                );
                        },
                      );
                    })
                : CardModel(
                    name: "Get Channels",
                    onTap: (() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesScreen(
                                    categoryId: id.toString(),
                                    pageTitle: categoryName,
                                  )),
                        )),
                  );

            /*
                CategoriesScreen(
                    categoryId: id.toString(),
                    pageTitle: categoryName,
                  );
                  */
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
