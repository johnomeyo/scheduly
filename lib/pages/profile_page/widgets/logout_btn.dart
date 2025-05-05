import 'package:flutter/material.dart';

class LogoutButtonWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButtonWidget({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Adjusted padding
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onLogout,
          icon: Icon(Icons.logout, color: theme.colorScheme.error),
          label: Text(
            'Log Out',
            style: TextStyle(
                color: theme.colorScheme.error, fontWeight: FontWeight.bold),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: theme.colorScheme.error, width: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 14), // Slightly more padding
            shape: RoundedRectangleBorder( // Consistent rounded corners
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}