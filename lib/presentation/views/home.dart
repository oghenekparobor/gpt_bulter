import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_buttler/core/constant/asset.dart';
import 'package:my_buttler/core/extensions/context.dart';

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
  }

  @override
  void dispose() {
    context.bulter.stopListen();

    super.dispose();
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
            child: GestureDetector(
              onTap: () => context.bulter.listen(),
              child: Lottie.asset(
                ktalking,
                controller: context.bulter.controller,
                onLoaded: (p0) => context.bulter.listen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
