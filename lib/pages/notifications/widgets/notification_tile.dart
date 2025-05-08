
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final String time;
  final ThemeData theme;

  const NotificationTile({super.key, 
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
