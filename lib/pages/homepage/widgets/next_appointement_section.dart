
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/booking_model.dart';
import 'package:scheduly/pages/bookings_page/bookings_page.dart';
import 'package:scheduly/pages/booking_details_page/booking_details_page.dart'; // New import for details page
import 'package:scheduly/pages/reschedule_page/reschedule_page.dart'; // New import for reschedule page
class NextAppointmentSection extends StatelessWidget {
  final List<Booking> upcomingBookings;
  final DateFormat dateFormat;

  const NextAppointmentSection({
    super.key,
    required this.upcomingBookings,
    required this.dateFormat,
  });

  void _viewAllBookings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BookingsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (upcomingBookings.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Next Appointment',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => _viewAllBookings(context),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AppointmentCard(
              booking: upcomingBookings.first,
              dateFormat: dateFormat,
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Booking booking;
  final DateFormat dateFormat;

  const AppointmentCard({
    super.key,
    required this.booking,
    required this.dateFormat,
  });

  void _viewBookingDetails(BuildContext context, Booking booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetailsPage(booking: booking),
      ),
    );
  }

  void _rescheduleBooking(BuildContext context, Booking booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReschedulePage(booking: booking),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _viewBookingDetails(context, booking),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Booking row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceIcon(serviceName: booking.serviceName),
                  const SizedBox(width: 16),
                  // Details
                  Expanded(
                    child: BookingInfo(
                      booking: booking,
                      dateFormat: dateFormat,
                      theme: theme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Actions
              ActionButtons(
                booking: booking,
                onReschedule: () => _rescheduleBooking(context, booking),
                onViewDetails: () => _viewBookingDetails(context, booking),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final String serviceName;

  const ServiceIcon({
    super.key,
    required this.serviceName,
  });

  IconData _getServiceIcon(String serviceName) {
    // Dummy logic for icons
    switch (serviceName.toLowerCase()) {
      case 'massage':
        return Icons.spa;
      case 'haircut':
        return Icons.content_cut;
      case 'gym':
        return Icons.fitness_center;
      default:
        return Icons.calendar_today;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 60,
        height: 60,
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(
          _getServiceIcon(serviceName),
          color: theme.colorScheme.primary,
          size: 28,
        ),
      ),
    );
  }
}

class BookingInfo extends StatelessWidget {
  final Booking booking;
  final DateFormat dateFormat;
  final ThemeData theme;

  const BookingInfo({
    super.key,
    required this.booking,
    required this.dateFormat,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          booking.serviceName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          booking.businessName,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.7,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            InfoChip(
              theme: theme,
              icon: Icons.calendar_today,
              label: dateFormat.format(booking.date),
            ),
            InfoChip(
              theme: theme,
              icon: Icons.access_time,
              label: booking.timeSlot.split(' - ').first,
            ),
          ],
        ),
      ],
    );
  }
}

class InfoChip extends StatelessWidget {
  final ThemeData theme;
  final IconData icon;
  final String label;

  const InfoChip({
    super.key,
    required this.theme,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.3,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final Booking booking;
  final VoidCallback onReschedule;
  final VoidCallback onViewDetails;

  const ActionButtons({
    super.key,
    required this.booking,
    required this.onReschedule,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: onReschedule,
          style: OutlinedButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
            side: BorderSide(color: theme.colorScheme.primary),
          ),
          child: const Text('Reschedule'),
        ),
        const SizedBox(width: 12),
        FilledButton(
          onPressed: onViewDetails,
          child: const Text('View Details'),
        ),
      ],
    );
  }
}