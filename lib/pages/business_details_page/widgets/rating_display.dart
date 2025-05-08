import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const RatingDisplay({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  // Corrected from withValues to withOpacity
   Color _applyOpacity(Color color, double opacity) {
      return color.withValues(alpha: opacity);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                rating.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.star, color: theme.colorScheme.onPrimary, size: 18),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$reviewCount reviews',
          style: theme.textTheme.bodyMedium?.copyWith(
            // Corrected from withValues to withOpacity
             color: _applyOpacity(theme.colorScheme.onSurface, 0.7),
          ),
        ),
      ],
    );
  }
}