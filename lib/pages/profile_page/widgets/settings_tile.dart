import 'package:flutter/material.dart';

// This is a highly reusable component
class SettingsTileWidget extends StatelessWidget {
  final ThemeData theme; // Could get theme from context instead if preferred
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsTileWidget({
    super.key,
    required this.theme, // Or remove and use Theme.of(context) below
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Alternative: Get theme here

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ), // Adjust padding
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(icon, color: theme.colorScheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium, // Use titleMedium for clarity
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          // Use bodyMedium
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      dense: true, // Makes tile more compact
      visualDensity: VisualDensity.compact,
    );
  }
}
