import 'package:flutter/material.dart';
import '../../core/shared/theme/app_colors.dart';
import '../../core/shared/theme/app_text_styles.dart';
import 'heartbeat_painter.dart';

/// Splash screen with a continuous beating ECG wave that sweeps across
/// and off the screen while pulling the app name in behind its tail.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.onComplete});

  final VoidCallback? onComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  static const _waveDuration = Duration(milliseconds: 6500);
  static const _holdBeforeStart = Duration(milliseconds: 300);
  static const _holdAfterFinish = Duration(milliseconds: 600);

  /// How wide the text block is assumed to be, as a fraction of screen
  /// width — used only to size the centering box the text slides
  /// within. If the app name changes length significantly, this is
  /// the number to revisit.
  static const _textWidthFactor = 0.8;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _waveDuration);

    _progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear, // guarantees smooth 1:1 speed matching
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    await Future<void>.delayed(_holdBeforeStart);
    if (!mounted) return;
    await _controller.forward();
    if (!mounted) return;
    await Future<void>.delayed(_holdAfterFinish);
    if (!mounted) return;
    widget.onComplete?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final waveLength = HeartbeatLinePainter.waveLengthFor(screenWidth);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _progress,
          builder: (context, _) {
            // Total sweep distance across the screen.
            final totalDistance = screenWidth + (waveLength * 2);
            final currentLeadX = (_progress.value * totalDistance) - waveLength;
            final currentTailX = currentLeadX - waveLength;

            // Approximate width of the text block, used to size the
            // centering box (see _textWidthFactor above).
            final textWidth = screenWidth * _textWidthFactor;

            // Position the right edge of the text directly at the
            // tail of the line.
            final calculatedTextOffset =
                currentTailX - (screenWidth / 2) - (textWidth / 2);

            // Clamp so text locks strictly into place once centered.
            final textXOffset = calculatedTextOffset.clamp(-screenWidth, 0.0);

            return Stack(
              alignment: Alignment.center,
              children: [
                // Continuous heartbeat line.
                SizedBox.expand(
                  child: CustomPaint(
                    painter: HeartbeatLinePainter(
                      progress: _progress.value,
                      lineColor: AppColors.textOnPrimary,
                    ),
                  ),
                ),

                // Text anchored directly behind the tail of the line.
                Transform.translate(
                  offset: Offset(textXOffset, 0),
                  child: SizedBox(
                    width: textWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Libya Medical\nRecord System',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.displayMedium.copyWith(
                            color: AppColors.textOnPrimary,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'نظام السجلات الطبية',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary.withValues(
                              alpha: 0.85,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
