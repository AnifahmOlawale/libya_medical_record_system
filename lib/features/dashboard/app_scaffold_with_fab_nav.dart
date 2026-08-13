import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'rounded_notched_rectangle.dart';

/// Data for a single bottom-nav destination.
///
/// [icon] takes a built [Widget] (e.g. `Icon(Icons.home)` or
/// `FaIcon(FontAwesomeIcons.house)`) rather than an [IconData] — this
/// keeps it icon-package-agnostic. Color/size don't need to be set on
/// the widget itself; [_NavItem] applies them via [IconTheme] so
/// selected/unselected coloring works the same regardless of which
/// icon widget is used.
class NavItemData {
  const NavItemData({required this.icon, required this.label, this.activeIcon});

  final Widget icon;

  /// Optional active-state variant. Falls back to [icon] if omitted.
  final Widget? activeIcon;

  final String label;
}

/// A [Scaffold] wrapper with a center-docked FAB sitting inside a
/// curved notch cut into the bottom nav bar — the same pattern used
/// by apps like MTN MyApp (FAB in the middle, bar curves around it).
///
/// The curve isn't hand-drawn: [BottomAppBar]'s `shape:
/// CircularNotchedRectangle()` automatically cuts that notch around
/// whatever FAB is docked via `floatingActionButtonLocation:
/// FloatingActionButtonLocation.centerDocked`.
///
/// [items] should have an even length — half render to the left of
/// the notch, half to the right.
///
/// ```dart
/// AppScaffoldWithFabNav(
///   body: const HomeTab(),
///   currentIndex: _index,
///   onNavTap: (i) => setState(() => _index = i),
///   onFabPressed: () => showModalBottomSheet(...),
///   fabIcon: Icons.qr_code_scanner_rounded,
///   items: const [
///     NavItemData(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
///     NavItemData(icon: Icons.play_circle_outline_rounded, label: 'Play'),
///     NavItemData(icon: Icons.help_outline_rounded, label: 'Help'),
///     NavItemData(icon: Icons.more_horiz_rounded, label: 'More'),
///   ],
/// )
/// ```
class AppScaffoldWithFabNav extends StatelessWidget {
  const AppScaffoldWithFabNav({
    super.key,
    required this.body,
    required this.items,
    required this.currentIndex,
    required this.onNavTap,
    required this.onFabPressed,
    this.fabIcon = const Icon(Icons.apps_rounded),
    this.appBar,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;

  /// Nav destinations. Must have an even length — split evenly around
  /// the notch.
  final List<NavItemData> items;

  final int currentIndex;
  final ValueChanged<int> onNavTap;

  final VoidCallback onFabPressed;

  /// Built icon widget for the FAB (e.g. `Icon(Icons.qr_code_scanner)`
  /// or `FaIcon(FontAwesomeIcons.robot)`).
  final Widget fabIcon;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: appBar,
        body: body,
      );
    }

    assert(
      items.length.isEven,
      'items should split evenly around the FAB notch',
    );
    final half = items.length ~/ 2;
    final leftItems = items.sublist(0, half);
    final rightItems = items.sublist(half);

    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: onFabPressed,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        shape: const CircleBorder(),
        elevation: 4,
        child: fabIcon,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // Rounded top corners + curved FAB notch together — see
        // rounded_notched_rectangle.dart for how the shape is built.
        shape: const RoundedNotchedRectangle(topCornerRadius: 24),
        notchMargin: 8,
        color: AppColors.surface,
        elevation: 8,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < leftItems.length; i++)
                _NavItem(
                  data: leftItems[i],
                  selected: currentIndex == i,
                  onTap: () => onNavTap(i),
                ),
              // Reserved gap so the notch has room to curve around
              // the FAB without the side items crowding it.
              const SizedBox(width: 56),
              for (var i = 0; i < rightItems.length; i++)
                _NavItem(
                  data: rightItems[i],
                  selected: currentIndex == half + i,
                  onTap: () => onNavTap(half + i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final NavItemData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme.merge(
              data: IconThemeData(color: color, size: 24),
              child: selected ? (data.activeIcon ?? data.icon) : data.icon,
            ),
            const SizedBox(height: 4),
            Text(
              data.label,
              style: AppTextStyles.labelSmall.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
