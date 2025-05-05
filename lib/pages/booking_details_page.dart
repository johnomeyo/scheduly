import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/business.dart';

class BookingDetailsPage extends StatelessWidget {
  final Booking booking;
  final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');

  BookingDetailsPage({
    super.key,
    required this.booking,
  });

  IconData _getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'massage':
        return Icons.spa;
      case 'haircut':
        return Icons.content_cut;
      case 'gym':
        return Icons.fitness_center;
      default:
        return Icons.calendar_today;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with service icon
            ServiceHeader(
              serviceName: booking.serviceName,
              icon: _getServiceIcon(booking.serviceName),
              theme: theme,
            ),
            
            // Booking details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailSection(
                    title: 'Appointment Details',
                    children: [
                      DetailRow(
                        icon: Icons.business,
                        label: 'Business',
                        value: booking.businessName,
                      ),
                      DetailRow(
                        icon: Icons.category,
                        label: 'Service',
                        value: booking.serviceName,
                      ),
                      DetailRow(
                        icon: Icons.calendar_today,
                        label: 'Date',
                        value: dateFormat.format(booking.date),
                      ),
                      DetailRow(
                        icon: Icons.access_time,
                        label: 'Time',
                        value: booking.timeSlot,
                      ),
                      DetailRow(
                        icon: Icons.attach_money,
                        label: 'Price',
                        value: '\$${booking.price}',
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          label: const Text('Close'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            // You might want to add navigation to reschedule page here
                          },
                          icon: const Icon(Icons.edit_calendar),
                          label: const Text('Reschedule'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Cancel button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showCancelConfirmation(context);
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancel Appointment'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                        side: BorderSide(color: theme.colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment?'),
        content: Text(
          'Are you sure you want to cancel your ${booking.serviceName} appointment on ${dateFormat.format(booking.date)} at ${booking.timeSlot.split(' - ').first}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Keep Appointment',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement cancellation logic here
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous screen
              
              // Show cancellation confirmation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment cancelled successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
            ),
            child: const Text('Cancel Appointment'),
          ),
        ],
      ),
    );
  }
}

class ServiceHeader extends StatelessWidget {
  final String serviceName;
  final IconData icon;
  final ThemeData theme;

  const ServiceHeader({
    super.key,
    required this.serviceName,
    required this.icon,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withValues(alpha:0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 48,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            serviceName,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const DetailSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha:0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}