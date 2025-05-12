// File: lib/pages/all_popular_businesses_page/widgets/filtered_business_list.dart

import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart'; // Adjust import path
import './business_card.dart'; // Import the BusinessCard

/// Displays a list of businesses or a message if no businesses are found.
///
/// This widget is stateless and takes a list of [BusinessModel] objects.
/// It uses [BusinessCard] to render each business item and provides an
/// [onBusinessTap] callback for handling interactions.
class FilteredBusinessList extends StatelessWidget {
  /// The list of businesses to display after filtering.
  final List<BusinessModel> filteredBusinesses;

  /// Callback function triggered when a business card is tapped.
  /// It passes the tapped [BusinessModel] as an argument.
  final Function(BusinessModel) onBusinessTap;

  const FilteredBusinessList({
    super.key,
    required this.filteredBusinesses,
    required this.onBusinessTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (filteredBusinesses.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Increased padding for empty state
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off_rounded, // A slightly different icon
                size: 56, // Larger icon
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 16.0),
              Text(
                'No businesses found',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Try broadening your search terms or check back later.', // Slightly more informative message
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
      itemCount: filteredBusinesses.length,
      itemBuilder: (context, index) {
        final business = filteredBusinesses[index];
        return BusinessCard(
          business: business,
          onTap: () => onBusinessTap(business),
        );
      },
    );
  }
}