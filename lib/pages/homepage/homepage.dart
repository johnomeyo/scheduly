import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/constants/data.dart';
import 'package:scheduly/models/business_model.dart';
import 'package:scheduly/models/booking_model.dart';
import 'package:scheduly/pages/all_businesses_page/widgets/business_card.dart';
import 'package:scheduly/pages/business_details_page/business_details_page.dart';
import 'package:scheduly/pages/homepage/widgets/home_header_section.dart';
import 'package:scheduly/pages/homepage/widgets/next_appointement_section.dart';
import 'package:scheduly/pages/homepage/widgets/special_offer_section.dart';
import 'package:scheduly/pages/all_businesses_page/popular_business_page.dart'
    show AllPopularBusinessesPage;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  List<BusinessModel> _popularBusinesses = [];
  List<Booking> _upcomingBookings = [];
  BusinessModel? _specialOfferBusiness;

  @override
  void initState() {
    super.initState();
    _fetchHomeData(); 
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchHomeData() async {
    // In a real app, you would fetch data from an API or database here.
    // For this example, we'll simulate loading and use sample data.
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 0));

      // Assign sample data (replace with actual data fetching logic)
      _popularBusinesses = sampleBusiness;
      _upcomingBookings = upcomingBookings;
      // Assuming the first sample business has a special offer for demonstration
      _specialOfferBusiness =
          sampleBusiness.isNotEmpty ? sampleBusiness[0] : null;

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load data: ${e.toString()}';
      });
      debugPrint('Error fetching home data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_errorMessage != null) {
      return Scaffold(body: Center(child: Text('Error: $_errorMessage')));
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeHeaderSection(),

            // Special Offers
            if (_specialOfferBusiness != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    24,
                    16,
                    16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Offers',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SpecialOfferCard(
                        business: _specialOfferBusiness!,
                      ), 
                    ],
                  ),
                ),
              ),

            // Next Appointment
            if (_upcomingBookings
                .isNotEmpty) // Only show if there are upcoming bookings
              NextAppointmentSection(
                upcomingBookings: _upcomingBookings, // Use the fetched bookings
                dateFormat: DateFormat('MMM dd, yyyy'),
              ),

            // Popular Near You
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  24,
                  16,
                  8,
                ), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Near You',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed:
                          () => _viewAllBusinesses(
                            context,
                            _popularBusinesses,
                          ), // Pass fetched data
                      child: const Text('View All'),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final business = _popularBusinesses[index];
                  return BusinessCard(
                    // Use the extracted BusinessCard widget
                    business: business,
                    onTap:
                        () => _viewBusinessDetails(
                          context,
                          business,
                        ), // Pass context and data
                  );
                },
                childCount: _popularBusinesses.length, // Use fetched data count
              ),
            ),
            SliverToBoxAdapter(
              // Add some bottom padding
              child: SizedBox(height: 16), 
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods for navigation
  void _viewAllBusinesses(
    BuildContext context,
    List<BusinessModel> businesses,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllPopularBusinessesPage(businesses: businesses),
      ),
    );
  }

  void _viewBusinessDetails(BuildContext context, BusinessModel business) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessDetailsPage(business: business),
      ),
    );
  }
}
