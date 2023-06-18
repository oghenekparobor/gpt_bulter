import 'package:flutter/material.dart';

class BulterViewModel extends ChangeNotifier {
  AnimationController? controller;

  playBulter() {
    controller?.duration = const Duration(milliseconds: 3000);
    controller?.repeat();
  }

  stopBulter() {
    controller?.stop();
    controller?.reset();
  }
}
