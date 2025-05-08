import 'package:flutter/material.dart';
import 'package:scheduly/pages/notifications/widgets/notification_tile.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final notifications = [
      {
        'title': 'Booking Confirmed',
        'body': 'Your appointment at Glow Spa is confirmed for May 6, 10:00 AM.',
        'icon': Icons.check_circle_outline,
        'time': '2h ago',
      },
      {
        'title': 'New Offer',
        'body': 'Get 15% off on your next massage. Use code: RELAX15.',
        'icon': Icons.local_offer_outlined,
        'time': 'Yesterday',
      },
      {
        'title': 'Reminder',
        'body': 'Your haircut at Style Studio is tomorrow at 3:00 PM.',
        'icon': Icons.notifications_none,
        'time': '2 days ago',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationTile(
            title: notification['title'] as String,
            body: notification['body'] as String,
            icon: notification['icon'] as IconData,
            time: notification['time'] as String,
            theme: theme,
          );
        },
      ),
    );
  }
}
