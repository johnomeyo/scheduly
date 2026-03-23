import 'package:flutter/material.dart';
import 'package:scheduly/constants/data.dart';
import 'package:scheduly/models/booking_model.dart' show Booking;
import 'package:scheduly/pages/all_businesses_page/popular_business_page.dart';
import 'package:scheduly/pages/booking_details_page/booking_details_page.dart';
import 'package:scheduly/pages/bookings_page/widgets/empty_booking_state.dart';
import 'package:scheduly/pages/reschedule_page/reschedule_page.dart';
import 'widgets/booking_card.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Booking> _upcomingBookings = List.from(upcomingBookings);
  List<Booking> _pastBookings = List.from(pastBookings);

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
          indicatorWeight: 2.5,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurface.withValues(
            alpha: 0.65,
          ),
          labelStyle: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          tabs: const [Tab(text: 'UPCOMING'), Tab(text: 'PAST')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildBookingsListView(_upcomingBookings, isUpcoming: true),
          buildBookingsListView(_pastBookings, isUpcoming: false),
        ],
      ),
    );
  }

  Widget buildBookingsListView(
    List<Booking> bookings, {
    required bool isUpcoming,
  }) {
    if (bookings.isEmpty) {
      return EmptyBookingsState(
        isUpcoming: isUpcoming,
        onExploreServices: isUpcoming ? navigateToExplore : null,
      );
    }

    return RefreshIndicator(
      onRefresh: () => refreshBookings(isUpcoming),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return BookingCard(
            booking: booking,
            isUpcoming: isUpcoming,
            onTap: () => viewBookingDetails(booking),
            onReschedule: isUpcoming ? () => rescheduleBooking(booking) : null,
            onRebook:
                !isUpcoming ? () => rebookService(context, booking) : null,
          );
        },
      ),
    );
  }

  Future<void> refreshBookings(bool forUpcoming) async {
    // Sample API call
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() {
      if (forUpcoming) {
        _upcomingBookings = List.from(
          upcomingBookings.where((b) => b.status != "Cancelled"),
        );
      } else {
        _pastBookings = List.from(pastBookings);
      }
    });
  }

  void viewBookingDetails(Booking booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetailsPage(booking: booking),
      ),
    );
  }

  void rescheduleBooking(Booking booking) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReschedulePage(booking: booking)),
    ).then((didReschedule) {
      if (didReschedule == true) {
        refreshBookings(true);
      }
    });
  }

  void rebookService(BuildContext pageContext, Booking booking) async {
    final now = DateTime.now();
    final initialDatePickerDate =
        now.isBefore(
              now.copyWith(hour: 17),
            ) // If before 5 PM suggest today, else tomorrow
            ? now
            : now.add(const Duration(days: 1));

    final DateTime? pickedDate = await showDatePicker(
      context: pageContext,
      initialDate: initialDatePickerDate,
      firstDate: now, // Allow booking for today if applicable
      lastDate: now.add(const Duration(days: 90)),

    );

    if (pickedDate == null || !mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      // ignore: use_build_context_synchronously
      context: pageContext,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))),
    );

    if (pickedTime == null || !mounted) return;
  }

  void navigateToExplore() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AllPopularBusinessesPage(
              businesses: sampleBusiness,
            ),
      ),
    ).then((_) {});
  }
}
