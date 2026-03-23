import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/booking_model.dart';
import 'package:scheduly/pages/booking_details_page/widgets/details_row.dart';
import 'package:scheduly/pages/booking_details_page/widgets/details_section.dart';
import 'package:scheduly/pages/booking_details_page/widgets/service_eader.dart';
import 'package:scheduly/pages/reschedule_page/widgets/time_slot_section_grid.dart';
import 'package:scheduly/utils.dart/utils.dart';
import 'widgets/date_picker_field.dart';

class ReschedulePage extends StatefulWidget {
  final Booking booking;

  const ReschedulePage({super.key, required this.booking});

  @override
  State<ReschedulePage> createState() => _ReschedulePageState();
}

class _ReschedulePageState extends State<ReschedulePage> {
  late DateTime _selectedDate;
  String? _selectedTimeSlot;

  final DateFormat _displayDateFormat = DateFormat('EEEE, MMMM d, yyyy');

  final Map<String, List<String>> _availableTimeSlots = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    _selectedDate =
        widget.booking.date.isAfter(now)
            ? widget.booking.date.add(
              const Duration(days: 1),
            ) // Suggest next day from current booking
            : tomorrow; // Default to tomorrow if current booking is past or today

    _generateInitialTimeSlots();
  }

  void _generateInitialTimeSlots() {
    // Pre-populate for a few key dates (today, tomorrow, day after)
    _availableTimeSlots[_formatDateKey(DateTime.now())] = [
      '09:00 AM - 10:00 AM',
      '10:30 AM - 11:30 AM',
      '01:00 PM - 02:00 PM',
      '03:30 PM - 04:30 PM',
      '05:00 PM - 06:00 PM',
    ];
    _availableTimeSlots[_formatDateKey(
      DateTime.now().add(const Duration(days: 1)),
    )] = [
      '09:00 AM - 10:00 AM',
      '11:30 AM - 12:30 PM',
      '02:00 PM - 03:00 PM',
      '04:30 PM - 05:30 PM',
    ];
    _availableTimeSlots[_formatDateKey(
      DateTime.now().add(const Duration(days: 2)),
    )] = [
      '10:00 AM - 11:00 AM',
      '12:30 PM - 01:30 PM',
      '03:00 PM - 04:00 PM',
      '05:30 PM - 06:30 PM',
    ];

    final now = DateTime.now();
    for (int i = 3; i < 10; i++) {
      // Generate for a week ahead
      final date = now.add(Duration(days: i));
      final key = _formatDateKey(date);
      if (_availableTimeSlots.containsKey(key)) {
        continue; // Skip if already defined
      }

      final List<String> slots = [];
      final baseSlots = [
        '09:15 AM - 10:15 AM',
        '10:45 AM - 11:45 AM',
        '01:15 PM - 02:15 PM',
        '02:45 PM - 03:45 PM',
        '04:15 PM - 05:15 PM',
        '05:45 PM - 06:45 PM',
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
    return _availableTimeSlots[key] ??
        []; // Return empty list if no slots defined
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(), // User cannot select a past date
      lastDate: DateTime.now().add(
        const Duration(days: 60),
      ), // Allow booking up to 60 days in advance
      // Theming for DatePicker (optional, can inherit from app theme)
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              // More robust theme copy
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
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
      Fluttertoast.showToast(
        msg: "Please select a new time slot",
        gravity: ToastGravity.TOP,
      );

      return;
    }

    final newStartTime = _selectedTimeSlot?.split(' - ').first;

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
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
                  Navigator.pop(dialogContext);
                  _processReschedule();
                },
                child: const Text('CONFIRM'),
              ),
            ],
          ),
    );
  }

  void _processReschedule() {
    _showRescheduleSuccessDialog();
  }

  void _showRescheduleSuccessDialog() {
    final newStartTime = _selectedTimeSlot?.split(' - ').first;
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap the button
      builder:
          (dialogContext) => AlertDialog(
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(100, 40)),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context, true);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ServiceHeader(
              serviceName: "haircut",
              title: "Reschedule",
              icon: getServiceIcon("haircut"),
              theme: theme,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DetailSection(
                title: "Current Appoinment Details",
                children: [
                  DetailRow(
                    icon: Icons.access_time,
                    label: 'Service',
                    value: widget.booking.serviceName,
                  ),
                  DetailRow(
                    icon: Icons.access_time,
                    label: 'Date',
                    value: "widget.booking.date",
                  ),
                  DetailRow(
                    icon: Icons.access_time,
                    label: 'Time',
                    value: widget.booking.timeSlot,
                  ),
                  DetailRow(
                    icon: Icons.access_time,
                    label: 'Business',
                    value: widget.booking.businessName,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: Row(
                children: [
                  const Expanded(child: Divider(height: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Choose New Slot',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(height: 1)),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            const SizedBox(height: 8.0),

            DatePickerField(
              selectedDate: _selectedDate,
              dateFormat: _displayDateFormat,
              onTap: () => _selectDate(context),
            ),

            const SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Available Time Slots on ${_displayDateFormat.format(_selectedDate)}:',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),

            SizedBox(
              height: 400,
              child: TimeSlotSelectionGrid(
                timeSlots: timeSlotsForSelectedDate,
                selectedTimeSlot: _selectedTimeSlot,
                onTimeSlotSelected: _handleTimeSlotSelected,
                onSelectAnotherDate: () => _selectDate(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  icon: Icon(Icons.calendar_month),
                  label: const Text('Confirm New Appointment'),
                  onPressed:
                      _selectedTimeSlot != null ? _confirmReschedule : null,
                  style: FilledButton.styleFrom(
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
