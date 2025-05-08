
import 'package:flutter/material.dart';

/// A reusable widget to display a labeled detail with an icon.
///
/// Typically used to show pieces of information like service name, date, or time.
class DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const DetailItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align icon and text nicely
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary), // Slightly larger icon
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.65), // Standard opacity
                ),
              ),
              const SizedBox(height: 2), // Small spacing
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, // Slightly bolder value
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2, // Allow up to two lines for longer values
              ),
            ],
          ),
        ),
      ],
    );
  }
}