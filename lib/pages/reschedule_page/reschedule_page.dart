// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:scheduly/models/booking_model.dart';

// class ReschedulePage extends StatefulWidget {
//   final Booking booking;

//   const ReschedulePage({super.key, required this.booking});

//   @override
//   State<ReschedulePage> createState() => _ReschedulePageState();
// }

// class _ReschedulePageState extends State<ReschedulePage> {
//   late DateTime selectedDate;
//   String? selectedTimeSlot;
//   final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');

//   // Simulate available time slots for the selected date
//   final Map<String, List<String>> availableTimeSlots = {
//     // Today and tomorrow have the same slots
//     'today': [
//       '09:00 AM - 10:00 AM',
//       '10:30 AM - 11:30 AM',
//       '01:00 PM - 02:00 PM',
//       '03:30 PM - 04:30 PM',
//       '05:00 PM - 06:00 PM',
//     ],
//     'tomorrow': [
//       '09:00 AM - 10:00 AM',
//       '11:30 AM - 12:30 PM',
//       '02:00 PM - 03:00 PM',
//       '04:30 PM - 05:30 PM',
//     ],
//     'dayAfter': [
//       '10:00 AM - 11:00 AM',
//       '12:30 PM - 01:30 PM',
//       '03:00 PM - 04:00 PM',
//       '05:30 PM - 06:30 PM',
//     ],
//   };

//   @override
//   void initState() {
//     super.initState();
//     selectedDate = DateTime.now();
//     _generateMoreTimeSlots(); // Populate more dates
//   }

//   void _generateMoreTimeSlots() {
//     // Generate time slots for next 7 days
//     final now = DateTime.now();
//     for (int i = 3; i < 7; i++) {
//       final date = now.add(Duration(days: i));
//       final key = 'date_${date.year}_${date.month}_${date.day}';

//       // Generate random slots
//       final List<String> slots = [];
//       final baseSlots = [
//         '09:00 AM - 10:00 AM',
//         '10:30 AM - 11:30 AM',
//         '11:00 AM - 12:00 PM',
//         '01:00 PM - 02:00 PM',
//         '02:30 PM - 03:30 PM',
//         '04:00 PM - 05:00 PM',
//         '05:30 PM - 06:30 PM',
//       ];

//       // Randomly select 3-5 slots
//       baseSlots.shuffle();
//       final count = 3 + (date.day % 3); // 3-5 slots per day
//       for (int j = 0; j < count; j++) {
//         if (j < baseSlots.length) {
//           slots.add(baseSlots[j]);
//         }
//       }

//       // Sort the slots by time
//       slots.sort();
//       availableTimeSlots[key] = slots;
//     }
//   }

//   List<String> _getTimeSlotsForDate(DateTime date) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final tomorrow = today.add(const Duration(days: 1));
//     final dayAfter = today.add(const Duration(days: 2));

//     final selectedDay = DateTime(date.year, date.month, date.day);

//     if (selectedDay.isAtSameMomentAs(today)) {
//       return availableTimeSlots['today'] ?? [];
//     } else if (selectedDay.isAtSameMomentAs(tomorrow)) {
//       return availableTimeSlots['tomorrow'] ?? [];
//     } else if (selectedDay.isAtSameMomentAs(dayAfter)) {
//       return availableTimeSlots['dayAfter'] ?? [];
//     } else {
//       final key = 'date_${date.year}_${date.month}_${date.day}';
//       return availableTimeSlots[key] ?? [];
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: Theme.of(context).colorScheme.primary,
//               onPrimary: Theme.of(context).colorScheme.onPrimary,
//               onSurface: Theme.of(context).colorScheme.onSurface,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         selectedTimeSlot = null; // Reset selection when date changes
//       });
//     }
//   }

//   void _confirmReschedule() {
//     if (selectedTimeSlot == null) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select a time slot'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       return;
//     }

//     // Show confirmation dialog
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Confirm Reschedule'),
//             content: Text(
//               'Are you sure you want to reschedule your ${widget.booking.serviceName} appointment to ${dateFormat.format(selectedDate)} at ${selectedTimeSlot?.split(' - ').first}?',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel'),
//               ),
//               FilledButton(
//                 onPressed: () {
//                   // Implement reschedule logic here
//                   Navigator.pop(context); // Close dialog
//                   _showSuccess();
//                 },
//                 child: const Text('Confirm'),
//               ),
//             ],
//           ),
//     );
//   }

//   void _showSuccess() {
//     // Show success dialog and then return to previous screen
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Appointment Rescheduled'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(
//                   Icons.check_circle_outline,
//                   color: Colors.green,
//                   size: 64,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Your appointment has been successfully rescheduled to ${dateFormat.format(selectedDate)} at ${selectedTimeSlot?.split(' - ').first}.',
//                 ),
//               ],
//             ),
//             actions: [
//               FilledButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close dialog
//                   Navigator.pop(context); // Return to previous screen
//                 },
//                 child: const Text('Done'),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final timeSlots = _getTimeSlotsForDate(selectedDate);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reschedule Appointment'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Original booking info
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             color: theme.colorScheme.primary.withValues(alpha: 0.1),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Current Appointment',
//                   style: theme.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: theme.colorScheme.primary,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DetailItem(
//                         label: 'Service',
//                         value: widget.booking.serviceName,
//                         icon: Icons.spa,
//                       ),
//                     ),
//                     Expanded(
//                       child: DetailItem(
//                         label: 'Date',
//                         value: dateFormat.format(widget.booking.date),
//                         icon: Icons.calendar_today,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DetailItem(
//                         label: 'Time',
//                         value: widget.booking.timeSlot.split(' - ').first,
//                         icon: Icons.access_time,
//                       ),
//                     ),
//                     Expanded(
//                       child: DetailItem(
//                         label: 'Business',
//                         value: widget.booking.businessName,
//                         icon: Icons.business,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Divider with text
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Row(
//               children: [
//                 const Expanded(child: Divider()),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     'Select New Date & Time',
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
//                     ),
//                   ),
//                 ),
//                 const Expanded(child: Divider()),
//               ],
//             ),
//           ),

//           // Date picker
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: InkWell(
//               onTap: () => _selectDate(context),
//               borderRadius: BorderRadius.circular(12),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: theme.colorScheme.outline),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.calendar_month,
//                       color: theme.colorScheme.primary,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Date',
//                             style: theme.textTheme.bodySmall?.copyWith(
//                               color: theme.colorScheme.onSurface.withValues(
//                                 alpha: 0.6,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             dateFormat.format(selectedDate),
//                             style: theme.textTheme.bodyLarge,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 16,
//                       color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 24),

//           // Time slots
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Available Time Slots',
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 8),

//           // Time slot grid
//           Expanded(
//             child:
//                 timeSlots.isEmpty
//                     ? Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.event_busy,
//                             size: 48,
//                             color: theme.colorScheme.onSurface.withValues(
//                               alpha: 0.4,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'No available time slots for this date',
//                             style: theme.textTheme.bodyLarge?.copyWith(
//                               color: theme.colorScheme.onSurface.withValues(
//                                 alpha: 0.6,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           TextButton(
//                             onPressed: () => _selectDate(context),
//                             child: const Text('Select Another Date'),
//                           ),
//                         ],
//                       ),
//                     )
//                     : GridView.builder(
//                       padding: const EdgeInsets.all(16),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 2.5,
//                             crossAxisSpacing: 12,
//                             mainAxisSpacing: 12,
//                           ),
//                       itemCount: timeSlots.length,
//                       itemBuilder: (context, index) {
//                         final timeSlot = timeSlots[index];
//                         final bool isSelected = selectedTimeSlot == timeSlot;

//                         return TimeSlotCard(
//                           timeSlot: timeSlot,
//                           isSelected: isSelected,
//                           onTap: () {
//                             setState(() {
//                               selectedTimeSlot = timeSlot;
//                             });
//                           },
//                         );
//                       },
//                     ),
//           ),

//           // Bottom button
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: FilledButton(
//                   onPressed:
//                       selectedTimeSlot != null ? _confirmReschedule : null,
//                   child: const Text('Confirm New Time'),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DetailItem extends StatelessWidget {
//   final String label;
//   final String value;
//   final IconData icon;

//   const DetailItem({
//     super.key,
//     required this.label,
//     required this.value,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Row(
//       children: [
//         Icon(icon, size: 16, color: theme.colorScheme.primary),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
//                 ),
//               ),
//               Text(
//                 value,
//                 style: theme.textTheme.bodyMedium,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class TimeSlotCard extends StatelessWidget {
//   final String timeSlot;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const TimeSlotCard({
//     super.key,
//     required this.timeSlot,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final startTime = timeSlot.split(' - ').first;

//     return Card(
//       elevation: 0,
//       color:
//           isSelected
//               ? theme.colorScheme.primary.withValues(alpha: 0.1)
//               : theme.colorScheme.surface,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//         side: BorderSide(
//           color:
//               isSelected
//                   ? theme.colorScheme.primary
//                   : theme.colorScheme.outline.withValues(alpha: 0.3),
//           width: isSelected ? 2 : 1,
//         ),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.access_time,
//                 size: 16,
//                 color:
//                     isSelected
//                         ? theme.colorScheme.primary
//                         : theme.colorScheme.onSurface.withValues(alpha: 0.7),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 startTime,
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   color:
//                       isSelected
//                           ? theme.colorScheme.primary
//                           : theme.colorScheme.onSurface,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/booking_model.dart';
import 'package:scheduly/pages/reschedule_page/widgets/time_slot_section_grid.dart'; 

// Import the new modular widgets
import 'widgets/current_booking_info_card.dart';
import 'widgets/date_picker_field.dart';
// DetailItem and TimeSlotCard are used by the above, so direct import not needed here if they are in widgets/

/// A page for rescheduling an existing booking.
///
/// Allows the user to select a new date and time slot for their appointment.
class ReschedulePage extends StatefulWidget {
  final Booking booking;

  const ReschedulePage({super.key, required this.booking});

  @override
  State<ReschedulePage> createState() => _ReschedulePageState();
}

class _ReschedulePageState extends State<ReschedulePage> {
  late DateTime _selectedDate;
  String? _selectedTimeSlot;

  // DateFormat for consistent display
  final DateFormat _displayDateFormat = DateFormat('EEEE, MMMM d, yyyy');

  // Simulated time slot data - In a real app, this would come from a backend.
  // Kept here for simplicity of the example.
  final Map<String, List<String>> _availableTimeSlots = {};

  @override
  void initState() {
    super.initState();
    // Initialize selectedDate to a day after the current booking, or tomorrow if current booking is past.
    // This avoids defaulting to a past date for selection.
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    _selectedDate = widget.booking.date.isAfter(now)
        ? widget.booking.date.add(const Duration(days:1)) // Suggest next day from current booking
        : tomorrow; // Default to tomorrow if current booking is past or today

    _generateInitialTimeSlots();
  }

  /// Simulates generation of available time slots.
  void _generateInitialTimeSlots() {
    // Pre-populate for a few key dates (today, tomorrow, day after)
    _availableTimeSlots[_formatDateKey(DateTime.now())] = [
      '09:00 AM - 10:00 AM', '10:30 AM - 11:30 AM', '01:00 PM - 02:00 PM',
      '03:30 PM - 04:30 PM', '05:00 PM - 06:00 PM',
    ];
    _availableTimeSlots[_formatDateKey(DateTime.now().add(const Duration(days: 1)))] = [
      '09:00 AM - 10:00 AM', '11:30 AM - 12:30 PM', '02:00 PM - 03:00 PM',
      '04:30 PM - 05:30 PM',
    ];
    _availableTimeSlots[_formatDateKey(DateTime.now().add(const Duration(days: 2)))] = [
      '10:00 AM - 11:00 AM', '12:30 PM - 01:30 PM', '03:00 PM - 04:00 PM',
      '05:30 PM - 06:30 PM',
    ];

    // Generate more for the next week dynamically (example)
    final now = DateTime.now();
    for (int i = 3; i < 10; i++) { // Generate for a week ahead
      final date = now.add(Duration(days: i));
      final key = _formatDateKey(date);
      if (_availableTimeSlots.containsKey(key)) continue; // Skip if already defined

      final List<String> slots = [];
      final baseSlots = [
        '09:15 AM - 10:15 AM', '10:45 AM - 11:45 AM', '01:15 PM - 02:15 PM',
        '02:45 PM - 03:45 PM', '04:15 PM - 05:15 PM', '05:45 PM - 06:45 PM',
      ];
      baseSlots.shuffle(); // Randomize
      final count = 2 + (date.day % 4); // Generate 2-5 slots
      slots.addAll(baseSlots.take(count));
      slots.sort(); // Ensure chronological order
      _availableTimeSlots[key] = slots;
    }
  }

  String _formatDateKey(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  List<String> _getTimeSlotsForDate(DateTime date) {
    // In a real app, fetch from backend or a service based on business logic (opening hours, staff availability etc.)
    final key = _formatDateKey(date);
    return _availableTimeSlots[key] ?? []; // Return empty list if no slots defined
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(), // User cannot select a past date
      lastDate: DateTime.now().add(const Duration(days: 60)), // Allow booking up to 60 days in advance
      // Theming for DatePicker (optional, can inherit from app theme)
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith( // More robust theme copy
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ), dialogTheme: DialogThemeData(backgroundColor: Theme.of(context).dialogBackgroundColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTimeSlot = null; // Reset time slot selection when date changes
        // Potentially fetch new time slots if they are date-dependent and from a backend
      });
    }
  }

  void _handleTimeSlotSelected(String timeSlot) {
    setState(() {
      _selectedTimeSlot = timeSlot;
    });
  }

  void _confirmReschedule() {
    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a new time slot.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    final newStartTime = _selectedTimeSlot?.split(' - ').first;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Reschedule'),
        content: Text(
          'Reschedule "${widget.booking.serviceName}" to:\n${_displayDateFormat.format(_selectedDate)} at $newStartTime?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext); // Close confirmation dialog
              _processReschedule();
            },
            child: const Text('CONFIRM'),
          ),
        ],
      ),
    );
  }

  void _processReschedule() {
    // --- Actual Reschedule Logic Would Go Here ---
    // This typically involves:
    // 1. Making an API call to your backend to update the booking.
    // 2. Handling success or failure of the API call.
    // 3. Updating local state or re-fetching data if necessary.
    print('Rescheduling booking ID: ${widget.booking.id}');
    print('New Date: $_selectedDate, New Time Slot: $_selectedTimeSlot');
    // --- End of Actual Reschedule Logic ---

    _showRescheduleSuccessDialog();
  }

  void _showRescheduleSuccessDialog() {
    final newStartTime = _selectedTimeSlot?.split(' - ').first;
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap the button
      builder: (dialogContext) => AlertDialog(
        title: const Text('Rescheduled Successfully!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.green.shade600,
              size: 72,
            ),
            const SizedBox(height: 20),
            Text(
              'Your appointment for "${widget.booking.serviceName}" is now on:',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${_displayDateFormat.format(_selectedDate)}\nat $newStartTime',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size(100, 40) // Ensure button is reasonably sized
            ),
            onPressed: () {
              Navigator.pop(dialogContext); // Close success dialog
              // Pop ReschedulePage, potentially returning a value to indicate success
              Navigator.pop(context, true); // true indicates success
            },
            child: const Text('DONE'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeSlotsForSelectedDate = _getTimeSlotsForDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reschedule Appointment'),
        centerTitle: true,
        elevation: 1, // Subtle elevation for app bar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurrentBookingInfoCard(
            booking: widget.booking,
            dateFormat: _displayDateFormat,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              children: [
                const Expanded(child: Divider(height: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Choose New Slot',
                    style: theme.textTheme.labelLarge?.copyWith( // Using labelLarge
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
                const Expanded(child: Divider(height: 1)),
              ],
            ),
          ),

          DatePickerField(
            selectedDate: _selectedDate,
            dateFormat: _displayDateFormat,
            onTap: () => _selectDate(context),
          ),

          const SizedBox(height: 20.0), // Increased spacing

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Available Time Slots on ${_displayDateFormat.format(_selectedDate)}:',
              style: theme.textTheme.titleSmall?.copyWith( // Using titleSmall
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8.0),

          Expanded(
            child: TimeSlotSelectionGrid(
              timeSlots: timeSlotsForSelectedDate,
              selectedTimeSlot: _selectedTimeSlot,
              onTimeSlotSelected: _handleTimeSlotSelected,
              onSelectAnotherDate: () => _selectDate(context),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52, // Slightly taller button
                child: FilledButton.icon(
                  icon:  Icon(Icons.calendar_month),
                  label: const Text('Confirm New Appointment'),
                  onPressed: _selectedTimeSlot != null ? _confirmReschedule : null,
                  style: FilledButton.styleFrom(
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary, // Ensure text color contrasts
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}