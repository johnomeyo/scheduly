import 'package:flutter/material.dart';
import 'package:scheduly/pages/notifications_page.dart';

class HomeHeaderSection extends StatefulWidget {
  const HomeHeaderSection({super.key});

  @override
  State<HomeHeaderSection> createState() => _HomeHeaderSectionState();
}

class _HomeHeaderSectionState extends State<HomeHeaderSection> {
  final TextEditingController _searchController = TextEditingController();

  List<String> recentSearches = [
    'Massage therapy',
    'Hair salon near me',
    'Personal trainer',
    'Dental check-up',
  ];

  void _performSearch(String query) {
    // Perform search logic here
    debugPrint('Searching for: $query');
  }

  void _removeRecentSearch(String search) {
    setState(() {
      recentSearches.remove(search);
    });
  }

  void _showFilters() {
    // Show filter bottom sheet or dialog
    debugPrint('Filter clicked');
  }

  void _openNotifications() {
    // Navigate to notification screen
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => const NotificationsPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message and notifications
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning,',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sarah Johnson',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Badge(
                    label: Text('${2}'),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  onPressed: _openNotifications,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search services, businesses...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _showFilters,
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onSubmitted: _performSearch,
            ),

            // Recent searches
            if (recentSearches.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Wrap(
                  spacing: 8,
                  children: recentSearches
                      .map(
                        (search) => Chip(
                          label: Text(search),
                          onDeleted: () => _removeRecentSearch(search),
                          backgroundColor: theme.colorScheme.surface,
                          side: BorderSide(
                            color:
                                theme.colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
