
import 'package:flutter/material.dart';

/// A row displaying conditional action buttons for a booking.
///
/// Actions like "Cancel", "Reschedule", or "Book Again" are shown
/// based on the booking's context (e.g., upcoming or past).
class BookingActionsRow extends StatelessWidget {
  /// Indicates if the booking is upcoming, determining which actions are relevant.
  final bool isUpcoming;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final VoidCallback? onRebook;

  const BookingActionsRow({
    super.key,
    required this.isUpcoming,
    this.onCancel,
    this.onReschedule,
    this.onRebook,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (onCancel == null && onReschedule == null && onRebook == null) {
      return const SizedBox.shrink(); // No actions to display
    }

    return Padding(
      // Added top padding for separation from content above
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
      child: Wrap( // Use Wrap for responsiveness
        alignment: WrapAlignment.end,
        spacing: 8.0, // Horizontal space between buttons
        runSpacing: 4.0, // Vertical space if buttons wrap
        children: [
          if (onRebook != null && !isUpcoming)
            TextButton.icon(
              icon: const Icon(Icons.replay_circle_filled_outlined, size: 20),
              label: const Text('Book Again'),
              onPressed: onRebook,
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          if (onReschedule != null && isUpcoming)
            TextButton.icon(
              icon: const Icon(Icons.edit_calendar_outlined, size: 20),
              label: const Text('Reschedule'),
              onPressed: onReschedule,
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.secondary, // Differentiate reschedule action
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          if (onCancel != null && isUpcoming)
            TextButton.icon(
              icon: const Icon(Icons.cancel_schedule_send_outlined, size: 20), // More specific cancel icon
              label: const Text('Cancel'),
              onPressed: onCancel,
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
        ],
      ),
    );
  }
}