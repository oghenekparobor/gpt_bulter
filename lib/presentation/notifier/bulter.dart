import 'dart:developer';

import 'package:background_stt/background_stt.dart';
import 'package:flutter/material.dart';

class BulterViewModel extends ChangeNotifier {
  AnimationController? controller;

  final _service = BackgroundStt();

  playBulter() {
    controller?.duration = const Duration(milliseconds: 3000);
    controller?.repeat();
  }

  stopBulter() {
    controller?.stop();
    controller?.reset();
  }

  void listen() {
    _service.speechSubscription.onData((data) {
      log(data.result ?? '');
    });
  }

  void stopListen() async {
    var data = await _service.stopSpeechListenService;
    log(data ?? '');
  }
}
