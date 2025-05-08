
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/booking_model.dart'; 
import './detail_item.dart'; // Import the DetailItem widget

/// Displays the details of the current booking that is being rescheduled.
class CurrentBookingInfoCard extends StatelessWidget {
  final Booking booking;
  final DateFormat dateFormat;

  const CurrentBookingInfoCard({
    super.key,
    required this.booking,
    required this.dateFormat,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3), // Use primaryContainer
        borderRadius: BorderRadius.circular(12.0), // Add rounded corners
      ),
      margin: const EdgeInsets.all(16.0), // Add margin for separation
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Appointment Details',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DetailItem(
                  label: 'Service',
                  value: booking.serviceName,
                  icon: Icons.design_services_outlined, // More specific icon
                ),
              ),
              const SizedBox(width: 16), // Spacing between items
              Expanded(
                child: DetailItem(
                  label: 'Date',
                  value: dateFormat.format(booking.date),
                  icon: Icons.calendar_month_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DetailItem(
                  label: 'Time',
                  // Assuming timeSlot format is "START_TIME - END_TIME"
                  value: booking.timeSlot.split(' - ').first,
                  icon: Icons.access_time_outlined,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DetailItem(
                  label: 'Business',
                  value: booking.businessName,
                  icon: Icons.business_center_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}