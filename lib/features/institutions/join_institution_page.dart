import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/core/shared/widgets/text_field_input_decoration.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';

class JoinInstitutionPage extends StatefulWidget {
  const JoinInstitutionPage({super.key, this.showHeader = true});

  final bool showHeader;

  @override
  State<JoinInstitutionPage> createState() => _JoinInstitutionPageState();
}

class _JoinInstitutionPageState extends State<JoinInstitutionPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  late final List<InstitutionModel> _allInstitutions;

  @override
  void initState() {
    super.initState();
    _allInstitutions = DemoData.institutions();
  }

  List<InstitutionModel> get _filteredInstitutions {
    if (_searchQuery.isEmpty) return _allInstitutions;
    return _allInstitutions.where((inst) {
      final name = inst.name.toLowerCase();
      final municipality = inst.municipality.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || municipality.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (widget.showHeader)
          const SliverPageHeader(
            title: 'Join Institution',
            subtitle: 'Connect with medical facilities to collaborate',
            icon: FontAwesomeIcons.hospital,
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(),
                const SizedBox(height: 32),
                Text(
                  'Available Institutions',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.sizeOf(context).width > 900
                      ? 3
                      : (MediaQuery.sizeOf(context).width > 600 ? 2 : 1),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 180,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  _buildInstitutionCard(_filteredInstitutions[index]),
              childCount: _filteredInstitutions.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    if (!widget.showHeader) return content;

    return Scaffold(backgroundColor: AppColors.background, body: content);
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: fieldDecoration(
          hint: 'Search by name or location...',
          prefixIcon: Icons.search_rounded,
        ).copyWith(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildInstitutionCard(InstitutionModel data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push(AppRoutes.institutionDetail, extra: data),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: FaIcon(
                          data.icon as dynamic,
                          size: 24,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: AppTextStyles.titleSmall.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            data.type,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  data.specialization,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: AppColors.textDisabled,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        data.municipality,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: _buildJoinButton(data.name),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJoinButton(String name) {
    return SizedBox(
      height: 40,
      child: AppPrimaryButton(
        label: 'Join',
        onPressed: () {
          snackBar(
            context: context,
            message: 'Join request sent to $name',
            type: SnackTypeEnum.success,
          );
        },
        inverted: false,
      ),
    );
  }
}
