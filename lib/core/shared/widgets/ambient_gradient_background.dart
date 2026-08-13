import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';

class AmbientGradientBackground extends StatelessWidget {
  final Widget child;

  const AmbientGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFBFDFC)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Top glow — slightly stronger
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.85, -1.05),
                radius: 1.28,
                colors: [
                  AppColors.primary.withValues(alpha: 0.28),
                  AppColors.primary.withValues(alpha: 0.13),
                  AppColors.primary.withValues(alpha: 0.04),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.40, 0.72, 1.0],
              ),
            ),
          ),

          // Bottom glow — slightly stronger
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.75, 1.02),
                radius: 1.02,
                colors: [
                  AppColors.primary.withValues(alpha: 0.16),
                  AppColors.primary.withValues(alpha: 0.07),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.60, 1.0],
              ),
            ),
          ),

          child,
        ],
      ),
    );
  }
}
