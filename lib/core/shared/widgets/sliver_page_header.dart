export 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class SliverPageHeader extends StatelessWidget {
  const SliverPageHeader({
    super.key,
    required this.title,
    this.icon,
    this.expandedHeight = 180,
    this.subtitle,
    this.extra,
    this.actions,
    this.centerExtraOnWeb = false,
    this.hideTitleOnWeb = false,
  });

  final String title;
  final dynamic icon;
  final double expandedHeight;
  final String? subtitle;
  final Widget? extra;
  final List<Widget>? actions;
  final bool centerExtraOnWeb;
  final bool hideTitleOnWeb;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
          child: Column(
            crossAxisAlignment: centerExtraOnWeb
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              if (!hideTitleOnWeb)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.displayMedium.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (actions != null) Row(children: actions!),
                  ],
                ),
              if (extra != null) ...[
                const SizedBox(height: 12),
                if (centerExtraOnWeb) Center(child: extra!) else extra!,
              ],
              if (!hideTitleOnWeb) ...[
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => context.pop(),
      ),
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
              ),
            ),
            if (icon != null)
              Positioned(
                right: -20,
                top: -20,
                child: icon is IconData
                    ? Icon(
                        icon as IconData,
                        size: 140,
                        color: Colors.white.withValues(alpha: 0.1),
                      )
                    : FaIcon(
                        icon as dynamic,
                        size: 140,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
              ),
            if (extra != null) Positioned(bottom: 60, left: 24, child: extra!),
          ],
        ),
      ),
    );
  }
}
