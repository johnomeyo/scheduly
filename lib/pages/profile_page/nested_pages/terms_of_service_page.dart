import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Text(
            'Welcome to Scheduly!',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'By using the Scheduly app, you agree to the following Terms of Service. Please read them carefully before booking or offering services through the platform.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          _SectionTitle(title: '1. Overview'),
          _SectionText(
            'Scheduly is a platform that connects users with local service providers. We facilitate booking, payment, and communication between both parties.',
          ),

          _SectionTitle(title: '2. User Responsibilities'),
          _SectionText(
            'You agree to provide accurate information when creating your account and during the booking process. You are responsible for maintaining the confidentiality of your login credentials.',
          ),
          _SectionText(
            'Scheduly reserves the right to suspend or terminate accounts that violate our terms or misuse the platform.',
          ),

          _SectionTitle(title: '3. Booking and Payments'),
          _SectionText(
            'Bookings made through Scheduly are binding. Payment must be completed through the app using approved payment methods. Prices, availability, and service durations are determined by the service providers.',
          ),
          _SectionText(
            'Scheduly may apply taxes or processing fees where applicable, which will be disclosed at checkout.',
          ),

          _SectionTitle(title: '4. Cancellations and Refunds'),
          _SectionText(
            'Cancellation policies are set by service providers. Please review the policy before booking. Some bookings may be non-refundable depending on the time of cancellation.',
          ),
          _SectionText(
            'Scheduly is not responsible for any direct refunds unless stated otherwise. Disputes will be mediated but final responsibility lies with the provider.',
          ),

          _SectionTitle(title: '5. Code of Conduct'),
          _SectionText(
            'All users and providers are expected to behave respectfully and professionally. Harassment, abuse, or fraudulent behavior will result in suspension or legal action.',
          ),

          _SectionTitle(title: '6. Limitation of Liability'),
          _SectionText(
            'Scheduly is not liable for missed appointments, poor service quality, or disputes between users and providers. Our role is to facilitate discovery and booking, not to guarantee outcomes.',
          ),

          _SectionTitle(title: '7. Privacy'),
          _SectionText(
            'Your data is handled according to our Privacy Policy. By using the app, you consent to data processing as described in that policy.',
          ),

          _SectionTitle(title: '8. Changes to Terms'),
          _SectionText(
            'Scheduly may update these terms from time to time. We’ll notify users of any material changes. Continued use of the app after changes constitutes acceptance.',
          ),

          _SectionTitle(title: '9. Contact Us'),
          _SectionText(
            'If you have any questions about these Terms, please contact our support team through the app or at support@scheduly.app.',
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
