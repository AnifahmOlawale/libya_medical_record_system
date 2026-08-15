import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';

class QrCodeDisplay extends StatelessWidget {
  const QrCodeDisplay({
    super.key,
    required this.token,
    this.qrSize = 200,
  });

  final String token;
  final double qrSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // QR Code Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: SizedBox(
            width: qrSize,
            height: qrSize,
            child: PrettyQrView.data(
              data: token,
              decoration: const PrettyQrDecoration(
                shape: PrettyQrSmoothSymbol(color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Token Display Box with Copy Button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  token,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: token.length > 20 ? 0.5 : 2,
                    fontSize: token.length > 25 ? 12 : 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.copy_rounded, size: 20),
                color: AppColors.primary,
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: token));
                  snackBar(
                    context: context,
                    message: 'Token copied to clipboard',
                    type: SnackTypeEnum.success,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
