import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:ugandamartyrssacco/auth/login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _colorController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation controller (zoom in)
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Color animation controller (sky blue to deep blue)
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _colorAnimation =
        ColorTween(
          begin: Colors.lightBlue.shade300, // Sky blue
          end: Colors.blue.shade900, // Deep blue
        ).animate(
          CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
        );

    // Start both animations
    _scaleController.forward();
    _colorController.forward();
    Timer(Duration(seconds: 3), () {
      Get.to(() => const Login());
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.blue.shade100],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_scaleAnimation, _colorAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Text(
                  "Uganda Martyrs\nCathedral BANTU SACCO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _colorAnimation.value,
                    letterSpacing: 1.2,
                    height: 1.5,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
