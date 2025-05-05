import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/constants/data.dart';
import 'package:scheduly/models/business.dart';
import 'package:scheduly/pages/business_details_page.dart';
import 'package:scheduly/pages/homepage/featured_services_section.dart';
import 'package:scheduly/pages/homepage/home_header_section.dart';
import 'package:scheduly/pages/homepage/next_appointement_section.dart';
import 'package:scheduly/pages/homepage/special_offer_section.dart';
import 'package:scheduly/pages/popular_business_page.dart'
    show AllPopularBusinessesPage;
import 'package:scheduly/pages/service_bookings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Search
            HomeHeaderSection(),

            // Next Appointment
            NextAppointmentSection(
              upcomingBookings: upcomingBookings,
              dateFormat: DateFormat('MMM dd, yyyy'),
            ),

            // // Category Services Cards
            FeaturedServicesSection(
              services: services,
              onServiceTap:
                  (service) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                              ServiceDetailsAndBookingsPage(service: service),
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
                      onPressed: () => _viewAllBusinesses(context),
                      child: const Text('View All'),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _buildBusinessCard(theme, popularBusinesses[index]);
              }, childCount: popularBusinesses.length),
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
                    const SpecialOfferCard(),
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

  void _viewAllBusinesses(BuildContext context) {
    // Navigate to all businesses
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                AllPopularBusinessesPage(businesses: popularBusinesses),
      ),
    );
  }

  void _viewBusinessDetails(Business business) {
    // Navigate to business details
    // Navigate to business details
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessDetailsPage()),
    );
  }

  // Helper methods

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
