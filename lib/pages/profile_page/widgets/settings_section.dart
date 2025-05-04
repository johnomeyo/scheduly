import 'package:flutter/material.dart';
import 'package:scheduly/pages/profile_page/widgets/settings_tile.dart';

class SettingsSectionWidget extends StatelessWidget {
  final bool notificationsEnabled;
  final ValueChanged<bool> onNotificationsChanged;
  final VoidCallback onTapPrivacy;
  final VoidCallback onTapChangePassword;

  const SettingsSectionWidget({
    super.key,
    required this.notificationsEnabled,
    required this.onNotificationsChanged,
    required this.onTapPrivacy,
    required this.onTapChangePassword,
  });

  // Reusable divider specific to this section's card style
  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16, // Standard indent
      endIndent: 16,
      color: Theme.of(context).colorScheme.outline.withValues(alpha:0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use Card for grouping, apply theme styling
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0, // Keep flat design consistent
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      clipBehavior: Clip.antiAlias, // Clip content to rounded corners
      child: Column(
        children: [
          // Use the dedicated SettingsTileWidget
          SettingsTileWidget(
            theme: theme, // Pass theme or let tile get it itself
            title: 'Notifications',
            subtitle: 'Receive booking updates and reminders',
            icon: Icons.notifications_outlined,
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: onNotificationsChanged, // Directly use the passed callback
              activeColor: theme.colorScheme.primary,
            ),
            // No onTap needed for the row itself if Switch handles interaction
          ),
          _buildDivider(context),
          SettingsTileWidget(
            theme: theme,
            title: 'Privacy Settings',
            subtitle: 'Manage your data and privacy preferences',
            icon: Icons.privacy_tip_outlined,
            onTap: onTapPrivacy, // Pass the callback
          ),
          _buildDivider(context),
          SettingsTileWidget(
            theme: theme,
            title: 'Change Password',
            subtitle: 'Update your account password',
            icon: Icons.lock_outline,
            onTap: onTapChangePassword, // Pass the callback
          ),
        ],
      ),
    );
  }
}