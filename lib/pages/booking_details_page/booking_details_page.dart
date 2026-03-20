import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/booking_model.dart';
import 'package:scheduly/pages/booking_details_page/widgets/details_row.dart';
import 'package:scheduly/pages/booking_details_page/widgets/details_section.dart';
import 'package:scheduly/pages/booking_details_page/widgets/service_eader.dart';
import 'package:scheduly/pages/reschedule_page/reschedule_page.dart'
    show ReschedulePage;
import 'package:scheduly/utils.dart/utils.dart';

class BookingDetailsPage extends StatelessWidget {
  final Booking booking;
  final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');

  BookingDetailsPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceHeader(
              title: "Booking Detais",
              serviceName: booking.serviceName,
              icon: getServiceIcon(booking.serviceName),
              theme: theme,
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DetailSection(
                title: "Service Description",
                children: [
                  Text(
                    "Get a fresh fade, sharp lineup, and stylish finish that matches your vibe. Whether you're going for bold or clean, we’ve got you covered with the latest trends.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: applyOpacity(theme.colorScheme.onSurface, 0.7),
                    ),
                  ),
                ],
              ),
            ),
            // Booking details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailSection(
                    title: 'Appointment Details',
                    children: [
                      DetailRow(
                        icon: Icons.business,
                        label: 'Business',
                        value: booking.businessName,
                      ),
                      DetailRow(
                        icon: Icons.category,
                        label: 'Service',
                        value: booking.serviceName,
                      ),
                      DetailRow(
                        icon: Icons.calendar_today,
                        label: 'Date',
                        value: dateFormat.format(booking.date),
                      ),
                      DetailRow(
                        icon: Icons.access_time,
                        label: 'Time',
                        value: booking.timeSlot,
                      ),
                      DetailRow(
                        icon: Icons.attach_money,
                        label: 'Price',
                        value: 'Kes ${booking.price}',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Action buttons
                  const SizedBox(width: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ReschedulePage(booking: booking),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: const Text('Reschedule'),
                    ),
                  ),

                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showCancelConfirmation(context);
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancel Appointment'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                        side: BorderSide(color: theme.colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancel Appointment?'),
            content: Text(
              'Are you sure you want to cancel your ${booking.serviceName} appointment on ${dateFormat.format(booking.date)} at ${booking.timeSlot.split(' - ').first}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Keep Appointment',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement cancellation logic here
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to previous screen

                  // Show cancellation confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appointment cancelled successfully'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                ),
                child: Text(
                  'Cancel Appointment',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
