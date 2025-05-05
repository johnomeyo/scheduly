import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/constants/data.dart';
import 'package:scheduly/models/business.dart';
import 'package:scheduly/pages/booking_details_page.dart';
import 'package:scheduly/pages/reschedule_page.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.colorScheme.primary,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurface.withValues(
            alpha: 0.6,
          ),
          labelStyle: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Past')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList(upcomingBookings, isUpcoming: true),
          _buildBookingsList(pastBookings, isUpcoming: false),
        ],
      ),
    );
  }

  Widget _buildBookingsList(
    List<Booking> bookings, {
    required bool isUpcoming,
  }) {
    if (bookings.isEmpty) {
      return _buildEmptyState(isUpcoming);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return BookingCard(
          booking: bookings[index],
          isUpcoming: isUpcoming,
          onTap: () => _viewBookingDetails(bookings[index]),
          onCancel: isUpcoming ? () => _cancelBooking(bookings[index]) : null,
          onReschedule:
              isUpcoming ? () => _rescheduleBooking(bookings[index]) : null,
          onRebook:
              !isUpcoming
                  ? () => _rebookService(context, bookings[index])
                  : null,
        );
      },
    );
  }

  Widget _buildEmptyState(bool isUpcoming) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isUpcoming ? Icons.event_available : Icons.history,
            size: 80,
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            isUpcoming ? 'No upcoming bookings' : 'No past bookings',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            isUpcoming
                ? 'Book a service to get started'
                : 'Your booking history will appear here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 24),
          if (isUpcoming)
            ElevatedButton(
              onPressed: () => _navigateToExplore(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Explore Services'),
            ),
        ],
      ),
    );
  }

  void _viewBookingDetails(Booking booking) {
    // Navigate to booking details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetailsPage(booking: booking),
      ),
    );
  }

  void _cancelBooking(Booking booking) {
    // Show confirmation dialog and cancel booking
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetailsPage(booking: booking),
      ),
    );
  }

  void _rescheduleBooking(Booking booking) {
    // Navigate to reschedule page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReschedulePage(booking: booking)),
    );
  }

  void _rebookService(BuildContext context, Booking booking) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (pickedDate == null) return; // User canceled

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return; // User canceled

    final DateTime finalBookingDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Simulate rebooking logic (e.g., API call)
    // await BookingService.rebook(...);

    // Show confirmation
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Rebooked ${booking.serviceName} for ${finalBookingDateTime.toLocal()}',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    print('Rebooked ${booking.serviceName} at $finalBookingDateTime');
  }

  void _navigateToExplore() {
    // Navigate to explore/search page
    print('Navigate to explore page');
  }
}

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEE, MMM d, yyyy');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status and date
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusChip("booking.status", theme),
                  Text(
                    dateFormat.format(booking.date),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Booking details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service image placeholder
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      child: Icon(
                        _getServiceIcon(booking.serviceName),
                        color: theme.colorScheme.primary,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Service details
                  Expanded(
                    child: Column(
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
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              booking.timeSlot,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${booking.price.toStringAsFixed(2)}',
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

            // Actions
            if (isUpcoming || onRebook != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onRebook != null)
                      TextButton.icon(
                        onPressed: onRebook,
                        icon: const Icon(Icons.replay),
                        label: const Text('Book Again'),
                      ),
                    if (onReschedule != null) ...[
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: onReschedule,
                        icon: const Icon(Icons.edit_calendar),
                        label: const Text('Reschedule'),
                      ),
                    ],
                    if (onCancel != null) ...[
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: onCancel,
                        icon: const Icon(Icons.cancel_outlined),
                        label: const Text('Cancel'),
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, ThemeData theme) {
    Color? chipColor;

    switch (status) {
      case "Confirmed":
        chipColor = Colors.green;
        break;
      case "Pending":
        chipColor = Colors.orange;
        break;
      case 'Cancelled':
        chipColor = Colors.red;
        break;
      case "Completed":
        chipColor = Colors.blue;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor?.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(status), size: 14, color: chipColor),
          const SizedBox(width: 4),
          Text(
            "statusText",
            style: theme.textTheme.bodySmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Confirmed':
        return Icons.check_circle_outline;
      case 'Pending':
        return Icons.hourglass_empty;
      case 'Cancelled':
        return Icons.cancel_outlined;
      case 'Completed':
        return Icons.task_alt;
      default:
        return Icons.info_outline;
    }
  }

  IconData _getServiceIcon(String serviceName) {
    if (serviceName.toLowerCase().contains('hair')) {
      return Icons.content_cut;
    } else if (serviceName.toLowerCase().contains('massage')) {
      return Icons.spa;
    } else if (serviceName.toLowerCase().contains('dental')) {
      return Icons.medical_services;
    } else if (serviceName.toLowerCase().contains('car')) {
      return Icons.directions_car;
    } else if (serviceName.toLowerCase().contains('fitness')) {
      return Icons.fitness_center;
    }
    return Icons.calendar_today;
  }
}
