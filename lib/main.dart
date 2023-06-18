import 'package:flutter/material.dart';
import 'package:my_buttler/config/theme.dart';
import 'package:my_buttler/presentation/notifier/bulter.dart';
import 'package:my_buttler/presentation/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BulterViewModel()),
      ],
      child: MaterialApp(
        title: 'Buttler',
        theme: theme(context),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
