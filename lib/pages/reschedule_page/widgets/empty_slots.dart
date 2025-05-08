// File: lib/pages/reschedule_page/widgets/empty_time_slots_view.dart

import 'package:flutter/material.dart';

/// A widget displayed when no time slots are available for the selected date.
class EmptyTimeSlotsView extends StatelessWidget {
  final VoidCallback onSelectAnotherDate;

  const EmptyTimeSlotsView({
    super.key,
    required this.onSelectAnotherDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_outlined, // Using outlined version
              size: 56, // Larger icon
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5), // Standard opacity
            ),
            const SizedBox(height: 20),
            Text(
              'No Time Slots Available', // Clearer title
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Please try selecting a different date to find available slots.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              icon: const Icon(Icons.calendar_today_outlined),
              label: const Text('Select Another Date'),
              onPressed: onSelectAnotherDate,
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}