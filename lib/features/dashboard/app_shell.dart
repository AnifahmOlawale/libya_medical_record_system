import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/constants/breakpoints.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/features/dashboard/web_side_nav.dart';
import 'package:libya_medical_record_system/features/home/widgets/notification_bell.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _isSidebarOpen = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final String location = GoRouterState.of(context).matchedLocation;

    // Mobile App (Non-Web): Bottom Nav + No Shell
    if (!kIsWeb && width < Breakpoints.mobile) return widget.child;

    if (kIsWeb) {
      final bool isResponsiveCompact = width < 1100;

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
            onPressed: () {
              if (isResponsiveCompact) {
                _scaffoldKey.currentState?.openDrawer();
              } else {
                setState(() => _isSidebarOpen = !_isSidebarOpen);
              }
            },
          ),
          title: Text(
            'Libya Medical Record System',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.translate_rounded,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                snackBar(
                  context: context,
                  message: 'Language settings coming soon',
                );
              },
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const NotificationBell(),
              color: AppColors.textSecondary,
              onPressed: () {
                snackBar(
                  context: context,
                  message: 'Notifications coming soon',
                );
              },
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: AppColors.error),
              onPressed: () {
                context.go(AppRoutes.login);
              },
            ),
            const SizedBox(width: 16),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(height: 1, color: Colors.grey.shade100),
          ),
        ),
        drawer: isResponsiveCompact
            ? Drawer(
                width: 260,
                child: WebSideNav(
                  currentLocation: location,
                  onExpandRequested: () => Navigator.pop(context),
                ),
              )
            : null,
        body: Row(
          children: [
            if (!isResponsiveCompact) ...[
              WebSideNav(
                currentLocation: location,
                compact: !_isSidebarOpen,
                onExpandRequested: () => setState(() => _isSidebarOpen = true),
              ),
              const VerticalDivider(width: 1),
            ],
            Expanded(child: ClipRect(child: widget.child)),
          ],
        ),
      );
    }

    // Default persistent sidebar behavior for wide non-web screens (Desktop/Tablet App)
    final isCompactRail = width < Breakpoints.compactRail;

    return Scaffold(
      body: Row(
        children: [
          WebSideNav(
            currentLocation: location,
            compact: isCompactRail,
            onExpandRequested: () {}, // Not used in non-web persistent mode
          ),
          const VerticalDivider(width: 1),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
