import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({
    super.key,
    required this.business,
    required this.onTap,
  });

  final BusinessModel business;
  final VoidCallback onTap;

  // Helper method for category icons - can be moved to a separate helper if needed
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Business Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  // Use a placeholder image if business.imageUrl is null or empty
                  imageUrl: business.imageUrl ?? "https://via.placeholder.com/80",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    child: const Center( // Added Center for better alignment
                      child: Icon(
                        Icons.business, // Generic placeholder icon
                        size: 32,
                        // Color will be applied by the parent container color filter if needed,
                        // or you can set it explicitly here if you want a different color for the placeholder
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                     color: theme.colorScheme.primary.withOpacity(0.1),
                    child: Center( // Added Center for better alignment
                      child: Icon(
                         // Use category icon on error
                        _getCategoryIcon(business.tagline),
                        color: theme.colorScheme.primary,
                        size: 32,
                      ),
                    ),
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
                      business.tagline,
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
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            // Placeholder distance
                            '${business.location} • 1 mi',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
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
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
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
}