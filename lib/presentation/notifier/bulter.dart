import 'package:flutter/material.dart';
import 'package:my_buttler/core/logger/logger.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ButlerViewModel extends ChangeNotifier {
  ButlerViewModel() {
    // initialize speech to text plugin
    speechToText = SpeechToText();

    // initialize text to speech plugin
    textToSpeech = TextToSpeech();
  }

  late SpeechToText speechToText;
  late TextToSpeech textToSpeech;

  AnimationController? controller;

  playButler() {
    ButlerLogger.log('ai motion play');
    controller?.duration = const Duration(milliseconds: 2500);
    controller?.repeat();
  }

  stopButler() {
    ButlerLogger.log('ai motion stop');

    controller?.stop();
    controller?.reset();
  }

  void listen() async {
    var status = await speechToText.initialize();
    if (status) {
      speechToText.listen(
        onResult: _onSpeechResult,
        listenMode: ListenMode.dictation,
        listenFor: const Duration(minutes: 1),
      );
    } else {
      await butlerSpeak('I am not permited to listen to you');
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.finalResult) {
      if (result.confidence > .98) {
        ButlerLogger.log({
          'confidence': result.confidence,
          'speech': result.recognizedWords,
        });
      } else {
        await butlerSpeak(
          'I didn\'t get what you said. Please kindly repeat yourself',
        );

        // listen();
      }
    }
  }

  void stopListen() async {
    ButlerLogger.log('listening stopped');

    speechToText.stop();
  }

  Future<void> butlerSpeak(String message) async {
    playButler();

    await Future.delayed(const Duration(milliseconds: 700), () async {
      var res = await textToSpeech.speak(message);

      ButlerLogger.log('is speaking $res');
      stopButler();
    });
  }
}
