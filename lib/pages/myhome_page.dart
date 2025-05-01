import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/constants/data.dart';
import 'package:scheduly/models/service_model.dart';
import 'package:scheduly/pages/service_bookings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Mock data for upcoming bookings
  final List<Booking> _upcomingBookings = [
    Booking(
      id: '1',
      serviceName: 'Hair Cut & Style',
      businessName: 'Modern Salon',
      date: DateTime.now().add(const Duration(days: 2)),
      timeSlot: '10:00 AM - 11:00 AM',
      price: 45.00,
      status: BookingStatus.confirmed,
      imageUrl: 'https://example.com/salon.jpg',
    ),
    Booking(
      id: '2',
      serviceName: 'Deep Tissue Massage',
      businessName: 'Wellness Spa',
      date: DateTime.now().add(const Duration(days: 5)),
      timeSlot: '2:30 PM - 3:30 PM',
      price: 75.00,
      status: BookingStatus.confirmed,
      imageUrl: 'https://example.com/spa.jpg',
    ),
  ];

  // Mock data for popular businesses
  final List<Business> _popularBusinesses = [
    Business(
      id: '1',
      name: 'Wellness Spa Center',
      category: 'Spa & Massage',
      address: '123 Relaxation Ave',
      distance: 1.2,
      rating: 4.9,
      reviewCount: 324,
      imageUrl: 'https://example.com/wellness-spa.jpg',
    ),
    Business(
      id: '2',
      name: 'Modern Hair Studio',
      category: 'Hair & Beauty',
      address: '456 Style St',
      distance: 0.8,
      rating: 4.7,
      reviewCount: 215,
      imageUrl:
          'https://i.pinimg.com/736x/ec/e2/8a/ece28abe4a13dcefbf7f856e45b0a810.jpg',
    ),
    Business(
      id: '3',
      name: 'Elite Fitness Center',
      category: 'Fitness & Training',
      address: '789 Muscle Road',
      distance: 2.5,
      rating: 4.8,
      reviewCount: 178,
      imageUrl:
          'https://marketplace.canva.com/EAFxdcos7WU/1/0/1600w/canva-dark-blue-and-brown-illustrative-fitness-gym-logo-oqe3ybeEcQQ.jpg',
    ),
  ];

  // Mock data for recent searches
  final List<String> _recentSearches = [
    'Massage therapy',
    'Hair salon near me',
    'Personal trainer',
    'Dental check-up',
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEE, MMM d');

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Search
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome message and notifications
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good morning,',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onBackground
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sarah Johnson',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Badge(
                            label: const Text('2'),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                          onPressed: () => _openNotifications(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Search bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search services, businesses...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () => _showFilters(),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (value) => _performSearch(value),
                    ),

                    // Recent searches
                    if (_recentSearches.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Wrap(
                          spacing: 8,
                          children:
                              _recentSearches
                                  .map(
                                    (search) => Chip(
                                      label: Text(search),
                                      onDeleted:
                                          () => _removeRecentSearch(search),
                                      backgroundColor:
                                          theme.colorScheme.surface,
                                      side: BorderSide(
                                        color: theme.colorScheme.outline
                                            .withValues(alpha: 0.3),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Next Appointment
            if (_upcomingBookings.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            onPressed: () => _viewAllBookings(),
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildNextAppointmentCard(theme, dateFormat),
                    ],
                  ),
                ),
              ),

            // Category Services Cards
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Featured Services',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return _buildServiceCard(theme, services[index]);
                  },
                ),
              ),
            ),

            // Popular Near You
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
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
                      onPressed: () => _viewAllBusinesses(),
                      child: const Text('View All'),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _buildBusinessCard(theme, _popularBusinesses[index]);
              }, childCount: _popularBusinesses.length),
            ),

            // Special Offers
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
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
                    _buildSpecialOfferCard(theme),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextAppointmentCard(ThemeData theme, DateFormat dateFormat) {
    final nextBooking = _upcomingBookings.first;

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service icon/image
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

                  // Booking details
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
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildInfoChip(
                              theme,
                              icon: Icons.calendar_today,
                              label: dateFormat.format(nextBooking.date),
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

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => _rescheduleBooking(nextBooking),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      side: BorderSide(color: theme.colorScheme.primary),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text('Reschedule'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () => _viewBookingDetails(nextBooking),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
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

  Widget _buildInfoChip(
    ThemeData theme, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(ThemeData theme, ServiceModel service) {
    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: InkWell(
        onTap: () => _viewServiceCategory(service),
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Image
              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(service.name),
                    size: 32,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              // Service Details
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${service.rating}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' (${service.reviewCount})',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessCard(ThemeData theme, Business business) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: InkWell(
        onTap: () => _viewBusinessDetails(business),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Business Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  child: Icon(
                    _getCategoryIcon(business.category),
                    color: theme.colorScheme.primary,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Business Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      business.category,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${business.address} • ${business.distance} mi',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${business.rating}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' (${business.reviewCount})',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialOfferCard(ThemeData theme) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _viewSpecialOffer(),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Offer Banner
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Icon(
                      Icons.spa_outlined,
                      size: 80,
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimary.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Special Offer',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '20% OFF',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'On your first spa booking',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Offer Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wellness Spa Center',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Use code: FIRSTSPA20',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Valid until June 30, 2025',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () => _bookNow(),
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Action methods
  void _openNotifications() {
    // Open notifications page
    print('Open notifications');
  }

  void _showFilters() {
    // Show search filters
    print('Show filters');
  }

  void _performSearch(String query) {
    // Perform search
    print('Search for: $query');
  }

  void _removeRecentSearch(String search) {
    // Remove from recent searches
    print('Remove search: $search');
  }

  void _viewAllBookings() {
    // Navigate to bookings page
    print('View all bookings');
  }

  void _viewBookingDetails(Booking booking) {
    // Navigate to booking details
    print('View booking details: ${booking.id}');
  }

  void _rescheduleBooking(Booking booking) {
    // Navigate to reschedule page
    print('Reschedule booking: ${booking.id}');
  }

  void _viewServiceCategory(ServiceModel service) {
    // Navigate to service category
    print('View service category: ${service.name}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceDetailsAndBookingsPage(service: service),
      ),
    );
  }

  void _viewAllBusinesses() {
    // Navigate to all businesses
    print('View all businesses');
  }

  void _viewBusinessDetails(Business business) {
    // Navigate to business details
    print('View business details: ${business.name}');
  }

  void _viewSpecialOffer() {
    // Navigate to special offer details
    print('View special offer details');
  }

  void _bookNow() {
    // Navigate to booking flow
    print('Book now - special offer');
  }

  // Helper methods
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

  IconData _getCategoryIcon(String category) {
    if (category.toLowerCase().contains('spa') ||
        category.toLowerCase().contains('massage')) {
      return Icons.spa;
    } else if (category.toLowerCase().contains('hair') ||
        category.toLowerCase().contains('beauty')) {
      return Icons.content_cut;
    } else if (category.toLowerCase().contains('health') ||
        category.toLowerCase().contains('wellness')) {
      return Icons.favorite;
    } else if (category.toLowerCase().contains('fitness') ||
        category.toLowerCase().contains('training')) {
      return Icons.fitness_center;
    }
    return Icons.category;
  }
}

// Model classes
class Booking {
  final String id;
  final String serviceName;
  final String businessName;
  final DateTime date;
  final String timeSlot;
  final double price;
  final BookingStatus status;
  final String imageUrl;

  Booking({
    required this.id,
    required this.serviceName,
    required this.businessName,
    required this.date,
    required this.timeSlot,
    required this.price,
    required this.status,
    required this.imageUrl,
  });
}

enum BookingStatus { confirmed, pending, cancelled, completed }

class Service {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });
}

class Business {
  final String id;
  final String name;
  final String category;
  final String address;
  final double distance;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  Business({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
  });
}
