import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/business_model.dart';

class NextAppointmentSection extends StatefulWidget {
  final List<Booking> upcomingBookings;
  final DateFormat dateFormat;

  const NextAppointmentSection({
    super.key,
    required this.upcomingBookings,
    required this.dateFormat,
  });

  @override
  State<NextAppointmentSection> createState() => _NextAppointmentSectionState();
}

class _NextAppointmentSectionState extends State<NextAppointmentSection> {
  void _viewAllBookings() {
    debugPrint('View all bookings tapped');
  }

  void _viewBookingDetails(Booking booking) {
    debugPrint('Viewing booking for ${booking.serviceName}');
  }

  void _rescheduleBooking(Booking booking) {
    debugPrint('Rescheduling booking for ${booking.serviceName}');
  }

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

  Widget _buildInfoChip(
    ThemeData theme, {
    required IconData icon,
    required String label,
  }) {
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
      backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildNextAppointmentCard(ThemeData theme) {
    final nextBooking = widget.upcomingBookings.first;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _viewBookingDetails(nextBooking),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Booking row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 60,
                      height: 60,
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      child: Icon(
                        _getServiceIcon(nextBooking.serviceName),
                        color: theme.colorScheme.primary,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nextBooking.serviceName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          nextBooking.businessName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildInfoChip(
                              theme,
                              icon: Icons.calendar_today,
                              label: widget.dateFormat.format(nextBooking.date),
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              theme,
                              icon: Icons.access_time,
                              label: nextBooking.timeSlot.split(' - ').first,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => _rescheduleBooking(nextBooking),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      side: BorderSide(color: theme.colorScheme.primary),
                    ),
                    child: const Text('Reschedule'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () => _viewBookingDetails(nextBooking),
                    child: const Text('View Details'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.upcomingBookings.isEmpty) {
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
                  onPressed: _viewAllBookings,
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildNextAppointmentCard(theme),
          ],
        ),
      ),
    );
  }
}
