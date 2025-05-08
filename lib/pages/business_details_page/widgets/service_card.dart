import 'package:flutter/material.dart';
import 'package:scheduly/models/service_model.dart'; // Import ServiceModel

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onBookPressed; // Callback for the Book button

  const ServiceCard({
    super.key,
    required this.service,
    required this.onBookPressed,
  });

  // Corrected from withValues to withOpacity
   Color _applyOpacity(Color color, double opacity) {
      return color.withValues(alpha: opacity);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name, // Use model data
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            service.price, // Use model data
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '· ${service.duration}', // Use model data
                            style: theme.textTheme.bodyMedium?.copyWith(
                               // Corrected from withValues to withOpacity
                              color: _applyOpacity(theme.colorScheme.onSurface, 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: onBookPressed, // Use callback
                  child: const Text('Book'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              service.description, // Use model data
              style: theme.textTheme.bodyMedium?.copyWith(
                 // Corrected from withValues to withOpacity
                color: _applyOpacity(theme.colorScheme.onSurface, 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}