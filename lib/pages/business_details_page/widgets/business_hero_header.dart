import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart'; // Import BusinessModel

class BusinessHeroHeader extends StatelessWidget {
  final BusinessModel business;

  const BusinessHeroHeader({super.key, required this.business});

  // Corrected from withValues to withOpacity
   Color _applyOpacity(Color color, double opacity) {
      return color.withValues(alpha:opacity);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primaryContainer,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              // Corrected from withValues to withOpacity
              child: Opacity(
                opacity: 0.1,
                child: Icon(Icons.spa, size: 240, color: _applyOpacity(Colors.white, 1.0)), // Use white explicitly with opacity
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: _applyOpacity(Colors.white, 1.0), // Use white explicitly
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          // Use business.imageUrl if available, otherwise a placeholder
                          backgroundImage: business.imageUrl != null
                              ? NetworkImage(business.imageUrl!)
                              : null, // Provide a placeholder or remove if no image
                           child: business.imageUrl == null
                               ? Icon(Icons.business, size: 32, color: theme.colorScheme.onPrimaryContainer) // Placeholder icon
                               : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              business.name, // Use model data
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: _applyOpacity(Colors.white, 1.0), // Use white explicitly
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              business.tagline, // Use model data
                              style: theme.textTheme.titleMedium?.copyWith(
                                 // Corrected from withValues to withOpacity
                                color: _applyOpacity(Colors.white, 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                         // Corrected from withValues to withOpacity
                        color: _applyOpacity(Colors.white, 0.9),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        business.location, // Use model data
                        style: theme.textTheme.bodyMedium?.copyWith(
                           // Corrected from withValues to withOpacity
                          color: _applyOpacity(Colors.white, 0.9),
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
    );
  }
}