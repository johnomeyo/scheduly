
import 'package:flutter/material.dart';

/// A chip widget to visually represent the status of a booking.
///
/// It displays an icon and text, color-coded according to the booking status.
class BookingStatusChip extends StatelessWidget {
  /// The status string of the booking (e.g., "Confirmed", "Pending").
  final String status;

  const BookingStatusChip({
    super.key,
    required this.status,
  });

  Color _getChipColor(BuildContext context, String currentStatus) {
    final theme = Theme.of(context);
    // Normalize status for comparison
    final normalizedStatus = currentStatus.toLowerCase();
    switch (normalizedStatus) {
      case "confirmed":
        return Colors.green.shade600;
      case "pending":
        return Colors.orange.shade500;
      case 'cancelled':
      case 'canceled': // handle variations
        return Colors.red.shade500;
      case "completed":
        return Colors.blue.shade600;
      default:
        return theme.colorScheme.onSurface.withValues(alpha: 0.6); // Neutral color for unknown status
    }
  }

  IconData _getStatusIcon(String currentStatus) {
    final normalizedStatus = currentStatus.toLowerCase();
    switch (normalizedStatus) {
      case 'confirmed':
        return Icons.check_circle_rounded;
      case 'pending':
        return Icons.hourglass_bottom_rounded;
      case 'cancelled':
      case 'canceled':
        return Icons.cancel_rounded;
      case 'completed':
        return Icons.task_alt_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color chipColor = _getChipColor(context, status);
    final IconData iconData = _getStatusIcon(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.15), // Slightly more pronounced background
        borderRadius: BorderRadius.circular(20.0), // Fully rounded chip
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 15, color: chipColor),
          const SizedBox(width: 6),
          Text(
            status, // Display the original status string for capitalization
            style: theme.textTheme.labelSmall?.copyWith( // Using labelSmall for concise text
              color: chipColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}