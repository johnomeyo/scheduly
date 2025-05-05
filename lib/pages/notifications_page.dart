import 'package:flutter/material.dart';

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
          return _NotificationTile(
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

class _NotificationTile extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final String time;
  final ThemeData theme;

  const _NotificationTile({
    required this.title,
    required this.body,
    required this.icon,
    required this.time,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(body, style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(time,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                )),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
