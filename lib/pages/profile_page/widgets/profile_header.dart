import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String memberSince;
  final String? imageUrl; // Optional image URL

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.memberSince,
    this.imageUrl,
  });

  // Helper moved here as it's specific to this widget
  String _getInitials(String name) {
    final nameParts = name.trim().split(' ');
    if (nameParts.length >= 2 &&
        nameParts[0].isNotEmpty &&
        nameParts[1].isNotEmpty) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty && nameParts[0].isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    return 'U'; // Default fallback
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get theme inside the build method

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // Example: Use surface color
        // Consider softer shadow or removing if page has elevation/cards
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05), // Use withValues
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile image/initials
          CircleAvatar(
            radius: 50, // Slightly larger?
            backgroundColor: theme.colorScheme.primaryContainer,
            // Use imageUrl if provided, otherwise show initials
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            child:
                imageUrl == null
                    ? Text(
                      _getInitials(name),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    : null, // Don't show text if image is present
          ),

          const SizedBox(height: 16),

          // User name
          Text(
            name,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // User email
          Text(
            email,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant, // Use variant color
            ),
          ),

          const SizedBox(height: 4),

          // User phone
          Text(
            phone,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 16),

          // Member since badge (using Chip is often more standard)
          Chip(
            avatar: Icon(
              Icons.star,
              size: 16,
              color: theme.colorScheme.primary,
            ),
            label: Text(
              'Member since $memberSince',
              style: theme.textTheme.labelMedium?.copyWith(
                // Use labelMedium
                color: theme.colorScheme.primary,
                // fontWeight: FontWeight.w500, // Often default for labels
              ),
            ),
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            shape: StadiumBorder(
              side: BorderSide(color: Colors.transparent),
            ), // cleaner look
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
        ],
      ),
    );
  }
}
