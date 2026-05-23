import 'package:currency_app/common/extensions/currency_list_extension.dart';
import 'package:currency_app/common/theme/app_colors.dart';
import 'package:currency_app/common/widgets/field_label.dart';
import 'package:currency_app/feature/currency_converter/ui/components/currency_avatar.dart';
import 'package:currency_app/feature/currency_converter/ui/components/currency_picker_sheet.dart';
import 'package:currency_app/models/currency.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({
    super.key,
    required this.label,
    required this.currencies,
    required this.selectedCode,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final List<Currency> currencies;
  final String selectedCode;
  final ValueChanged<String> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final selected = currencies.byCode(selectedCode);
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled && currencies.isNotEmpty
                ? () => _showPicker(context)
                : null,
            borderRadius: BorderRadius.circular(18),
            child: Ink(
              decoration: BoxDecoration(
                color: AppColors.inputFill(context),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.cardBorder(context).withValues(alpha: 0.5),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    CurrencyAvatar(
                      code: selected?.displayCode ?? selectedCode.toUpperCase(),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selected?.displayCode ?? selectedCode.toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                              color: colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            selected?.name ?? 'Select currency',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: colors.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.unfold_more_rounded,
                      color: colors.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showPicker(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CurrencyPickerSheet(
        currencies: currencies,
        selectedCode: selectedCode,
      ),
    );

    if (result != null) onChanged(result);
  }
}
