import 'package:flutter/material.dart';

// Assume common credit card icons map or logic exists elsewhere if needed
// Map<String, IconData> cardBrandIcons = { 'Visa': Icons.credit_card, ... };

class PaymentMethodTileWidget extends StatelessWidget {
  final ThemeData theme;
  final Map<String, dynamic> paymentMethod;
  final VoidCallback onShowOptions;

  const PaymentMethodTileWidget({
    super.key,
    required this.theme,
    required this.paymentMethod,
    required this.onShowOptions,
  });

  // Helper to get a representative icon (can be expanded)
  IconData _getCardIcon(String? cardType) {
    // Simple example, expand with more card types or a dedicated package
    if (cardType?.toLowerCase() == 'visa') {
      return Icons.credit_card; // Replace with actual Visa icon if available
    }
    if (cardType?.toLowerCase() == 'mastercard') {
      return Icons.credit_card; // Replace with actual Mastercard icon
    }
    return Icons.credit_card; // Default
  }

  @override
  Widget build(BuildContext context) {
    final String cardType = paymentMethod['cardType'] ?? 'Card';
    final String lastFour = paymentMethod['lastFour'] ?? '••••';
    final String expiryDate = paymentMethod['expiryDate'] ?? 'N/A';
    final bool isDefault = paymentMethod['isDefault'] ?? false;
    final IconData cardIcon = _getCardIcon(cardType);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(cardIcon, color: theme.colorScheme.primary, size: 20),
      ),
      title: Row(
        children: [
          Text('$cardType ••••$lastFour', style: theme.textTheme.titleMedium),
          const SizedBox(width: 8),
          if (isDefault)
            Chip(
              label: Text('Default'),
              labelStyle: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              padding: EdgeInsets.zero, // Make chip compact
              visualDensity: VisualDensity.compact,
              side: BorderSide.none,
            ),
        ],
      ),
      subtitle: Text(
        'Expires $expiryDate',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
        onPressed: onShowOptions,
        tooltip: 'Options',
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
