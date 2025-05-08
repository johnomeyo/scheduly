import 'package:flutter/material.dart';

/// A card widget representing an available time slot.
///
/// It changes appearance based on whether it is selected.
class TimeSlotCard extends StatelessWidget {
  final String timeSlot;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Assuming timeSlot is "HH:MM AM/PM - HH:MM AM/PM", we only show the start time
    final startTime = timeSlot.split(' - ').first;

    return Card(
      elevation: isSelected ? 1.0 : 0.5,
      color:
          isSelected
              ? theme.colorScheme.primaryContainer.withValues(
                alpha: 0.8,
              ) // More distinct selection color
              : theme
                  .colorScheme
                  .surfaceContainerHighest, // A slightly elevated surface
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Slightly more rounded
        side: BorderSide(
          color:
              isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withValues(
                    alpha: 0.5,
                  ), // Standard opacity
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        highlightColor: theme.colorScheme.primary.withValues(alpha: 0.05),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12.0,
            ), // Adjust padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected
                      ? Icons.check_circle_outline_rounded
                      : Icons.access_time_rounded,
                  size: 18, // Slightly larger icon
                  color:
                      isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Flexible(
                  // Allow text to wrap if needed, though unlikely for time
                  child: Text(
                    startTime,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color:
                          isSelected
                              ? theme.colorScheme.onPrimaryContainer
                              : theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
