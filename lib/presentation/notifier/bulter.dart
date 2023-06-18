import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_buttler/core/logger/logger.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ButlerViewModel extends ChangeNotifier {
  ButlerViewModel() {
    // initialize speech to text plugin
    speechToText = SpeechToText();

    // initialize text to speech plugin
    textToSpeech = FlutterTts();

    configureTts();
  }

  late SpeechToText speechToText;
  late FlutterTts textToSpeech;

  AnimationController? controller;

  void configureTts() async {
    await textToSpeech.awaitSpeakCompletion(true);
  }

  void playButler() {
    controller?.duration = const Duration(milliseconds: 2500);
    controller?.repeat();
  }

  void stopButler() {
    controller?.stop();
    controller?.reset();
  }

  void listen({bool firstLaunch = false}) async {
    if (firstLaunch) {
      // welcome the user once app is justed opened
      await butlerSpeak('Welcome! How can I be of assistance.');
    }

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
      if (result.confidence > .65) {
        ButlerLogger.log({
          'confidence': result.confidence,
          'speech': result.recognizedWords,
        });
      } else {
        await butlerSpeak(
          'I didn\'t get what you said. Please kindly repeat yourself',
        );

        listen();
      }
    }
  }

  void stopListen() async {
    ButlerLogger.log('listening stopped');

    // stops speech to text
    speechToText.stop();
    // stops text to speech
    textToSpeech.stop();
  }

  Future<void> butlerSpeak(String message) async {
    playButler();

    await textToSpeech.speak(message);

    stopButler();
  }
}
