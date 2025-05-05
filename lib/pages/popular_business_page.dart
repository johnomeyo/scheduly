import 'package:flutter/material.dart';
import 'package:scheduly/models/business.dart';
import 'package:scheduly/pages/business_details_page.dart';

class AllPopularBusinessesPage extends StatefulWidget {
  final List<Business> businesses;

  const AllPopularBusinessesPage({
    super.key,
    required this.businesses,
  });

  @override
  State<AllPopularBusinessesPage> createState() => _AllPopularBusinessesPageState();
}

class _AllPopularBusinessesPageState extends State<AllPopularBusinessesPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  List<Business> _filteredBusinesses = [];
  
  @override
  void initState() {
    super.initState();
    _filteredBusinesses = widget.businesses;
  }

  void _filterBusinesses() {
    setState(() {
      _filteredBusinesses = widget.businesses.where((business) {
        // Apply category filter
        bool categoryMatch = _selectedCategory == 'All' || 
                            business.category == _selectedCategory;
        
        // Apply search filter
        bool searchMatch = _searchQuery.isEmpty ||
            business.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            business.address.toLowerCase().contains(_searchQuery.toLowerCase());
        
        return categoryMatch && searchMatch;
      }).toList();
    });
  }

  List<String> _getCategories() {
    final categories = widget.businesses
        .map((business) => business.category)
        .toSet()
        .toList();
    
    return ['All', ...categories];
  }

  IconData _getCategoryIcon(String category) {
    // Map categories to appropriate icons
    switch (category.toLowerCase()) {
      case 'restaurant':
      case 'food':
        return Icons.restaurant;
      case 'salon':
      case 'beauty':
        return Icons.spa;
      case 'fitness':
      case 'gym':
        return Icons.fitness_center;
      case 'healthcare':
      case 'medical':
        return Icons.medical_services;
      case 'retail':
      case 'shopping':
        return Icons.shopping_bag;
      default:
        return Icons.business;
    }
  }

  void _viewBusinessDetails(Business business) {
    // Navigate to business details
   Navigator.push(context, MaterialPageRoute(builder: (context)=>
     BusinessDetailsPage(),
    ));
  }

  Widget _buildBusinessCard(ThemeData theme, Business business) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: InkWell(
        onTap: () => _viewBusinessDetails(business),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Business Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  child: Icon(
                    _getCategoryIcon(business.category),
                    color: theme.colorScheme.primary,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Business Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      business.category,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${business.address} • ${business.distance} km',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${business.rating}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' (${business.reviewCount})',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildCategoryChips() {
    final theme = Theme.of(context);
    final categories = _getCategories();
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(category),
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
                _filterBusinesses();
              },
              backgroundColor: theme.colorScheme.surface,
              selectedColor: theme.colorScheme.primaryContainer,
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected 
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected 
                      ? Colors.transparent
                      : theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
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
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _filterBusinesses();
              },
              decoration: InputDecoration(
                hintText: 'Search businesses...',
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          
          // Category Filter
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Categories',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildCategoryChips(),
              const SizedBox(height: 8),
            ],
          ),
          
          // Results Count
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                Text(
                  '${_filteredBusinesses.length} businesses found',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          
          // Businesses List
          Expanded(
            child: _filteredBusinesses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: theme.colorScheme.onSurface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No businesses found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try changing your search criteria',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    itemCount: _filteredBusinesses.length,
                    itemBuilder: (context, index) {
                      return _buildBusinessCard(theme, _filteredBusinesses[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}