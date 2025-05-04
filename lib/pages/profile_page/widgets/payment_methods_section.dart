import 'package:flutter/material.dart';
import 'package:scheduly/pages/profile_page/widgets/payment_method_tile.dart';
import 'package:scheduly/pages/profile_page/widgets/settings_tile.dart';

class PaymentMethodsSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final VoidCallback onAddPaymentMethod;
  final ValueChanged<Map<String, dynamic>>
  onShowPaymentOptions; // Pass the specific method data

  const PaymentMethodsSectionWidget({
    super.key,
    required this.paymentMethods,
    required this.onAddPaymentMethod,
    required this.onShowPaymentOptions,
  });

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Use ListView.separated for cleaner list building with dividers
          if (paymentMethods.isNotEmpty)
            ListView.separated(
              shrinkWrap: true, // Important inside Column/SingleChildScrollView
              physics:
                  NeverScrollableScrollPhysics(), // Disable scrolling in the list itself
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                return PaymentMethodTileWidget(
                  theme: theme,
                  paymentMethod: method,
                  onShowOptions:
                      () =>
                          onShowPaymentOptions(method), // Pass specific method
                );
              },
              separatorBuilder: (context, index) => _buildDivider(context),
            )
          else
            Padding(
              // Show a message if no payment methods exist
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'No payment methods added.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Add Payment Method Tile (using the generic tile for consistency)
          _buildDivider(context), // Divider before the "Add" button
          SettingsTileWidget(
            theme: theme,
            icon: Icons.add,
            title: 'Add Payment Method',
            subtitle:
                'Link a new card or payment source', // More descriptive subtitle
            onTap: onAddPaymentMethod,
            // Customize leading specifically for 'Add' if needed
            // leading: CircleAvatar(...)
          ),
        ],
      ),
    );
  }
}
