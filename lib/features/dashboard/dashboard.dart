import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/features/dashboard/app_scaffold_with_fab_nav.dart';
import 'package:provider/provider.dart';
import 'package:libya_medical_record_system/data/providers/dashboard_provider.dart';

/// Navigation shell for the dashboard tabs.
/// Wraps the [navigationShell] in the mobile bottom-nav scaffold.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.navigationShell,
    this.onChatBotTap,
  });

  final StatefulNavigationShell navigationShell;
  final VoidCallback? onChatBotTap;

  @override
  Widget build(BuildContext context) {
    // Map branch index (0-5) to mobile nav index (0-3)
    // 0:Home->0, 1:Patients->0(fallback), 2:Records->1, 3:Experts->1(fallback), 4:Institutions->2, 5:Account->3
    final int mobileIndex = switch (navigationShell.currentIndex) {
      0 => 0,
      1 => 0, // Fallback if Patients reached
      2 => 1,
      3 => 1, // Fallback if Experts reached
      4 => 2,
      5 => 3,
      _ => 0,
    };

    return PopScope(
      canPop: navigationShell.currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (navigationShell.currentIndex != 0) {
            navigationShell.goBranch(0);
            context.read<DashboardProvider>().changeNavigationIndex(
              newIndex: 0,
            );
          }
        }
      },
      child: AppScaffoldWithFabNav(
        currentIndex: mobileIndex,
        onNavTap: (index) {
          // Map mobile nav index (0-3) back to branch index (0-5)
          final int branchIndex = switch (index) {
            0 => 0,
            1 => 2,
            2 => 4,
            3 => 5,
            _ => 0,
          };

          navigationShell.goBranch(
            branchIndex,
            initialLocation: branchIndex == navigationShell.currentIndex,
          );
          // Sync provider so other components know current tab
          context.read<DashboardProvider>().changeNavigationIndex(
            newIndex: branchIndex,
          );
        },
        onFabPressed:
            onChatBotTap ??
            () {
              snackBar(
                context: context,
                message: 'Chatbot coming soon',
                type: SnackTypeEnum.info,
              );
            },
        fabIcon: const FaIcon(FontAwesomeIcons.robot),
        items: const [
          NavItemData(
            icon: FaIcon(FontAwesomeIcons.house, size: 20),
            label: 'Home',
          ),
          NavItemData(
            icon: FaIcon(FontAwesomeIcons.notesMedical, size: 20),
            label: 'My Records',
          ),
          NavItemData(
            icon: FaIcon(FontAwesomeIcons.hospital, size: 20),
            label: 'Institutions',
          ),
          NavItemData(
            icon: FaIcon(FontAwesomeIcons.user, size: 20),
            label: 'Account',
          ),
        ],
        body: navigationShell,
      ),
    );
  }
}
