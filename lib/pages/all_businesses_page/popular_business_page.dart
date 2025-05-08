
import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart';
import 'package:scheduly/pages/business_details_page/business_details_page.dart';

// Import the newly created reusable widgets
import 'widgets/business_search_field.dart';
import 'widgets/filtered_business_list.dart';

/// A page that displays a list of popular businesses, allowing users to
/// search through them by name or location.
///
/// This page takes an initial list of [BusinessModel] instances.
/// The categories filter has been removed, and search functionality
/// operates on business names and locations.
class AllPopularBusinessesPage extends StatefulWidget {
  /// The initial list of all businesses to be displayed and searched.
  final List<BusinessModel> businesses;

  const AllPopularBusinessesPage({
    super.key,
    required this.businesses,
  });

  @override
  State<AllPopularBusinessesPage> createState() => _AllPopularBusinessesPageState();
}

class _AllPopularBusinessesPageState extends State<AllPopularBusinessesPage> {
  /// The current text entered by the user in the search field.
  String _searchQuery = '';

  /// The list of businesses that match the current search query.
  List<BusinessModel> _filteredBusinesses = [];

  /// Controller for the search text field.
  /// Useful for clearing the search or programmatically setting text.
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the filtered list. Since search query is initially empty,
    // this will show all businesses.
    _applySearchFilter();

    // Optional: Add a listener to the controller if you need to react to changes
    // in more complex ways (e.g., debouncing) than the direct onChanged callback.
    // _searchController.addListener(_onSearchControllerChanged);
  }

  @override
  void didUpdateWidget(covariant AllPopularBusinessesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the underlying list of businesses changes (e.g., fetched from a new source),
    // re-apply the current search filter.
    if (widget.businesses != oldWidget.businesses) {
      _applySearchFilter();
    }
  }

  /// Handles changes to the search query from the [BusinessSearchField].
  /// Updates the [_searchQuery] state and re-applies the filter.
  void _handleSearchQueryChanged(String query) {
    // Only update and re-filter if the query has actually changed.
    // This prevents unnecessary rebuilds if onChanged fires with the same value.
    if (_searchQuery != query) {
      setState(() {
        _searchQuery = query;
      });
      _applySearchFilter();
    }
  }

  /// Filters [widget.businesses] based on the current [_searchQuery].
  /// Updates the [_filteredBusinesses] list, triggering a UI refresh.
  void _applySearchFilter() {
    final businessesToFilter = widget.businesses; // Use the current list from the widget

    if (_searchQuery.isEmpty) {
      // If search is empty, show all businesses. Create a new list instance.
      setState(() {
        _filteredBusinesses = List<BusinessModel>.from(businessesToFilter);
      });
    } else {
      final lowerCaseQuery = _searchQuery.toLowerCase();
      setState(() {
        _filteredBusinesses = businessesToFilter.where((business) {
          // Search matches if query is found in business name OR location.
          final nameMatch = business.name.toLowerCase().contains(lowerCaseQuery);
          final locationMatch = business.location.toLowerCase().contains(lowerCaseQuery);
          // To search in tagline as well (if it was part of search criteria before category removal):
          // final taglineMatch = business.tagline.toLowerCase().contains(lowerCaseQuery);
          // return nameMatch || locationMatch || taglineMatch;
          return nameMatch || locationMatch;
        }).toList();
      });
    }
  }

  /// Navigates to the [BusinessDetailsPage] for the given [business].
  void _viewBusinessDetails(BusinessModel business) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessDetailsPage(business: business),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose the controller when the widget is removed from the tree.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Businesses',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure children can expand horizontally
        children: [
          // Search Bar
          BusinessSearchField(
            controller: _searchController,
            onChanged: _handleSearchQueryChanged,
            hintText: 'Search by name or location...', // More specific hint
          ),

          // CATEGORIES SECTION IS REMOVED.

          // Results Count
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0), // Adjusted top padding
            child: Text(
              _filteredBusinesses.length == 1
                  ? '1 business found'
                  : '${_filteredBusinesses.length} businesses found',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),

          // Businesses List
          Expanded(
            child: FilteredBusinessList(
              filteredBusinesses: _filteredBusinesses,
              onBusinessTap: _viewBusinessDetails,
            ),
          ),
        ],
      ),
    );
  }
}