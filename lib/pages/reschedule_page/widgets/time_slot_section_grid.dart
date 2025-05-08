
import 'package:flutter/material.dart';
import 'package:scheduly/pages/reschedule_page/widgets/empty_slots.dart';
import './time_slot_card.dart';

/// Displays a grid of available time slots or an empty state message.
class TimeSlotSelectionGrid extends StatelessWidget {
  final List<String> timeSlots;
  final String? selectedTimeSlot;
  final Function(String) onTimeSlotSelected;
  final VoidCallback onSelectAnotherDate; // For the empty state

  const TimeSlotSelectionGrid({
    super.key,
    required this.timeSlots,
    this.selectedTimeSlot,
    required this.onTimeSlotSelected,
    required this.onSelectAnotherDate,
  });

  @override
  Widget build(BuildContext context) {
    if (timeSlots.isEmpty) {
      return EmptyTimeSlotsView(onSelectAnotherDate: onSelectAnotherDate);
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Consider making this responsive (e.g., 3 for wider screens)
        childAspectRatio: 3.0, // Adjust for desired card height
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final timeSlot = timeSlots[index];
        final bool isSelected = selectedTimeSlot == timeSlot;

        return TimeSlotCard(
          timeSlot: timeSlot,
          isSelected: isSelected,
          onTap: () => onTimeSlotSelected(timeSlot),
        );
      },
    );
  }
}