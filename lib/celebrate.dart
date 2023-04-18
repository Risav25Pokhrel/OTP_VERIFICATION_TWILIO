import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class Celebrate extends StatefulWidget {
  const Celebrate({super.key});

  @override
  State<Celebrate> createState() => _CelebrateState();
}

class _CelebrateState extends State<Celebrate> {
  final controller = ConfettiController();
  @override
  void initState() {
    controller.play();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                  confettiController: controller, shouldLoop: true)),
          const Text("VERIFIED SUCCESSFULLY",
              style: TextStyle(color: Colors.black, fontSize: 20))
        ],
      ),
    );
  }
}
