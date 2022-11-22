import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'package:yacine_tv/services/yacine_api.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  final List<dynamic>? ytv;
  const VideoApp({
    Key? key,
    required this.ytv,
  }) : super(key: key);

  @override
  VideoAppState createState() => VideoAppState();
}

class VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  late List<String> serversNames;
  late List<String> serversUrls;
  //late List<dynamic>? ytv;

  @override
  void initState() {
    for (var i = 0; i < widget.ytv!.length; i++) {
      serversNames.add(widget.ytv![i]['name']);
      serversUrls.add(widget.ytv![i]['url']);
    }

    _controller = VideoPlayerController.network('')
      ..initialize()
      ..play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
