
import 'package:flutter/material.dart';

class ServiceHeader extends StatelessWidget {
  final String serviceName;
  final IconData icon;
  final ThemeData theme;

  const ServiceHeader({
    super.key,
    required this.serviceName,
    required this.icon,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: theme.colorScheme.primary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48, color: theme.colorScheme.onPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            serviceName,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
