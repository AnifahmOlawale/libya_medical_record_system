import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/features/auth/registration_form/institution_form.dart';

class EstablishInstitutionPage extends StatelessWidget {
  const EstablishInstitutionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPageHeader(
            title: 'Register Medical Institution',
            subtitle: 'Establish and manage your healthcare facility',
            icon: FontAwesomeIcons.hospital,
          ),
          SliverToBoxAdapter(
            child: InstitutionForm(
              onContinue: (data) {
                // TODO: Implementation for establishing the institution
                snackBar(
                  context: context,
                  message: 'Institution registration submitted successfully',
                  type: SnackTypeEnum.success,
                );
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
