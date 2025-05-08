// File: lib/pages/all_popular_businesses_page/widgets/business_search_field.dart

import 'package:flutter/material.dart';

/// A styled text input field specifically designed for searching.
///
/// This widget is stateless and provides a consistent search bar appearance.
/// It invokes the [onChanged] callback whenever the text in the field is modified by the user.
/// An optional [controller] can be provided for more advanced control over the text field.
class BusinessSearchField extends StatelessWidget {
  /// Callback function that is triggered when the text in the search field changes.
  /// The current text string is passed as an argument.
  final ValueChanged<String> onChanged;

  /// The hint text to display within the search field when it is empty.
  final String hintText;

  /// An optional [TextEditingController] to manage the text field's content.
  final TextEditingController? controller;

  const BusinessSearchField({
    super.key,
    required this.onChanged,
    this.hintText = 'Search businesses...', // Default hint
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 1.5, // Slightly thicker border for focus indication
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
      ),
    );
  }
}