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
    return AppScaffoldWithFabNav(
      currentIndex: navigationShell.currentIndex,
      onNavTap: (index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
        // Sync provider so other components know current tab
        context.read<DashboardProvider>().changeNavigationIndex(
          newIndex: index,
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
          icon: FaIcon(FontAwesomeIcons.userDoctor, size: 20),
          label: 'Experts',
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
    );
  }
}
