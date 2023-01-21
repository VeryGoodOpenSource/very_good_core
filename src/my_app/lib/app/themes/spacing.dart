import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  const VSpace(this.size, {super.key});
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(height: size);

  static VSpace get xxs => VSpace(Insets.xxs);
  static VSpace get xs => VSpace(Insets.xs);
  static VSpace get sm => VSpace(Insets.sm);
  static VSpace get med => VSpace(Insets.med);
  static VSpace get lg => VSpace(Insets.lg);
  static VSpace get xl => VSpace(Insets.xl);
  static VSpace get xxl => VSpace(Insets.xxl);
  static VSpace get xxxl => VSpace(Insets.xxxl);
}

class HSpace extends StatelessWidget {
  const HSpace(this.size, {super.key});
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(width: size);

  static HSpace get xxs => HSpace(Insets.xxs);
  static HSpace get xs => HSpace(Insets.xs);
  static HSpace get sm => HSpace(Insets.sm);
  static HSpace get med => HSpace(Insets.med);
  static HSpace get lg => HSpace(Insets.lg);
  static HSpace get xl => HSpace(Insets.xl);
  static HSpace get xxl => HSpace(Insets.xxl);
  static HSpace get xxxl => HSpace(Insets.xxxl);
}

abstract class Insets {
  const Insets._();

  static const double scale = 1;

  // Regular paddings
  static double get xxs => 4 * scale;
  static double get xs => 8 * scale;
  static double get sm => 12 * scale;
  static double get med => 16 * scale;
  static double get lg => 24 * scale;
  static double get xl => 32 * scale;
  static double get xxl => 64 * scale;
  static double get xxxl => 128 * scale;
}
