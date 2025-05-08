
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A styled, tappable field for selecting a date.
class DatePickerField extends StatelessWidget {
  final DateTime selectedDate;
  final DateFormat dateFormat;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.dateFormat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Adjusted padding
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.7)),
            borderRadius: BorderRadius.circular(12.0),
            color: theme.colorScheme.surfaceContainer, // Subtle background
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: theme.colorScheme.primary,
                size: 22, // Slightly larger icon
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Date', // More descriptive label
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dateFormat.format(selectedDate),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500, // Bolder date text
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_drop_down_rounded, // Changed arrow icon
                size: 28, // Larger arrow
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}