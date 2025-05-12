// File: lib/pages/all_popular_businesses_page/widgets/business_card.dart

import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart'; // Adjust import path as needed

/// A widget that displays a single business item in a card layout.
///
/// This widget is stateless and responsible for the visual presentation of
/// business details such as its name, tagline, location, and rating.
/// It requires a [BusinessModel] and an [onTap] callback for interaction.
class BusinessCard extends StatelessWidget {
  /// The business data to be displayed in the card.
  final BusinessModel business;

  /// Callback function triggered when the card is tapped.
  final VoidCallback onTap;

  const BusinessCard({
    super.key,
    required this.business,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Provide a default placeholder image if imageUrl is null or empty.
    final imageUrl = (business.imageUrl != null && business.imageUrl!.isNotEmpty)
        ? business.imageUrl!
        : 'https://shop.raceya.fit/wp-content/uploads/2020/11/logo-placeholder.jpg';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0, // As per original styling
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0), // Match card's border radius for ripple effect
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Business Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: 80,
                  height: 80,
                  color: theme.colorScheme.primary.withValues(alpha: 0.1), // Placeholder background
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    // Enhancements for image loading and errors
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.storefront_outlined, size: 40, color: theme.colorScheme.onSurface.withValues(alpha: 0.4));
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16.0),

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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      business.tagline,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    _BusinessLocationInfo(location: business.location),
                    const SizedBox(height: 4.0),
                    _BusinessRatingInfo(rating: business.rating, reviewCount: business.reviewCount),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Private helper widget to display business location information.
class _BusinessLocationInfo extends StatelessWidget {
  final String location;
  // final String? distance; // Could be added if distance calculation is implemented

  const _BusinessLocationInfo({required this.location /*, this.distance */});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // String displayText = location;
    // if (distance != null && distance!.isNotEmpty) {
    //   displayText += ' • $distance';
    // }

    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 14,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: Text(
            location, // Using location directly as per current requirement
            // displayText, // Use this if distance is included
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Private helper widget to display business rating information.
class _BusinessRatingInfo extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const _BusinessRatingInfo({required this.rating, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(Icons.star_rounded, size: 16, color: Colors.amber.shade600), // Using amber.shade600 for better visibility
        const SizedBox(width: 4.0),
        Text(
          rating.toStringAsFixed(1), // Format to one decimal place
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          ' ($reviewCount review${reviewCount == 1 ? "" : "s"})', // Grammatically correct pluralization
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}