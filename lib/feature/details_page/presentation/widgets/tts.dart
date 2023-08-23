import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TtsState { playing, stopped, paused, continued }

class TravelGuideTTS extends StatefulWidget {
  final String description;

  const TravelGuideTTS({super.key, required this.description});
  @override
  _TravelGuideTTSState createState() => _TravelGuideTTSState();
}

class _TravelGuideTTSState extends State<TravelGuideTTS> {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() async {
    flutterTts = FlutterTts();

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
  }

  bool loading = false;
  Future _speak() async {
    loading = true;
    setState(() {});
    try {
      if (widget.description.isNotEmpty) {
        flutterTts.speak(widget.description);
      }
    } catch (e) {}
    Future.delayed(
      const Duration(milliseconds: 700),
      () {
        loading = false;
        ttsState = TtsState.playing;
        setState(() {});
      },
    );
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    if (ttsState == TtsState.playing) {
      return FloatingActionButton(
        onPressed: () {
          _pause();
        },
        child: FaIcon(FontAwesomeIcons.stop),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          if (!loading) _speak();
        },
        child: loading
            ? CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              )
            : FaIcon(FontAwesomeIcons.play),
      );
    }
  }
}
