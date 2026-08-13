import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/medical_info_data.dart';
import 'package:libya_medical_record_system/features/auth/registration_form/medical_info_form.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditMedicalInfo extends StatefulWidget {
  const EditMedicalInfo({super.key});

  @override
  State<EditMedicalInfo> createState() => _EditMedicalInfoState();
}

class _EditMedicalInfoState extends State<EditMedicalInfo> {
  MedicalInfoData? _medicalInfo;

  @override
  void initState() {
    super.initState();
    _medicalInfo = DemoData.patientUser().medicalInfo;
  }

  void _handleMedicalInfoContinue(MedicalInfoData data) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPageHeader(
            title: 'Edit Medical Info',
            icon: FontAwesomeIcons.filePen,
          ),
          SliverToBoxAdapter(
            child: MedicalInfoForm(
              onContinue: _handleMedicalInfoContinue,
              initialData: _medicalInfo,
            ),
          ),
        ],
      ),
    );
  }
}
