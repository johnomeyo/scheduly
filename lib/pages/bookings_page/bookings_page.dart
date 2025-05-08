

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/constants/data.dart'; // For example data
import 'package:scheduly/models/booking_model.dart' show Booking;
import 'package:scheduly/pages/booking_details_page/booking_details_page.dart';
import 'package:scheduly/pages/bookings_page/widgets/empty_booking_state.dart';
import 'package:scheduly/pages/reschedule_page/reschedule_page.dart';

import 'widgets/booking_card.dart';

/// A page that displays the user's upcoming and past bookings in separate tabs.
///
/// It uses a [TabController] to manage the views. If no bookings are
/// available for a selected tab, an [EmptyBookingsState] widget is shown.
/// Otherwise, bookings are displayed using [BookingCard] widgets.
class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Example: Using placeholder data. In a real app, this would come from a service or state management.
  // Ensure your Booking model has an 'id' (or similar unique identifier) for operations like cancellation.
  List<Booking> _upcomingBookings = List.from(upcomingBookings); // Create modifiable copies
  List<Booking> _pastBookings = List.from(pastBookings);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Optional: Add listener to fetch data or perform actions on tab change
    // _tabController.addListener(_onTabChanged);
  }

  // void _onTabChanged() {
  //   if (!_tabController.indexIsChanging) {
  //     // Tab selection has settled
  //     // setState(() { /* Fetch data for _tabController.index if needed */ });
  //   }
  // }

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
        elevation: 0, // Modern flat look
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.colorScheme.primary,
          indicatorWeight: 2.5,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.65),
          labelStyle: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'UPCOMING'), // Uppercase for style, if desired
            Tab(text: 'PAST'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsListView(_upcomingBookings, isUpcoming: true),
          _buildBookingsListView(_pastBookings, isUpcoming: false),
        ],
      ),
    );
  }

  /// Constructs the list view for bookings or an empty state message.
  Widget _buildBookingsListView(List<Booking> bookings, {required bool isUpcoming}) {
    if (bookings.isEmpty) {
      return EmptyBookingsState(
        isUpcoming: isUpcoming,
        onExploreServices: isUpcoming ? _navigateToExplore : null,
      );
    }

    return RefreshIndicator( // Optional: Add pull-to-refresh
      onRefresh: () => _refreshBookings(isUpcoming),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0), // Adjusted padding
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return BookingCard(
            booking: booking,
            isUpcoming: isUpcoming,
            onTap: () => _viewBookingDetails(booking),
            onCancel: isUpcoming ? () => _showCancelConfirmationDialog(booking) : null,
            onReschedule: isUpcoming ? () => _rescheduleBooking(booking) : null,
            onRebook: !isUpcoming ? () => _rebookService(context, booking) : null,
          );
        },
      ),
    );
  }
  
  /// Simulates refreshing booking data.
  Future<void> _refreshBookings(bool forUpcoming) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() {
      if (forUpcoming) {
        // Replace with actual data fetching logic
        _upcomingBookings = List.from(upcomingBookings.where((b) => b.status != "Cancelled")); // Example re-fetch/filter
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Upcoming bookings updated!"), duration: Duration(seconds: 1)),
        );
      } else {
        _pastBookings = List.from(pastBookings);
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Past bookings updated!"), duration: Duration(seconds: 1)),
        );
      }
    });
  }


  // --- Action Handlers ---

  void _viewBookingDetails(Booking booking) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingDetailsPage(booking: booking)),
    );
  }

  void _showCancelConfirmationDialog(Booking booking) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Cancellation'),
          content: Text('Are you sure you want to cancel your booking for "${booking.serviceName}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Keep It'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Theme.of(dialogContext).colorScheme.error),
              child: const Text('Yes, Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _performBookingCancellation(booking);
              },
            ),
          ],
        );
      },
    );
  }

  void _performBookingCancellation(Booking booking) {
    // Simulate API call for cancellation
    print('Cancelling booking: ${booking.id}'); // Assuming Booking has an 'id'

    if (!mounted) return;
    setState(() {
      // Update local lists. In a real app, you'd refetch or rely on state management.
      _upcomingBookings.removeWhere((b) => b.id == booking.id);
      // Optionally move to past bookings if your model supports it
      // booking.status = "Cancelled"; _pastBookings.insert(0, booking);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking for "${booking.serviceName}" cancelled.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _rescheduleBooking(Booking booking) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReschedulePage(booking: booking)),
    ).then((didReschedule) { // Optional: Handle result from ReschedulePage
        if (didReschedule == true) {
            _refreshBookings(true); // Refresh upcoming bookings if something changed
        }
    });
  }

  void _rebookService(BuildContext pageContext, Booking booking) async {
    final theme = Theme.of(pageContext); // Use pageContext for theming
    final now = DateTime.now();
    final initialDatePickerDate = now.isBefore(now.copyWith(hour: 17)) // If before 5 PM suggest today, else tomorrow
                                  ? now 
                                  : now.add(const Duration(days: 1));

    final DateTime? pickedDate = await showDatePicker(
      context: pageContext,
      initialDate: initialDatePickerDate,
      firstDate: now, // Allow booking for today if applicable
      lastDate: now.add(const Duration(days: 90)),
      // Optional: Theming the DatePicker
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(primary: theme.colorScheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null || !mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: pageContext,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))),
    );

    if (pickedTime == null || !mounted) return;

    final DateTime finalBookingDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Simulate rebooking logic (e.g., API call, create new booking object)
    print('Rebooking "${booking.serviceName}" for $finalBookingDateTime');
    
    // Example of adding to upcoming and showing confirmation:
    // final newBooking = Booking(id: UniqueKey().toString(), /* ... other details ... */ date: finalBookingDateTime, status: "Confirmed");
    // setState(() {
    //   _upcomingBookings.insert(0, newBooking);
    //   _tabController.animateTo(0); // Switch to upcoming tab
    // });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully rebooked "${booking.serviceName}" for ${DateFormat.yMMMd().add_jm().format(finalBookingDateTime)}.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green.shade600,
      ),
    );
  }

  void _navigateToExplore() {
    print('Navigate to explore page action triggered.');
    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreServicesPage()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Explore Services...')),
    );
  }
}