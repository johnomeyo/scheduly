import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A reusable OutlinedButton that initiates a phone call.
class CallBusinessButton extends StatelessWidget {
  /// The phone number to be dialed.
  final String? phoneNumber;

  /// The text label to display on the button.
  /// Defaults to 'Contact'.
  final String label;

  /// The icon to display on the button.
  /// Defaults to `Icons.phone`.
  final IconData iconData;

  /// Optional custom styling for the OutlinedButton.
  final ButtonStyle? style;

  /// Creates a button that, when pressed, attempts to call the [phoneNumber].
  ///
  /// The [phoneNumber] should be a string that can be parsed into a `tel:` URI.
  /// If [phoneNumber] is null or empty, the button will be disabled.
  const CallBusinessButton({
    super.key,
    required this.phoneNumber,
    this.label = 'Contact',
    this.iconData = Icons.phone,
    this.style,
  });

  Future<void> _launchPhoneCall(BuildContext context) async {
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );

      try {
        // It's good practice to check if the URL can be launched.
        // For 'tel:' on iOS, ensure LSApplicationQueriesSchemes includes 'tel'.
        if (await canLaunchUrl(launchUri)) {
          await launchUrl(launchUri); // Launch the phone dialer
        } else {
          debugPrint('Could not launch $launchUri');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not make a call to $phoneNumber')),
            );
          }
        }
      } catch (e) {
        debugPrint('Error launching URL: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred while trying to call: ${e.toString()}')),
          );
        }
      }
    } else {
      debugPrint('Contact number is not available.');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contact number is not available.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the button should be enabled
    final bool isPhoneNumberAvailable = phoneNumber != null && phoneNumber!.isNotEmpty;

    return OutlinedButton.icon(
      style: style ?? 
          OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // You can add more default styles here if needed:
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            foregroundColor: isPhoneNumberAvailable
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
          ),
      // Disable the button if no valid phone number is provided
      onPressed: isPhoneNumberAvailable ? () => _launchPhoneCall(context) : null,
      icon: Icon(iconData),
      label: Text(label),
    );
  }
}