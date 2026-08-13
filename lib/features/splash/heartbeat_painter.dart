import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Paints an ECG-style trace that continuously beats and moves completely
/// off-screen.
///
/// [progress] goes from 0.0 (off-screen left) to 1.0 (completely off-screen
/// right).
class HeartbeatLinePainter extends CustomPainter {
  const HeartbeatLinePainter({
    required this.progress,
    required this.lineColor,
    this.strokeWidth = 2.6,
  });

  final double progress;
  final Color lineColor;
  final double strokeWidth;

  /// How long one full heartbeat cycle is, as a fraction of screen width.
  /// Exposed as a static so callers (e.g. the splash screen positioning
  /// the text against the wave's tail) can derive the same waveLength
  /// this painter uses internally, instead of duplicating the constant.
  static const double waveLengthFactor = 0.35;

  static double waveLengthFor(double screenWidth) =>
      screenWidth * waveLengthFactor;

  // ── PQRST shape tuning ────────────────────────────────────────────
  // Named breakpoints for the heartbeat shape, all expressed as
  // fractions of a single beat cycle (0..1). Adjust these to reshape
  // the pulse without having to decode magic numbers later.

  /// The beat itself only occupies the first slice of each cycle;
  /// the rest is a flat rest period between beats.
  static const double _beatFraction = 0.60;

  static const double _pWaveEnd = 0.14;
  static const double _preQrsFlatEnd = 0.22;
  static const double _qDipEnd = 0.27;
  static const double _rSpikeEnd = 0.34;
  static const double _sDipEnd = 0.42;
  static const double _preTFlatEnd = 0.55;
  static const double _tWaveEnd = 0.78;

  static const double _pWaveAmplitude = 2.2;
  static const double _qDipAmplitude = -3.0;
  static const double _rSpikeAmplitude = 22.0;
  static const double _sDipAmplitude = -8.0;
  static const double _tWaveAmplitude = 5.0;
  // ─────────────────────────────────────────────────────────────────

  @override
  void paint(Canvas canvas, Size size) {
    final baselineY = size.height / 2;

    // Length of one full heartbeat cycle, proportional to screen width
    // so the pulse keeps its proportions on phones and tablets alike.
    final waveLength = waveLengthFor(size.width);

    // Total distance the front of the wave travels (screen width + the
    // off-screen margins it needs to fully enter and fully exit).
    final totalDistance = size.width + (waveLength * 2);
    final leadX = (progress * totalDistance) - waveLength;
    final tailX = leadX - waveLength;

    if (leadX <= 0 && tailX <= 0) return;

    final path = Path();
    const step = 2.0;

    var pathStarted = false;
    for (double x = 0; x <= size.width; x += step) {
      if (x >= tailX && x <= leadX) {
        final y = _yFor(x, baselineY, waveLength);
        if (!pathStarted) {
          path.moveTo(x, y);
          pathStarted = true;
        } else {
          path.lineTo(x, y);
        }
      }
    }

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, linePaint);

    // Glowing tip dot at the leading edge while still on screen.
    if (leadX > 0 && leadX < size.width) {
      final dotY = _yFor(leadX, baselineY, waveLength);

      final glowPaint = Paint()
        ..color = lineColor.withValues(alpha: 0.28)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(Offset(leadX, dotY), 5, glowPaint);

      final dotPaint = Paint()..color = lineColor;
      canvas.drawCircle(Offset(leadX, dotY), 2.5, dotPaint);
    }
  }

  /// Calculates the continuous beating y-offset at [x].
  double _yFor(double x, double baselineY, double waveLength) {
    final cycleX = x % waveLength;
    final t = cycleX / waveLength;

    final amplitude = waveLength * 0.02;
    return baselineY - _ecgOffset(t) * amplitude;
  }

  /// Normalized PQRST heartbeat shape, t in [0, 1] across one full cycle
  /// (beat + rest period).
  double _ecgOffset(double t) {
    if (t > _beatFraction) return 0.0;
    final beatT = t / _beatFraction; // 0..1 across just the beat itself

    if (beatT < _pWaveEnd) {
      return _pWaveAmplitude * math.sin((beatT / _pWaveEnd) * math.pi);
    }
    if (beatT < _preQrsFlatEnd) return 0.0;
    if (beatT < _qDipEnd) {
      final localT = (beatT - _preQrsFlatEnd) / (_qDipEnd - _preQrsFlatEnd);
      return _qDipAmplitude * math.sin(localT * math.pi);
    }
    if (beatT < _rSpikeEnd) {
      final localT = (beatT - _qDipEnd) / (_rSpikeEnd - _qDipEnd);
      return _rSpikeAmplitude * math.sin(localT * math.pi);
    }
    if (beatT < _sDipEnd) {
      final localT = (beatT - _rSpikeEnd) / (_sDipEnd - _rSpikeEnd);
      return _sDipAmplitude * math.sin(localT * math.pi);
    }
    if (beatT < _preTFlatEnd) return 0.0;
    if (beatT < _tWaveEnd) {
      final localT = (beatT - _preTFlatEnd) / (_tWaveEnd - _preTFlatEnd);
      return _tWaveAmplitude * math.sin(localT * math.pi);
    }
    return 0.0;
  }

  @override
  bool shouldRepaint(covariant HeartbeatLinePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.lineColor != lineColor;
  }
}
