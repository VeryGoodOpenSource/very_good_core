import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  static Widget scaffold() => const Scaffold(
        body: SafeArea(child: LoadingScreen()),
      );

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}
