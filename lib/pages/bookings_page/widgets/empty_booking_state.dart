
import 'package:flutter/material.dart';

/// A widget displayed when a list of bookings is empty.
///
/// It provides context-specific messages and an optional action button
/// based on whether it's for "Upcoming" or "Past" bookings.
class EmptyBookingsState extends StatelessWidget {
  /// True if this empty state is for upcoming bookings, false for past bookings.
  final bool isUpcoming;

  /// Callback triggered when the "Explore Services" button is pressed.
  /// This button is only shown if [isUpcoming] is true.
  final VoidCallback? onExploreServices;

  const EmptyBookingsState({
    super.key,
    required this.isUpcoming,
    this.onExploreServices,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isUpcoming ? Icons.event_note_sharp : Icons.history_toggle_off_sharp, // Updated icons
              size: 64, // Adjusted size
              color: theme.colorScheme.primary.withValues(alpha: 0.6), // Consistent opacity
            ),
            const SizedBox(height: 20),
            Text(
              isUpcoming ? 'No Upcoming Bookings' : 'No Past Bookings Found',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              isUpcoming
                  ? 'Ready to plan something? Book a service to see it here.'
                  : 'Your completed or cancelled bookings will appear in this section.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            if (isUpcoming && onExploreServices != null)
              ElevatedButton.icon(
                icon: const Icon(Icons.explore_outlined),
                label: const Text('Explore Services'),
                onPressed: onExploreServices,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }
}