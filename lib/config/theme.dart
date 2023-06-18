import 'package:flutter/material.dart';

ThemeData theme(BuildContext context) => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        background: const Color(0xFF021926),
      ),
      useMaterial3: true,
      primaryColor: const Color(0xFF021926),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF021926),
        iconTheme: IconThemeData(
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
