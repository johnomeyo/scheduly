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

          SectionTitle(title: '1. Overview'),
          SectionText(
            'Scheduly is a platform that connects users with local service providers. We facilitate booking, payment, and communication between both parties.',
          ),

          SectionTitle(title: '2. User Responsibilities'),
          SectionText(
            'You agree to provide accurate information when creating your account and during the booking process. You are responsible for maintaining the confidentiality of your login credentials.',
          ),
          SectionText(
            'Scheduly reserves the right to suspend or terminate accounts that violate our terms or misuse the platform.',
          ),

          SectionTitle(title: '3. Booking and Payments'),
          SectionText(
            'Bookings made through Scheduly are binding. Payment must be completed through the app using approved payment methods. Prices, availability, and service durations are determined by the service providers.',
          ),
          SectionText(
            'Scheduly may apply taxes or processing fees where applicable, which will be disclosed at checkout.',
          ),

          SectionTitle(title: '4. Cancellations and Refunds'),
          SectionText(
            'Cancellation policies are set by service providers. Please review the policy before booking. Some bookings may be non-refundable depending on the time of cancellation.',
          ),
          SectionText(
            'Scheduly is not responsible for any direct refunds unless stated otherwise. Disputes will be mediated but final responsibility lies with the provider.',
          ),

          SectionTitle(title: '5. Code of Conduct'),
          SectionText(
            'All users and providers are expected to behave respectfully and professionally. Harassment, abuse, or fraudulent behavior will result in suspension or legal action.',
          ),

          SectionTitle(title: '6. Limitation of Liability'),
          SectionText(
            'Scheduly is not liable for missed appointments, poor service quality, or disputes between users and providers. Our role is to facilitate discovery and booking, not to guarantee outcomes.',
          ),

          SectionTitle(title: '7. Privacy'),
          SectionText(
            'Your data is handled according to our Privacy Policy. By using the app, you consent to data processing as described in that policy.',
          ),

          SectionTitle(title: '8. Changes to Terms'),
          SectionText(
            'Scheduly may update these terms from time to time. We’ll notify users of any material changes. Continued use of the app after changes constitutes acceptance.',
          ),

          SectionTitle(title: '9. Contact Us'),
          SectionText(
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

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

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

class SectionText extends StatelessWidget {
  final String text;

  const SectionText(this.text, {super.key});

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
