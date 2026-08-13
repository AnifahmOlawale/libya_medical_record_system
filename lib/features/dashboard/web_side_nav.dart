import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/providers/dashboard_provider.dart';

/// Persistent side navigation shown on web/wide layouts. Wraps `child`
/// pages from the ShellRoute — never rebuilt on navigation, so it
/// never loses its own state (scroll position, expanded sections).
///
/// [compact] switches to an icon-only rail (no labels, no sub-lists)
/// for narrower browser windows. Expansion state for "Records" /
/// "Profile" is derived from the current URL, not local state, so a
/// direct link or refresh lands with the right section already open.
class WebSideNav extends StatelessWidget {
  const WebSideNav({
    super.key,
    required this.currentLocation,
    this.compact = false,
    this.onExpandRequested,
  });

  final String currentLocation;
  final bool compact;
  final VoidCallback? onExpandRequested;

  static const _recordsSubRoutes = [
    ('Medical Information', FontAwesomeIcons.idCardClip, AppRoutes.medicalInfo),
    ('Vitals', FontAwesomeIcons.heartPulse, AppRoutes.vitals),
    ('Allergies', FontAwesomeIcons.triangleExclamation, AppRoutes.allergies),
    ('Medications', FontAwesomeIcons.pills, AppRoutes.medications),
    ('Diagnoses', FontAwesomeIcons.stethoscope, AppRoutes.diagnoses),
    ('Lab Tests', FontAwesomeIcons.flaskVial, AppRoutes.labTests),
    ('Medical Visits', FontAwesomeIcons.hospital, AppRoutes.medicalVisits),
    ('Radiology', FontAwesomeIcons.xRay, AppRoutes.radiology),
    ('Pathology', FontAwesomeIcons.microscope, AppRoutes.pathology),
    ('Surgeries', FontAwesomeIcons.scissors, AppRoutes.surgeries),
    ('Immunizations', FontAwesomeIcons.syringe, AppRoutes.immunizations),
    ('Documents', FontAwesomeIcons.fileLines, AppRoutes.documents),
  ];

  static const _profileSubRoutes = [
    ('Edit Profile', FontAwesomeIcons.userPen, AppRoutes.editProfile),
    ('Permissions', FontAwesomeIcons.lock, AppRoutes.permissions),
  ];

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _CompactRail(
        currentLocation: currentLocation,
        onExpandRequested: onExpandRequested,
      );
    }

    final theme = Theme.of(context);
    final userType = context.watch<DashboardProvider>().userType;

    return Material(
      color: theme.colorScheme.surface,
      child: SizedBox(
        width: 260,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            _NavTile(
              icon: Icons.grid_view_rounded,
              label: 'Dashboard',
              selected:
                  currentLocation == AppRoutes.home ||
                  currentLocation == AppRoutes.dashboard,
              onTap: () => context.go(AppRoutes.home),
            ),
            _ExpandableSection(
              icon: FontAwesomeIcons.notesMedical,
              label: 'Records',
              selected:
                  currentLocation.startsWith('/records') ||
                  currentLocation == AppRoutes.records,
              expanded:
                  currentLocation.startsWith('/records') ||
                  currentLocation == AppRoutes.records,
              children: [
                for (final (label, icon, route) in _recordsSubRoutes)
                  _SubTile(
                    label: label,
                    icon: icon,
                    route: route,
                    currentLocation: currentLocation,
                  ),
              ],
            ),
            _NavTile(
              icon: FontAwesomeIcons.userDoctor,
              label: 'Experts',
              selected: currentLocation == AppRoutes.experts,
              onTap: () => context.go(AppRoutes.experts),
            ),
            _ExpandableSection(
              icon: FontAwesomeIcons.user,
              label: 'Profile',
              selected: currentLocation == AppRoutes.profile,
              expanded: currentLocation == AppRoutes.profile,
              children: [
                _SubTile(
                  label: 'My Profile',
                  icon: FontAwesomeIcons.circleUser,
                  route: userType == UserType.healthcareProfessional
                      ? AppRoutes.medicalStaffProfile
                      : AppRoutes.usersProfile,
                  currentLocation: currentLocation,
                ),
                for (final (label, icon, route) in _profileSubRoutes)
                  _SubTile(
                    label: label,
                    icon: icon,
                    route: route,
                    currentLocation: currentLocation,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Narrow-window fallback: icons only, no sub-lists. Tapping a
/// section icon jumps to its landing page (e.g. RecordsPage) rather
/// than trying to show a flyout — keeps this variant simple.
class _CompactRail extends StatelessWidget {
  const _CompactRail({required this.currentLocation, this.onExpandRequested});

  final String currentLocation;
  final VoidCallback? onExpandRequested;

  @override
  Widget build(BuildContext context) {
    final userType = context.watch<DashboardProvider>().userType;

    return NavigationRail(
      selectedIndex: switch (currentLocation) {
        AppRoutes.home => 0,
        AppRoutes.records => 1,
        AppRoutes.experts => 2,
        AppRoutes.profile => 3,
        _ when currentLocation.startsWith('/records') => 1,
        _ when currentLocation.startsWith('/profile') => 3,
        _ => null,
      },
      onDestinationSelected: (index) {
        if ((index == 1 || index == 3) && onExpandRequested != null) {
          onExpandRequested!();
        } else {
          context.go(switch (index) {
            0 => AppRoutes.home,
            1 => AppRoutes.records,
            2 => AppRoutes.experts,
            3 => AppRoutes.profile,
            _ => AppRoutes.home,
          });
        }
      },
      labelType: NavigationRailLabelType.none,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.grid_view_rounded, size: 18),
          label: Text('Dashboard'),
        ),
        NavigationRailDestination(
          icon: FaIcon(FontAwesomeIcons.notesMedical, size: 18),
          label: Text('Records'),
        ),
        NavigationRailDestination(
          icon: FaIcon(FontAwesomeIcons.userDoctor, size: 18),
          label: Text('Experts'),
        ),
        NavigationRailDestination(
          icon: FaIcon(FontAwesomeIcons.user, size: 18),
          label: Text('Profile'),
        ),
      ],
    );
  }
}

/// A single, non-expandable nav item (e.g. "Home", "Experts").
class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final dynamic icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return ListTile(
      leading: icon is IconData
          ? Icon(icon, size: 18, color: color)
          : FaIcon(icon, size: 18, color: color),
      title: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: selected,
      selectedTileColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.08),
      onTap: onTap,
    );
  }
}

/// A parent item that expands to reveal a sub-list (e.g. "Records" ->
/// Vitals, Allergies, Medications...). `expanded` is driven by the
/// current URL, not local toggle state.
class _ExpandableSection extends StatelessWidget {
  const _ExpandableSection({
    required this.icon,
    required this.label,
    required this.expanded,
    required this.children,
    this.selected = false,
  }) : onHeaderTap = null;

  final dynamic icon;
  final String label;
  final bool expanded;
  final bool selected;
  final List<Widget> children;
  final VoidCallback? onHeaderTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        // Forces ExpansionTile to re-sync its open/closed state whenever
        // `expanded` flips (e.g. user navigates via URL bar), instead of
        // only respecting the value it was first built with.
        key: ValueKey('section-$label-$expanded'),
        initiallyExpanded: expanded,
        shape: const Border(), // Removes top/bottom border when expanded
        collapsedShape:
            const Border(), // Removes top/bottom border when collapsed
        iconColor: color,
        textColor: color,
        collapsedIconColor: color,
        collapsedTextColor: color,
        leading: icon is IconData
            ? Icon(icon, size: 18, color: color)
            : FaIcon(icon, size: 18, color: color),
        title: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
        onExpansionChanged: (isExpanding) {
          if (isExpanding && onHeaderTap != null) {
            onHeaderTap!();
          }
        },
        children: children,
      ),
    );
  }
}

/// A single sub-item inside an expanded section (e.g. "Vitals" under
/// "Records").
class _SubTile extends StatelessWidget {
  const _SubTile({
    required this.label,
    required this.icon,
    required this.route,
    required this.currentLocation,
  });

  final String label;
  final dynamic icon;
  final String route;
  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    final selected = currentLocation == route;
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 40, right: 16),
      leading: icon is IconData
          ? Icon(icon, size: 15, color: color)
          : FaIcon(icon, size: 15, color: color),
      title: Text(label, style: TextStyle(fontSize: 13.5, color: color)),
      selected: selected,
      selectedTileColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.08),
      onTap: () => context.go(route),
    );
  }
}
