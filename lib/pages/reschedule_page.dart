import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduly/models/booking_model.dart';

class ReschedulePage extends StatefulWidget {
  final Booking booking;

  const ReschedulePage({super.key, required this.booking});

  @override
  State<ReschedulePage> createState() => _ReschedulePageState();
}

class _ReschedulePageState extends State<ReschedulePage> {
  late DateTime selectedDate;
  String? selectedTimeSlot;
  final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');

  // Simulate available time slots for the selected date
  final Map<String, List<String>> availableTimeSlots = {
    // Today and tomorrow have the same slots
    'today': [
      '09:00 AM - 10:00 AM',
      '10:30 AM - 11:30 AM',
      '01:00 PM - 02:00 PM',
      '03:30 PM - 04:30 PM',
      '05:00 PM - 06:00 PM',
    ],
    'tomorrow': [
      '09:00 AM - 10:00 AM',
      '11:30 AM - 12:30 PM',
      '02:00 PM - 03:00 PM',
      '04:30 PM - 05:30 PM',
    ],
    'dayAfter': [
      '10:00 AM - 11:00 AM',
      '12:30 PM - 01:30 PM',
      '03:00 PM - 04:00 PM',
      '05:30 PM - 06:30 PM',
    ],
  };

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _generateMoreTimeSlots(); // Populate more dates
  }

  void _generateMoreTimeSlots() {
    // Generate time slots for next 7 days
    final now = DateTime.now();
    for (int i = 3; i < 7; i++) {
      final date = now.add(Duration(days: i));
      final key = 'date_${date.year}_${date.month}_${date.day}';

      // Generate random slots
      final List<String> slots = [];
      final baseSlots = [
        '09:00 AM - 10:00 AM',
        '10:30 AM - 11:30 AM',
        '11:00 AM - 12:00 PM',
        '01:00 PM - 02:00 PM',
        '02:30 PM - 03:30 PM',
        '04:00 PM - 05:00 PM',
        '05:30 PM - 06:30 PM',
      ];

      // Randomly select 3-5 slots
      baseSlots.shuffle();
      final count = 3 + (date.day % 3); // 3-5 slots per day
      for (int j = 0; j < count; j++) {
        if (j < baseSlots.length) {
          slots.add(baseSlots[j]);
        }
      }

      // Sort the slots by time
      slots.sort();
      availableTimeSlots[key] = slots;
    }
  }

  List<String> _getTimeSlotsForDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dayAfter = today.add(const Duration(days: 2));

    final selectedDay = DateTime(date.year, date.month, date.day);

    if (selectedDay.isAtSameMomentAs(today)) {
      return availableTimeSlots['today'] ?? [];
    } else if (selectedDay.isAtSameMomentAs(tomorrow)) {
      return availableTimeSlots['tomorrow'] ?? [];
    } else if (selectedDay.isAtSameMomentAs(dayAfter)) {
      return availableTimeSlots['dayAfter'] ?? [];
    } else {
      final key = 'date_${date.year}_${date.month}_${date.day}';
      return availableTimeSlots[key] ?? [];
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedTimeSlot = null; // Reset selection when date changes
      });
    }
  }

  void _confirmReschedule() {
    if (selectedTimeSlot == null) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time slot'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Reschedule'),
            content: Text(
              'Are you sure you want to reschedule your ${widget.booking.serviceName} appointment to ${dateFormat.format(selectedDate)} at ${selectedTimeSlot?.split(' - ').first}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  // Implement reschedule logic here
                  Navigator.pop(context); // Close dialog
                  _showSuccess();
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
    );
  }

  void _showSuccess() {
    // Show success dialog and then return to previous screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Appointment Rescheduled'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your appointment has been successfully rescheduled to ${dateFormat.format(selectedDate)} at ${selectedTimeSlot?.split(' - ').first}.',
                ),
              ],
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Return to previous screen
                },
                child: const Text('Done'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeSlots = _getTimeSlotsForDate(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reschedule Appointment'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Original booking info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Appointment',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DetailItem(
                        label: 'Service',
                        value: widget.booking.serviceName,
                        icon: Icons.spa,
                      ),
                    ),
                    Expanded(
                      child: DetailItem(
                        label: 'Date',
                        value: dateFormat.format(widget.booking.date),
                        icon: Icons.calendar_today,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DetailItem(
                        label: 'Time',
                        value: widget.booking.timeSlot.split(' - ').first,
                        icon: Icons.access_time,
                      ),
                    ),
                    Expanded(
                      child: DetailItem(
                        label: 'Business',
                        value: widget.booking.businessName,
                        icon: Icons.business,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider with text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Select New Date & Time',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
          ),

          // Date picker
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () => _selectDate(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          Text(
                            dateFormat.format(selectedDate),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Time slots
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available Time Slots',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Time slot grid
          Expanded(
            child:
                timeSlots.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 48,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.4,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No available time slots for this date',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => _selectDate(context),
                            child: const Text('Select Another Date'),
                          ),
                        ],
                      ),
                    )
                    : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        final timeSlot = timeSlots[index];
                        final bool isSelected = selectedTimeSlot == timeSlot;

                        return TimeSlotCard(
                          timeSlot: timeSlot,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedTimeSlot = timeSlot;
                            });
                          },
                        );
                      },
                    ),
          ),

          // Bottom button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed:
                      selectedTimeSlot != null ? _confirmReschedule : null,
                  child: const Text('Confirm New Time'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const DetailItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeSlotCard extends StatelessWidget {
  final String timeSlot;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final startTime = timeSlot.split(' - ').first;

    return Card(
      elevation: 0,
      color:
          isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color:
              isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withValues(alpha: 0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color:
                    isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              Text(
                startTime,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color:
                      isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
