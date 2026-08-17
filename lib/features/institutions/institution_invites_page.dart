import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/widgets/empty_state_widget.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class InstitutionInvitesPage extends StatelessWidget {
  const InstitutionInvitesPage({super.key, this.showHeader = true});

  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    final content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (showHeader)
          const SliverPageHeader(
            title: 'Institutional Invites',
            subtitle: 'Invitations from hospitals and clinics',
            icon: FontAwesomeIcons.envelopeOpenText,
          ),
        const EmptyStateSliver(
          icon: FontAwesomeIcons.envelopeOpenText,
          title: 'No Invites Found',
          subtitle: 'You haven\'t received any invitations to join institutions yet.',
        ),
      ],
    );

    if (!showHeader) return content;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: content,
    );
  }
}
