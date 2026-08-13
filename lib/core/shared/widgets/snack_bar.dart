import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';

OverlayEntry? _activeSnackEntry;

enum SnackTypeEnum { success, error, warning, info, loading }

void snackBar({
  required BuildContext context,
  required String message,
  SnackTypeEnum type = SnackTypeEnum.info,
  Color? colour,
  Color? textColor,
  IconData? icon,
  bool fromTop = false,
  VoidCallback? action,
  String? actionLabel,
  Duration duration = const Duration(seconds: 3),
}) {
  _activeSnackEntry?.remove();
  _activeSnackEntry = null;

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _AnimatedSnackBar(
      message: message,
      bgColor: colour ?? _colorFor(type),
      icon: icon ?? _iconFor(type),
      textColor: textColor ?? Colors.white,
      isLoading: type == SnackTypeEnum.loading,
      fromTop: fromTop,
      actionLabel: actionLabel,
      action: action,
      duration: duration,
      onDismiss: () {
        entry.remove();
        if (_activeSnackEntry == entry) _activeSnackEntry = null;
      },
    ),
  );

  _activeSnackEntry = entry;
  Overlay.of(context).insert(entry);
}

Color _colorFor(SnackTypeEnum type) => switch (type) {
  SnackTypeEnum.success => AppColors.primary,
  SnackTypeEnum.error => AppColors.error,
  SnackTypeEnum.warning => AppColors.warning,
  SnackTypeEnum.info => AppColors.info,
  SnackTypeEnum.loading => AppColors.primary,
};

IconData _iconFor(SnackTypeEnum type) => switch (type) {
  SnackTypeEnum.success => Icons.check_circle_rounded,
  SnackTypeEnum.error => Icons.error_rounded,
  SnackTypeEnum.warning => Icons.warning_rounded,
  SnackTypeEnum.info => Icons.info_rounded,
  SnackTypeEnum.loading => Icons.cloud_upload_rounded,
};

class _AnimatedSnackBar extends StatefulWidget {
  final String message;
  final Color bgColor;
  final Color textColor;
  final IconData icon;
  final bool isLoading;
  final bool fromTop;
  final String? actionLabel;
  final VoidCallback? action;
  final Duration duration;
  final VoidCallback onDismiss;

  const _AnimatedSnackBar({
    required this.message,
    required this.bgColor,
    required this.textColor,
    required this.icon,
    required this.isLoading,
    required this.fromTop,
    required this.duration,
    required this.onDismiss,
    this.actionLabel,
    this.action,
  });

  @override
  State<_AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<_AnimatedSnackBar>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _spinController;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _slide =
        Tween<Offset>(
          begin: Offset(0, widget.fromTop ? -1.5 : 1.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeIn));

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    if (widget.isLoading) {
      _spinController.repeat();
    }

    _slideController.forward();

    if (!widget.isLoading) {
      Future.delayed(widget.duration, _dismiss);
    }
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _slideController.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.fromTop ? MediaQuery.of(context).padding.top + 12 : null,
      bottom: widget.fromTop
          ? null
          : MediaQuery.of(context).padding.bottom + 12,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (widget.isLoading)
                    RotationTransition(
                      turns: _spinController,
                      child: Icon(
                        Icons.autorenew_rounded,
                        color: widget.textColor,
                        size: 22,
                      ),
                    )
                  else
                    Icon(widget.icon, color: widget.textColor, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message.trim(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: widget.textColor,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (widget.action != null && widget.actionLabel != null) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        widget.action!();
                        _dismiss();
                      },
                      child: Text(
                        widget.actionLabel!,
                        style: TextStyle(
                          color: widget.textColor == Colors.white
                              ? Colors.amberAccent
                              : AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  if (widget.fromTop) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _dismiss,
                      child: Icon(
                        Icons.close_rounded,
                        color: widget.textColor,
                        size: 18,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
