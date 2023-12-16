import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerButton extends StatefulWidget {
  @override
  _AudioPlayerButtonState createState() => _AudioPlayerButtonState();
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
      await player.setUrl(
          'https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsunset.mp3?alt=media&token=9dfbf6f0-ec7f-494f-ac46-6dc95573e2de');
      // You can use setAsset() if your audio file is in the assets folder.
      // await player.setAsset('assets/your_audio.mp3');
    } catch (e) {
      print("Error initializing player: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.headphones),
      onPressed: () async {
        await player.play().then((value) async {
          //await player.pause();
        }).catchError((e) {
          print("loi day $e");
        });
      },
    );
  }
}
