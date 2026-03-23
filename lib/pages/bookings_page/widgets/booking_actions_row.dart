import 'package:flutter/material.dart';

class BookingActionsRow extends StatelessWidget {
  final bool isUpcoming;
  final VoidCallback? onCancel;
  final VoidCallback? onView;

  final VoidCallback? onReschedule;
  final VoidCallback? onRebook;

  const BookingActionsRow({
    super.key,
    required this.isUpcoming,
    this.onCancel,
    this.onReschedule,
    this.onRebook,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (onCancel == null && onReschedule == null && onRebook == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
      child: Wrap(
        alignment: WrapAlignment.end,
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          if (onRebook != null && !isUpcoming)
            TextButton.icon(
              icon: const Icon(Icons.replay_circle_filled_outlined, size: 20),
              label: const Text('Book Again'),
              onPressed: onRebook,
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          if (onView != null && isUpcoming)
            FilledButton(onPressed: (){
               onView?.call();
            }, child: Text("View")),
        ],
      ),
    );
  }
}
