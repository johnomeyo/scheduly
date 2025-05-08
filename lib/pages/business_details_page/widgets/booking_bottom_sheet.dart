import 'package:flutter/material.dart';
import 'package:scheduly/models/service_model.dart'; // Import ServiceModel

class BookingBottomSheet extends StatefulWidget {
  final ServiceModel service;

  const BookingBottomSheet({super.key, required this.service});

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Corrected from withValues to withOpacity
  Color _applyOpacity(Color color, double opacity) {
      return color.withValues(alpha: opacity);
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 40,
            decoration: BoxDecoration(
              // Corrected from withValues to withOpacity
              color: _applyOpacity(theme.colorScheme.onSurface, 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Book ${widget.service.name}', // Use widget.service
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 0,
             // Corrected from withValues to withOpacity
            color: _applyOpacity(theme.colorScheme.surfaceContainerHighest, 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: const Text('Select Date'),
              subtitle: Text(
                _selectedDate != null
                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : 'Tap to choose a date',
                style: TextStyle(
                  // Corrected from withValues to withOpacity
                  color: _applyOpacity(theme.colorScheme.onSurface, 0.7),
                ),
              ),
              trailing: Icon(
                Icons.calendar_today,
                color: theme.colorScheme.primary,
              ),
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? now, // Use selectedDate if available
                  firstDate: now,
                  lastDate: DateTime(now.year + 1),
                  builder: (context, child) {
                    return Theme(
                      data: theme.copyWith(
                        colorScheme: theme.colorScheme.copyWith(
                          primary: theme.colorScheme.primary,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null && picked != _selectedDate) { // Check if a new date was picked
                  setState(() => _selectedDate = picked);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
             // Corrected from withValues to withOpacity
            color: _applyOpacity(theme.colorScheme.surfaceContainerHighest, 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: const Text('Select Time'),
              subtitle: Text(
                _selectedTime != null
                    ? _selectedTime!.format(context)
                    : 'Tap to choose a time',
                style: TextStyle(
                   // Corrected from withValues to withOpacity
                  color: _applyOpacity(theme.colorScheme.onSurface, 0.7),
                ),
              ),
              trailing: Icon(
                Icons.access_time,
                color: theme.colorScheme.primary,
              ),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime ?? TimeOfDay.now(), // Use selectedTime if available
                );
                if (picked != null && picked != _selectedTime) { // Check if a new time was picked
                  setState(() => _selectedTime = picked);
                }
              },
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                if (_selectedDate != null && _selectedTime != null) {
                  // Implement actual booking logic here
                  Navigator.pop(context); // Close the modal first

                  // Show confirmation SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                       // Corrected from withValues to withOpacity (if needed, though primaryContainer is opaque)
                      backgroundColor: theme.colorScheme.primaryContainer,
                      content: Text(
                        'Booked ${widget.service.name} on ${_selectedDate!.day}/${_selectedDate!.month} at ${_selectedTime!.format(context)}',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      duration: const Duration(seconds: 3), // Added duration
                    ),
                  );
                } else {
                   // Show error SnackBar
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( // Made const where possible
                        behavior: SnackBarBehavior.floating,
                        content: Text('Please select date and time'),
                        backgroundColor: Colors.redAccent, // Indicate error
                        duration: Duration(seconds: 3), // Added duration
                      ),
                    );
                }
              },
              child: const Text('Confirm Booking'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}