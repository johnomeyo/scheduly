import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart';

class BusinessCard extends StatelessWidget {
  final BusinessModel business;
  final VoidCallback onTap;

  const BusinessCard({super.key, required this.business, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl =
        (business.imageUrl != null && business.imageUrl!.isNotEmpty)
            ? business.imageUrl!
            : 'https://shop.raceya.fit/wp-content/uploads/2020/11/logo-placeholder.jpg';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
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
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.storefront_outlined,
                        size: 40,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.4,
                        ),
                      );
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
                    BusinessLocationInfo(location: business.location),
                    const SizedBox(height: 4.0),
                    BusinessRatingInfo(
                      rating: business.rating,
                      reviewCount: business.reviewCount,
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
}

class BusinessLocationInfo extends StatelessWidget {
  final String location;
  const BusinessLocationInfo({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            location,
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

class BusinessRatingInfo extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const BusinessRatingInfo({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(Icons.star_rounded, size: 16, color: Colors.amber.shade600),
        const SizedBox(width: 4.0),
        Text(
          rating.toStringAsFixed(1),
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          ' ($reviewCount review${reviewCount == 1 ? "" : "s"})',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
