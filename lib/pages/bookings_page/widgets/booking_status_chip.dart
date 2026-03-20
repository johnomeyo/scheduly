import 'package:flutter/material.dart';
import 'package:scheduly/utils.dart/utils.dart';
class BookingStatusChip extends StatelessWidget {
  final String status;

  const BookingStatusChip({super.key, required this.status});

  Color _getChipColor(BuildContext context, String currentStatus) {
    final theme = Theme.of(context);
    final normalizedStatus = currentStatus.toLowerCase();
    switch (normalizedStatus) {
      case "confirmed":
        return Colors.green.shade600;
      case "pending":
        return Colors.orange.shade500;
      case 'cancelled':
      case 'canceled':
        return Colors.red.shade500;
      case "completed":
        return Colors.blue.shade600;
      default:
        return theme.colorScheme.onSurface.withValues(
          alpha: 0.6,
        ); 
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
        color: chipColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 15, color: chipColor),
          const SizedBox(width: 6),
          Text(
            capitalizeFirst(status),
            style: theme.textTheme.labelSmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
