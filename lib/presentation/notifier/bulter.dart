import 'package:flutter/material.dart';
import 'package:my_buttler/core/logger/logger.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ButlerViewModel extends ChangeNotifier {
  ButlerViewModel() {
    speechToText = SpeechToText();
  }

  late SpeechToText speechToText;

  AnimationController? controller;

  playButler() {
    controller?.duration = const Duration(milliseconds: 3000);
    controller?.repeat();
  }

  stopButler() {
    controller?.stop();
    controller?.reset();
  }

  void listen() async {
    ButlerLogger.log('listening called');

    var data = await speechToText.initialize();

    ButlerLogger.log('Speach initialised: $data');

    speechToText.listen(
      onResult: (s) {
        ButlerLogger.log(s.recognizedWords);
      },
      listenMode: ListenMode.dictation,
      listenFor: const Duration(minutes: 6),
    );
  }

  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   ButlerLogger.log('speech result is called');

  //   // if (result.recognizedWords.toLowerCase().contains('hello') ||
  //   //     result.recognizedWords.toString().contains('testing') ||
  //   //     result.recognizedWords.toLowerCase().contains('Hello')) {
  //   //   playButler();
  //   // }

  //   // if (result.recognizedWords.toLowerCase().contains('stop')) {
  //   //   stopButler();
  //   // }

  //   ButlerLogger.log({
  //     'confidence': result.confidence,
  //     'speech': result.recognizedWords,
  //   });
  // }

  void stopListen() async {
    ButlerLogger.log('listening stopped');

    speechToText.stop();
  }

  void butlerSpeak() async {}
}
