import 'package:flutter/material.dart';
import 'package:yacine_tv/services/yacine_api.dart';
import 'package:yacine_tv/ui/models/models.dart';
import 'package:yacine_tv/ui/views/views.dart';

class CategoriesScreen extends StatelessWidget {
  final String categoryId;
  final String pageTitle;
  const CategoriesScreen(
      {super.key, required this.categoryId, required this.pageTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: FutureBuilder(
        future: YacineAPI().getCategory(categoryId),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CardModel(
                  name: snapshot.data?[index]['name'] ??
                      snapshot.data![index]['error'].split(":")[0],
                  onTap: () {
                    snapshot.data![index]['name'] != null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChannelsScreen(
                                id: snapshot.data![index]['id'],
                                categoryName: snapshot.data![index]['name'],
                              ),
                            ),
                          )
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
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
