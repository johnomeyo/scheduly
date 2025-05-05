import 'package:flutter/material.dart';
import 'package:scheduly/pages/booking_page/booking_page.dart';

class SpecialOfferDetailsPage extends StatelessWidget {
  const SpecialOfferDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Special Offer')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Hero Banner
          Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Icon(Icons.spa, size: 100, color: theme.colorScheme.onPrimary.withValues(alpha: 0.2)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        '20% OFF',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'On your first spa booking',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Offer Details
          Text(
            'Wellness Spa Center',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Enjoy a rejuvenating experience at our spa. As a first-time guest, '
            'you’ll receive a 20% discount on all treatments booked before June 30, 2025.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Promo Code: FIRSTSPA20',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Valid Until: June 30, 2025',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:0.6),
            ),
          ),
          const SizedBox(height: 32),

          // Booking CTA
          FilledButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => const BookingPage(),
              ));
            },
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}
