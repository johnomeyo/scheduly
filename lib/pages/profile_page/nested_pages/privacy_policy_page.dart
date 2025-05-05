import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Text(
            'Privacy Policy',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use Scheduly.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          _SectionTitle(title: '1. Information We Collect'),
          _SectionText(
            'We may collect personal information you provide such as your name, email address, phone number, and booking details. We also collect usage data and device information to improve the app.',
          ),

          _SectionTitle(title: '2. How We Use Your Information'),
          _SectionText(
            'Your data helps us deliver, personalize, and improve our services. This includes managing appointments, sending notifications, and providing customer support.',
          ),

          _SectionTitle(title: '3. Sharing Your Information'),
          _SectionText(
            'We do not sell your personal data. We may share data with service providers who help us operate the app, or when required by law.',
          ),

          _SectionTitle(title: '4. Data Security'),
          _SectionText(
            'We use secure methods to protect your data, including encryption and access controls. However, no system is 100% secure, and we encourage users to take precautions as well.',
          ),

          _SectionTitle(title: '5. Your Choices'),
          _SectionText(
            'You can access, update, or delete your information by visiting your profile settings. You may also request account deletion by contacting our support team.',
          ),

          _SectionTitle(title: '6. Cookies and Analytics'),
          _SectionText(
            'Scheduly may use local storage or analytics tools to understand how users interact with the app. This helps us enhance performance and user experience.',
          ),

          _SectionTitle(title: '7. Children\'s Privacy'),
          _SectionText(
            'Scheduly is not intended for users under the age of 13. We do not knowingly collect personal data from children.',
          ),

          _SectionTitle(title: '8. Updates to This Policy'),
          _SectionText(
            'We may update this policy from time to time. You will be notified of significant changes via the app or email.',
          ),

          _SectionTitle(title: '9. Contact Us'),
          _SectionText(
            'For any questions or concerns about this policy, please contact us through the app or at privacy@scheduly.app.',
          ),

          const SizedBox(height: 40),
          Center(
            child: Text(
              'Last Updated: May 5, 2025',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;

  const _SectionText(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          height: 1.5,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
