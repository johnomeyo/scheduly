import 'package:flutter/material.dart';
import 'package:scheduly/constants/app_constants.dart' show faqs;

// Main Help Center Page Widget
class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help Center',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        // Optional: Add elevation or background color if needed
        // backgroundColor: theme.colorScheme.surface,
        // elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ), // Add vertical padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar (Optional but recommended)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: _HelpSearchBar(),
            ),
            const SizedBox(height: 24),

            // 2. Section Header: FAQs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Frequently Asked Questions',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 3. FAQ List Section
            const _FaqSection(),

            const SizedBox(height: 24),

            // 4. Section Header: Contact Us
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Need More Help?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 5. Contact Options Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: _ContactOptionsSection(),
            ),

            const SizedBox(height: 32), // Bottom padding
          ],
        ),
      ),
    );
  }
}

// --- Helper Widgets ---

// Search Bar Widget
class _HelpSearchBar extends StatelessWidget {
  const _HelpSearchBar(); // Private constructor

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      // controller: _searchController, // Add controller for stateful logic
      // onChanged: _handleSearch,    // Add onChanged for stateful logic
      decoration: InputDecoration(
        hintText: 'Search help articles...',
        prefixIcon: Icon(
          Icons.search,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // No border for a cleaner look
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
        ), // Adjust padding
      ),
    );
  }
}

// FAQ Section Widget
class _FaqSection extends StatelessWidget {
  const _FaqSection(); // Private constructor

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Using Card for slight elevation and grouping
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      elevation: 0.5, // Subtle elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      clipBehavior: Clip.antiAlias, // Clip content to rounded corners
      child: Column(
        children: List.generate(faqs.length, (index) {
          final faq = faqs[index];
          return ExpansionTile(
            // Customize expansion tile appearance
            shape: const Border(), // Remove default border when expanded
            collapsedShape:
                const Border(), // Remove default border when collapsed
            backgroundColor: theme.colorScheme.surface,
            collapsedBackgroundColor: theme.colorScheme.surface,
            iconColor: theme.colorScheme.primary,
            collapsedIconColor: theme.colorScheme.onSurfaceVariant,
            textColor: theme.colorScheme.primary,
            collapsedTextColor: theme.colorScheme.onSurface,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            title: Text(
              faq['question']!,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ), // Slightly bolder title
            ),
            // Add divider conditionally except for the last item
            trailing:
                index < faqs.length - 1
                    ? const Icon(Icons.keyboard_arrow_down) // Default icon
                    : null, // No icon for the last item to avoid double divider look
            onExpansionChanged: (isExpanded) {
              // Optional: Handle expansion state change if needed
            },
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  faq['answer']!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4, // Improve readability with line height
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// Contact Options Section Widget
class _ContactOptionsSection extends StatelessWidget {
  const _ContactOptionsSection(); // Private constructor

  // Helper to build styled list tiles for contact options
  Widget _buildContactTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.secondaryContainer,
        foregroundColor: theme.colorScheme.onSecondaryContainer,
        child: Icon(icon, size: 20),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 0,
      ), // Adjust padding if needed
    );
  }

  @override
  Widget build(BuildContext context) {
    // No Card needed here if tiles are styled directly or placed in a list
    return Column(
      children: [
        _buildContactTile(
          context: context,
          icon: Icons.email_outlined,
          title: 'Email Support',
          subtitle: 'Get help via email (support@scheduly.app)',
          onTap: () {
            //  Implement email launching logic (e.g., using url_launcher)
          },
        ),

        const Divider(height: 1),
        _buildContactTile(
          context: context,
          icon: Icons.phone_outlined,
          title: 'Call Us',
          subtitle: 'Speak to our support team (+254 700 123 456)',
          onTap: () {
            //  Implement phone call launching logic (e.g., using url_launcher)
          },
        ),
      ],
    );
  }
}
