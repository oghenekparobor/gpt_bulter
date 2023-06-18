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
    context.butler.controller = AnimationController(
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    context.butler.stopListen();

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
              onTap: () => context.butler.listen(),
              child: Lottie.asset(
                ktalking,
                controller: context.butler.controller,
                onLoaded: (_) => context.butler.listen(firstLaunch: true),
              ),
            ),
          ),
          Consumer<ButlerViewModel>(
            builder: (_, value, __) => Align(
              alignment: Alignment.bottomCenter,
              child: value.isListening
                  ? const LinearProgressIndicator(color: Color(0xFF008D1D))
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
