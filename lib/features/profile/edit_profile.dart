import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/personal_info_data.dart';
import 'package:libya_medical_record_system/features/auth/registration_form/personal_info_form.dart';

class EditProfileInfo extends StatefulWidget {
  const EditProfileInfo({super.key});

  @override
  State<EditProfileInfo> createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {
  PersonalInfoData? _personalInfo;

  @override
  void initState() {
    super.initState();
    _personalInfo = DemoData.currentUser().personalInfo;
  }

  void _handlePersonalInfoContinue(PersonalInfoData data) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: kIsWeb
          ? null
          : AppBar(
              title: const Text('Edit Profile'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
      body: SafeArea(
        child: PersonalInfoForm(
          onContinue: _handlePersonalInfoContinue,
          initialData: _personalInfo,
          buttonText: "Save Changes",
        ),
      ),
    );
  }
}
