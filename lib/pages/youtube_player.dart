import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final String? videoId;

  const YouTubePlayerScreen({super.key, required this.videoId});

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    setSecureFlag();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        showLiveFullscreenButton: true,
        mute: false,
        forceHD: true,
        controlsVisibleAtStart: false,
      ),
    );
  }

  void setSecureFlag() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          // Perform actions when player is ready
        },
      ),
      builder: (context, player) {
        return Column(
          children: [
            // Your custom controls

            // Player
            player,
            // Additional widgets can be added below the player
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    super.dispose();
  }
}
