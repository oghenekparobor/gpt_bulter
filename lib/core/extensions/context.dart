import 'package:flutter/material.dart';
import 'package:my_buttler/presentation/notifier/bulter.dart';
import 'package:provider/provider.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

  BulterViewModel get bulter => read<BulterViewModel>();
}
