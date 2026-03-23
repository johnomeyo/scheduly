import 'package:flutter/material.dart';
import 'package:scheduly/models/review_model.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/utils.dart/utils.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat('MMMM d, yyyy').format(review.date);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: applyOpacity(theme.colorScheme.outline, 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: applyOpacity(theme.colorScheme.primary, 0.2),
                  child: Text(
                    review.reviewerName.isNotEmpty
                        ? review.reviewerName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.reviewerName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formattedDate,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: applyOpacity(theme.colorScheme.onSurface, 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      review.rating.toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(review.comment, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
