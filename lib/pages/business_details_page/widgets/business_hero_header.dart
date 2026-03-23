import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart';
import 'package:scheduly/utils.dart/utils.dart';

class BusinessHeroHeader extends StatelessWidget {
  final BusinessModel business;
  const BusinessHeroHeader({super.key, required this.business});

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
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Icon(Icons.spa, size: 240, color: applyOpacity(Colors.white, 1.0)), 
              ),
            ),
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
                          color: applyOpacity(Colors.white, 1.0),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          backgroundImage: business.imageUrl != null
                              ? NetworkImage(business.imageUrl!)
                              : null, 
                           child: business.imageUrl == null
                               ? Icon(Icons.business, size: 32, color: theme.colorScheme.onPrimaryContainer) 
                               : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              business.name, 
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: applyOpacity(Colors.white, 1.0), 
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              business.tagline,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: applyOpacity(Colors.white, 0.9),
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
                        color: applyOpacity(Colors.white, 0.9),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        business.location, // Use model data
                        style: theme.textTheme.bodyMedium?.copyWith(
                           // Corrected from withValues to withOpacity
                          color: applyOpacity(Colors.white, 0.9),
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