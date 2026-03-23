import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallBusinessButton extends StatelessWidget {
  final String? phoneNumber;
  final String label;
  final IconData iconData;
  final ButtonStyle? style;
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
        if (await canLaunchUrl(launchUri)) {
          await launchUrl(launchUri); 
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
    final bool isPhoneNumberAvailable = phoneNumber != null && phoneNumber!.isNotEmpty;

    return OutlinedButton.icon(
      style: style ?? 
          OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            foregroundColor: isPhoneNumberAvailable
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
          ),
      onPressed: isPhoneNumberAvailable ? () => _launchPhoneCall(context) : null,
      icon: Icon(iconData),
      label: Text(label),
    );
  }
}