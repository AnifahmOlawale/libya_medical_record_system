import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/features/auth/registration_form/professional_info_form.dart';

class ProfessionalExperiencePage extends StatelessWidget {
  const ProfessionalExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Using demo data for now
    final initialData = DemoData.currentUser().professionalInfo;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPageHeader(
            title: 'Professional Experience',
            subtitle: 'Manage your clinical experience and working hours',
            icon: FontAwesomeIcons.userDoctor,
          ),
          SliverToBoxAdapter(
            child: ProfessionalInfoForm(
              initialData: initialData,
              onContinue: (data) {
                // TODO: Save updated professional info
                snackBar(
                  context: context,
                  message: 'Professional experience updated successfully',
                  type: SnackTypeEnum.success,
                );
                // On detailed pages, usually we don't pop() if it's a save action, 
                // but keeping consistency with the previous form logic.
              },
            ),
          ),
        ],
      ),
    );
  }
}
