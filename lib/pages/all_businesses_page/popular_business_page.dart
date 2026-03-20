import 'package:flutter/material.dart';
import 'package:scheduly/models/business_model.dart';
import 'package:scheduly/pages/business_details_page/business_details_page.dart';
import 'widgets/business_search_field.dart';
import 'widgets/filtered_business_list.dart';

class AllPopularBusinessesPage extends StatefulWidget {
  final List<BusinessModel> businesses;

  const AllPopularBusinessesPage({super.key, required this.businesses});

  @override
  State<AllPopularBusinessesPage> createState() =>
      _AllPopularBusinessesPageState();
}

class _AllPopularBusinessesPageState extends State<AllPopularBusinessesPage> {
  String _searchQuery = '';
  List<BusinessModel> _filteredBusinesses = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _applySearchFilter();
  }

  @override
  void didUpdateWidget(covariant AllPopularBusinessesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.businesses != oldWidget.businesses) {
      _applySearchFilter();
    }
  }

  void _handleSearchQueryChanged(String query) {
    if (_searchQuery != query) {
      setState(() {
        _searchQuery = query;
      });
      _applySearchFilter();
    }
  }

  void _applySearchFilter() {
    final businessesToFilter =
        widget.businesses; 
    if (_searchQuery.isEmpty) {
      setState(() {
        _filteredBusinesses = List<BusinessModel>.from(businessesToFilter);
      });
    } else {
      final lowerCaseQuery = _searchQuery.toLowerCase();
      setState(() {
        _filteredBusinesses =
            businessesToFilter.where((business) {
              final nameMatch = business.name.toLowerCase().contains(
                lowerCaseQuery,
              );
              final locationMatch = business.location.toLowerCase().contains(
                lowerCaseQuery,
              );
              return nameMatch || locationMatch;
            }).toList();
      });
    }
  }

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
    _searchController.dispose();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BusinessSearchField(
            controller: _searchController,
            onChanged: _handleSearchQueryChanged,
            hintText: 'Search by name or location...',
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
            child: Text(
              _filteredBusinesses.length == 1
                  ? '1 business found'
                  : '${_filteredBusinesses.length} businesses found',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),

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
