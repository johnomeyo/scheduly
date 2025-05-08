import 'package:flutter/material.dart';
import 'package:scheduly/pages/profile_page/nested_pages/privacy_policy_page.dart'
    show PrivacyPolicyPage;

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  // Privacy setting states
  bool _locationServices = true;
  bool _dataCollection = true;
  bool _personalization = true;
  bool _marketingEmails = false;
  bool _appNotifications = true;
  bool _thirdPartySharing = false;
  bool _analyticsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Settings'), elevation: 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const PrivacyHeader(),
            const SizedBox(height: 24.0),

            // Data Collection Section
            SettingsSection(
              title: 'Data Collection',
              children: [
                SettingsToggle(
                  title: 'Location Services',
                  subtitle:
                      'Allow app to access your location for nearby service providers',
                  value: _locationServices,
                  onChanged: (value) {
                    setState(() {
                      _locationServices = value;
                    });
                  },
                ),
                SettingsToggle(
                  title: 'Usage Data Collection',
                  subtitle:
                      'Allow collection of app usage data to improve services',
                  value: _dataCollection,
                  onChanged: (value) {
                    setState(() {
                      _dataCollection = value;
                    });
                  },
                ),
                SettingsToggle(
                  title: 'Analytics',
                  subtitle:
                      'Help us improve by sharing anonymous usage statistics',
                  value: _analyticsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _analyticsEnabled = value;
                    });
                  },
                ),
              ],
            ),

            Divider(color: theme.dividerColor),

            // Personalization Section
            SettingsSection(
              title: 'Personalization',
              children: [
                SettingsToggle(
                  title: 'Personalized Experience',
                  subtitle:
                      'Tailor app experience based on your usage patterns',
                  value: _personalization,
                  onChanged: (value) {
                    setState(() {
                      _personalization = value;
                    });
                  },
                ),
                SettingsToggle(
                  title: 'Third-Party Data Sharing',
                  subtitle:
                      'Share data with trusted partners to enhance services',
                  value: _thirdPartySharing,
                  onChanged: (value) {
                    setState(() {
                      _thirdPartySharing = value;
                    });
                  },
                ),
              ],
            ),

            Divider(color: theme.dividerColor),

            // Communications Section
            SettingsSection(
              title: 'Communications',
              children: [
                SettingsToggle(
                  title: 'Marketing Emails',
                  subtitle: 'Receive promotional offers and updates via email',
                  value: _marketingEmails,
                  onChanged: (value) {
                    setState(() {
                      _marketingEmails = value;
                    });
                  },
                ),
                SettingsToggle(
                  title: 'App Notifications',
                  subtitle: 'Receive booking updates and reminders',
                  value: _appNotifications,
                  onChanged: (value) {
                    setState(() {
                      _appNotifications = value;
                    });
                  },
                ),
              ],
            ),

            Divider(color: theme.dividerColor),

            // Data Management Section
            SettingsSection(
              title: 'Data Management',
              children: [
                DataManagementCard(
                  title: 'Download Your Data',
                  subtitle: 'Request a copy of all your personal data',
                  icon: Icons.download,
                  onTap: () {
                    // Implementation for downloading data
                    _showActionConfirmation(
                      'Download Your Data',
                      'We will prepare your data and send it to your registered email within 48 hours.',
                    );
                  },
                ),
                DataManagementCard(
                  title: 'Delete Account',
                  subtitle:
                      'Permanently remove your account and all associated data',
                  icon: Icons.delete_forever,
                  isDestructive: true,
                  onTap: () {
                    // Implementation for account deletion
                    _showDeleteAccountDialog();
                  },
                ),
              ],
            ),

            const SizedBox(height: 24.0),

            // Privacy Policy Link
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to privacy policy
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage(),
                    ),
                  );
                },
                child: Text(
                  'View Privacy Policy',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  void _showActionConfirmation(String title, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showActionConfirmation(
                    'Account Deletion Request',
                    'Your account deletion request has been received. Your account will be deleted within 30 days.',
                  );
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
          ),
    );
  }
}

class PrivacyHeader extends StatelessWidget {
  const PrivacyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Privacy & Data Settings', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8.0),
        Text(
          'Control how your information is used and shared within the app.',
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(title, style: theme.textTheme.titleLarge),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}

class SettingsToggle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggle({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SwitchListTile(
        title: Text(title, style: theme.textTheme.bodyLarge),
        subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
        value: value,
        onChanged: onChanged,
        dense: true,
        activeColor: theme.colorScheme.primary,
      ),
    );
  }
}

class DataManagementCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const DataManagementCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        isDestructive ? theme.colorScheme.error : theme.colorScheme.primary;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: textColor, size: 28.0),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
