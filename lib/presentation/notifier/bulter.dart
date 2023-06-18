import 'dart:developer';

import 'package:background_stt/background_stt.dart';
import 'package:flutter/material.dart';
import 'package:my_buttler/core/logger/logger.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ButlerViewModel extends ChangeNotifier {
  ButlerViewModel() {
    speechToText = SpeechToText();
    _service = BackgroundStt();
  }

  late SpeechToText speechToText;
  late BackgroundStt _service;

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
    await speechToText.initialize();

    speechToText.listen(
      onResult: _onSpeechResult,
      listenMode: ListenMode.dictation,
      listenFor: const Duration(minutes: 1),
    );
    // await _service.startSpeechListenService;

    // _service.speechSubscription.onData((data) {
    //   ButlerLogger.log(data.toJson());

    // if (data.result != null) {
    //   ButlerLogger.log(data.result);

    //   if (data.result!.toLowerCase().contains('hello') ||
    //       data.result!.toString().contains('testing') ||
    //       data.result!.toLowerCase().contains('Hello')) {
    //     playButler();
    //   }

    //   if (data.result!.toLowerCase().contains('stop')) {
    //     stopButler();
    //   }
    // }
    // });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.recognizedWords.toLowerCase().contains('hello') ||
        result.recognizedWords.toString().contains('testing') ||
        result.recognizedWords.toLowerCase().contains('Hello')) {
      playButler();
    }

    if (result.recognizedWords.toLowerCase().contains('stop')) {
      stopButler();
    }

    ButlerLogger.log({
      'confidence': result.confidence,
      'speech': result.recognizedWords,
    });
  }

  void stopListen() async {
    ButlerLogger.log('listening stopped');

    var data = await _service.stopSpeechListenService;
    ButlerLogger.log(data ?? '');
  }

  void butlerSpeak() async {
    var d = await _service.speak(
      "Lorem ispum is a dummy text, created for purpose of place holing",
      false,
    );

    ButlerLogger.log(d);
  }
}
