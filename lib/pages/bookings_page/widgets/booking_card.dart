// File: lib/pages/bookings_page/widgets/booking_card.dart (Updated)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/booking_model.dart';

// Import the new modular widgets
import './booking_status_chip.dart';
import './booking_actions_row.dart';

/// A card widget that displays detailed information about a single booking.
///
/// It includes service details, business information, date/time, price,
/// status, and relevant action buttons.
class BookingCard extends StatelessWidget {
  final Booking booking;
  final bool isUpcoming;
  final VoidCallback onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final VoidCallback? onRebook;

  const BookingCard({
    super.key,
    required this.booking,
    required this.isUpcoming,
    required this.onTap,
    this.onCancel,
    this.onReschedule,
    this.onRebook,
  });

  // Helper to get a representative icon for the service type.
  // Kept within BookingCard as it's presentation-specific for this card.
  IconData _getServiceIcon(String serviceName) {
    final nameLower = serviceName.toLowerCase();
    if (nameLower.contains('hair')) return Icons.content_cut;
    if (nameLower.contains('massage') || nameLower.contains('spa')) return Icons.spa_outlined;
    if (nameLower.contains('dental')) return Icons.medical_services_outlined;
    if (nameLower.contains('car') || nameLower.contains('auto')) return Icons.directions_car_outlined;
    if (nameLower.contains('fitness') || nameLower.contains('gym')) return Icons.fitness_center_outlined;
    if (nameLower.contains('cleaning')) return Icons.cleaning_services_outlined;
    if (nameLower.contains('nail')) return Icons.brush_outlined;
    if (nameLower.contains('consult')) return Icons.support_agent_outlined;
    return Icons.bookmark_added_outlined; // A generic fallback
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEE, MMM d, yyyy'); // For the date display
    final timeFormat = DateFormat.jm(); // For time display e.g., "5:08 PM"

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        highlightColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: Status and Date
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest, // A slightly elevated surface color
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BookingStatusChip(status: booking.status.name), // Corrected: Use actual booking status
                  Text(
                    dateFormat.format(booking.date),
                    style: theme.textTheme.bodySmall?.copyWith( // Using bodySmall for date for less emphasis
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content: Service Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64, // Adjusted size for a more compact look
                    height: 64,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      _getServiceIcon(booking.serviceName),
                      color: theme.colorScheme.onSecondaryContainer,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.serviceName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          booking.businessName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                          ),
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_filled_rounded,
                              size: 16,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              // Assuming booking.timeSlot is a pre-formatted string
                              // OR booking.date contains the full DateTime
                              booking.timeSlot.isNotEmpty ? booking.timeSlot : timeFormat.format(booking.date),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          NumberFormat.currency(
                            symbol: '\$', // Consider making this dynamic based on locale/currency
                            decimalDigits: 2,
                          ).format(booking.price),
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            BookingActionsRow(
              isUpcoming: isUpcoming,
              onCancel: onCancel,
              onReschedule: onReschedule,
              onRebook: onRebook,
            ),
          ],
        ),
      ),
    );
  }
}