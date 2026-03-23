import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart';
import 'package:scheduly/models/service_model.dart';
import 'package:scheduly/pages/all_reviews_page.dart/all_reviews_page.dart'
    show AllReviewsPage;
import 'package:scheduly/pages/business_details_page/widgets/call_business_page.dart'
    show CallBusinessButton;
import 'package:scheduly/pages/business_details_page/widgets/review_button.dart';
import 'package:scheduly/utils.dart/utils.dart';
import 'widgets/booking_bottom_sheet.dart';
import 'widgets/rating_display.dart';
import 'widgets/feature_chip.dart';
import 'widgets/review_item.dart';
import 'widgets/service_card.dart';
import 'widgets/business_hero_header.dart';

class BusinessDetailsPage extends StatelessWidget {
  final BusinessModel business;

  const BusinessDetailsPage({super.key, required this.business});
  void showBookingSheet(BuildContext context, ServiceModel service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Theme.of(context).colorScheme.surface, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return BookingBottomSheet(service: service);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: applyOpacity(Colors.white, 1.0),
        )
      ),
      body: CustomScrollView(
        slivers: [
          BusinessHeroHeader(business: business),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingDisplay(
                          rating: business.rating, 
                          reviewCount: business.reviewCount, 
                        ),
                        CallBusinessButton(phoneNumber: business.contactNumber),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: applyOpacity(theme.colorScheme.shadow, 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          business.about,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Feature Chips
                        Wrap(
                          spacing: 8,
                          runSpacing:
                              8, 
                          children:
                              business.features.map((featureText) {
                                IconData iconData =
                                    Icons.check_circle; 
                                if (featureText.toLowerCase().contains(
                                  'open',
                                )) {
                                  iconData = Icons.schedule;
                                } else if (featureText.toLowerCase().contains(
                                  'time',
                                )) {
                                  iconData = Icons.watch_later;
                                } 

                                return FeatureChip(
                                  icon: iconData,
                                  label: featureText,
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Available Services',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...business.services.map(
                    (service) => ServiceCard(
                      service: service, 
                      onBookPressed:
                          () => showBookingSheet(
                            context,
                            service,
                          ), 
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Reviews Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Customer Reviews',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      ReviewButton(
                        onReviewSubmitted: (newReview) {
                          // Handle the new review here
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  ...business.reviews
                      .take(
                        business.reviews.length > 3
                            ? 3
                            : business.reviews.length,
                      )
                      .map((review) => ReviewItem(review: review)),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    AllReviewsPage(reviews: business.reviews),
                          ),
                        );
                      },
                      child: const Text('View All Reviews'),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
