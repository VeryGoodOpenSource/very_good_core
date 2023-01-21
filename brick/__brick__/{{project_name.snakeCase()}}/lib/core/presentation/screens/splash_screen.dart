import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/app_title.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: const <Widget>[
                Flexible(
                  child: Center(
                    child: AppTitle(),
                  ),
                ),
                Flexible(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      );
}
