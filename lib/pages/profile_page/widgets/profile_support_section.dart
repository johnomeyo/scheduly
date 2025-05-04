import 'package:flutter/material.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  void _navigateToHelpCenter(BuildContext context) {
    // Replace with actual navigation logic
    // Navigator.pushNamed(context, '/help-center');
  }

  void _contactSupport(BuildContext context) {
    // Replace with actual contact support logic
    // Navigator.pushNamed(context, '/contact-support');
  }

  void _viewTermsOfService(BuildContext context) {
    // Replace with actual terms screen logic
    // Navigator.pushNamed(context, '/terms');
  }

  void _viewPrivacyPolicy(BuildContext context) {
    // Replace with actual privacy policy screen logic
    // Navigator.pushNamed(context, '/privacy');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          _SupportTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'Frequently asked questions and help guides',
            onTap: () => _navigateToHelpCenter(context),
          ),
          const Divider(indent: 72, height: 1),
          _SupportTile(
            icon: Icons.support_agent_outlined,
            title: 'Contact Support',
            subtitle: 'Get in touch with our customer service team',
            onTap: () => _contactSupport(context),
          ),
          const Divider(indent: 72, height: 1),
          _SupportTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            subtitle: 'Read our terms and conditions',
            onTap: () => _viewTermsOfService(context),
          ),
          const Divider(indent: 72, height: 1),
          _SupportTile(
            icon: Icons.policy_outlined,
            title: 'Privacy Policy',
            subtitle: 'Learn how we handle your data',
            onTap: () => _viewPrivacyPolicy(context),
          ),
        ],
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(icon, color: theme.colorScheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      onTap: onTap,
    );
  }
}
