import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerButton extends StatefulWidget {
  final String url;
  final Color? color;
  const AudioPlayerButton({super.key, required this.url, this.color});

  @override
  State<AudioPlayerButton> createState() => _AudioPlayerButtonState();
}

class _AudioPlayerButtonState extends State<AudioPlayerButton> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() async {
    try {
      // You can use setAsset() if your audio file is in the assets folder.
      // await player.setAsset('assets/your_audio.mp3');
    } catch (e) {
      print("Error initializing player: $e");
    }
  }

  @override
  void dispose() {
    player.pause();
    //player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.headphones,
        color: widget.color ?? Colors.black,
      ),
      onPressed: () async {
        await player.setUrl(widget.url);
        await player.play();
      },
    );
  }
}
