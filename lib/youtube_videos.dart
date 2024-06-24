import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key});

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late YoutubePlayerController _controller;
  bool isPlaying = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final videoUrl = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=YMx8Bbev6T4&t=36s");
    _controller = YoutubePlayerController(
      initialVideoId: videoUrl!, // Add your video ID here
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }
  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
  void _listener() {
    if (_controller.value.hasError) {
      print('Error: ${_controller.value.errorCode}');
    }
    if (_controller.value.isReady && !_controller.value.isPlaying) {
      setState(() {
        isPlaying = false;
      });
    } else if (_controller.value.isPlaying) {
      setState(() {
        isPlaying = true;
      });
    }
    print('Current position: ${_controller.value.position}');
    }

  void _togglePlayPause() {
    if (isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Youtube page"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios))
        ],
      ),
      body: 
      Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {
              print('Player is ready.');
              _controller.addListener(_listener);
              _controller.play();
            },
            onEnded: (data) {
              print('Video has ended');
            },
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
              ),
              const PlaybackSpeedButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _togglePlayPause,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
