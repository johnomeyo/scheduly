import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Divider(
            // Corrected from withValues to withValues
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              // Corrected from withValues to withValues
              color: theme.colorScheme.onSurface.withValues(alpha: 00.5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            // Corrected from withValues to withValues
            color: theme.colorScheme.onSurface.withValues(alpha: 00.3),
          ),
        ),
      ],
    );
  }
}