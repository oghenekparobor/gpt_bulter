import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_buttler/core/constant/asset.dart';
import 'package:my_buttler/core/extensions/context.dart';
import 'package:my_buttler/presentation/notifier/bulter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.bulter.controller = AnimationController(
      vsync: this,
    );

    super.initState();

    context.bulter.listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Lottie.asset(
              ktalking,
              controller: context.bulter.controller,
            ),
          ),
        ],
      ),
    );
  }
}
