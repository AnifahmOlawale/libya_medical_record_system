import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';

/// Persistent side navigation shown on web/wide layouts. Wraps `child`
/// pages from the ShellRoute — never rebuilt on navigation, so it
/// never loses its own state (scroll position, expanded sections).
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

  static final _recordsSubRoutes = [
    ('Medical Information', FontAwesomeIcons.idCardClip, AppRoutes.medicalInfo),
    ('Vitals', FontAwesomeIcons.heartPulse, AppRoutes.vitals),
    ('Allergies', FontAwesomeIcons.triangleExclamation, AppRoutes.allergies),
    ('Medications', FontAwesomeIcons.pills, AppRoutes.medications),
    ('Dental Records', FontAwesomeIcons.tooth, AppRoutes.dentalRecords),
    ('Diagnoses', FontAwesomeIcons.stethoscope, AppRoutes.diagnoses),
    ('Lab Tests', FontAwesomeIcons.flaskVial, AppRoutes.labTests),
    ('Medical Visits', FontAwesomeIcons.hospital, AppRoutes.medicalVisits),
    ('Radiology', FontAwesomeIcons.xRay, AppRoutes.radiology),
    ('Pathology', FontAwesomeIcons.microscope, AppRoutes.pathology),
    ('Surgeries', FontAwesomeIcons.scissors, AppRoutes.surgeries),
    ('Immunizations', FontAwesomeIcons.syringe, AppRoutes.immunizations),
    ('Documents', FontAwesomeIcons.fileLines, AppRoutes.documents),
  ];

  static final _institutionSubRoutes = [
    (
      'My Institutions',
      FontAwesomeIcons.buildingUser,
      AppRoutes.myInstitutions,
    ),
    (
      'Affiliations',
      FontAwesomeIcons.handHoldingMedical,
      AppRoutes.joinInstitution,
    ),
  ];

  static final _profileSubRoutes = [
    ('Edit Profile', FontAwesomeIcons.userPen, AppRoutes.editProfile),
    (
      'Professional Experience',
      FontAwesomeIcons.briefcase,
      AppRoutes.professionalExperience,
    ),
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
            _NavTile(
              icon: FontAwesomeIcons.hospitalUser,
              label: 'My Patients',
              selected: currentLocation == AppRoutes.myPatients,
              onTap: () => context.go(AppRoutes.myPatients),
            ),
            _ExpandableSection(
              icon: FontAwesomeIcons.notesMedical,
              label: 'My Records',
              selected:
                  currentLocation == AppRoutes.records ||
                  currentLocation.startsWith('/records'),
              expanded:
                  currentLocation == AppRoutes.records ||
                  currentLocation.startsWith('/records'),
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
              label: 'Medical Experts',
              selected: currentLocation == AppRoutes.experts,
              onTap: () => context.go(AppRoutes.experts),
            ),
            _ExpandableSection(
              icon: FontAwesomeIcons.hospital,
              label: 'Medical Institutions',
              selected:
                  currentLocation == AppRoutes.myInstitutions ||
                  currentLocation == AppRoutes.joinInstitution ||
                  currentLocation == AppRoutes.affiliatedInstitutions ||
                  currentLocation == AppRoutes.institutionRequests ||
                  currentLocation.startsWith(AppRoutes.joinInstitution),
              expanded:
                  currentLocation == AppRoutes.myInstitutions ||
                  currentLocation == AppRoutes.joinInstitution ||
                  currentLocation == AppRoutes.affiliatedInstitutions ||
                  currentLocation == AppRoutes.institutionRequests ||
                  currentLocation.startsWith(AppRoutes.joinInstitution),
              children: [
                for (final (label, icon, route) in _institutionSubRoutes)
                  _SubTile(
                    label: label,
                    icon: icon,
                    route: route,
                    currentLocation: currentLocation,
                  ),
              ],
            ),
            _ExpandableSection(
              icon: FontAwesomeIcons.user,
              label: 'Account',
              selected:
                  currentLocation == AppRoutes.profile ||
                  currentLocation.startsWith('/profile'),
              expanded:
                  currentLocation == AppRoutes.profile ||
                  currentLocation.startsWith('/profile'),
              children: [
                _SubTile(
                  label: 'My Profile',
                  icon: FontAwesomeIcons.circleUser,
                  route: AppRoutes.usersProfile,
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

class _CompactRail extends StatelessWidget {
  const _CompactRail({required this.currentLocation, this.onExpandRequested});

  final String currentLocation;
  final VoidCallback? onExpandRequested;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: switch (currentLocation) {
        AppRoutes.home => 0,
        AppRoutes.myPatients => 1,
        AppRoutes.records => 2,
        AppRoutes.experts => 3,
        AppRoutes.myInstitutions ||
        AppRoutes.joinInstitution ||
        AppRoutes.affiliatedInstitutions ||
        AppRoutes.institutionRequests => 4,
        AppRoutes.profile => 5,
        _ when currentLocation.startsWith('/records') => 2,
        _ when currentLocation.startsWith('/profile') => 5,
        _ when currentLocation.startsWith('/dashboard/my-institutions') => 4,
        _ when currentLocation.startsWith('/dashboard/join-institution') => 4,
        _ => null,
      },
      onDestinationSelected: (index) {
        if ((index == 2 || index == 4 || index == 5) &&
            onExpandRequested != null) {
          onExpandRequested!();
        } else {
          context.go(switch (index) {
            0 => AppRoutes.home,
            1 => AppRoutes.myPatients,
            2 => AppRoutes.records,
            3 => AppRoutes.experts,
            4 => AppRoutes.myInstitutions,
            5 => AppRoutes.profile,
            _ => AppRoutes.home,
          });
        }
      },
      labelType: NavigationRailLabelType.none,
      destinations: [
        const NavigationRailDestination(
          icon: Icon(Icons.grid_view_rounded, size: 18),
          label: Text('Dashboard'),
        ),
        const NavigationRailDestination(
          icon: FaIcon(FontAwesomeIcons.hospitalUser, size: 18),
          label: Text('My Patients'),
        ),
        const NavigationRailDestination(
          icon: FaIcon(FontAwesomeIcons.notesMedical, size: 18),
          label: Text('Records'),
        ),
        const NavigationRailDestination(
          icon: FaIcon(FontAwesomeIcons.userDoctor, size: 18),
          label: Text('Medical Experts'),
        ),
        const NavigationRailDestination(
          icon: FaIcon(FontAwesomeIcons.hospital, size: 18),
          label: Text('Institutions'),
        ),
        const NavigationRailDestination(
          icon: FaIcon(FontAwesomeIcons.user, size: 18),
          label: Text('Account'),
        ),
      ],
    );
  }
}

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
        key: ValueKey('section-$label-$expanded'),
        initiallyExpanded: expanded,
        shape: const Border(),
        collapsedShape: const Border(),
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
