import 'package:flutter/material.dart';

// Main Contact Support Page Widget
class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  // Global key to uniquely identify the Form widget and allow validation.
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage the text input fields.
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  // State variable to track submission progress (optional, for disabling button)
  bool _isSubmitting = false;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // --- Form Submission Logic ---
  Future<void> _submitSupportRequest() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // Prevent multiple submissions
      if (_isSubmitting) return;

      setState(() {
        _isSubmitting = true; // Indicate loading state
      });

      // Simulate network request or backend call
      await Future.delayed(const Duration(seconds: 2)); // Simulate delay

      // Implement actual submission logic here ---
      // Example:
      // try {
      //   await ApiService.submitSupportTicket(
      //     subject: _subjectController.text,
      //     message: _messageController.text,
      //   );
      //
      //   // Show success message
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Support request submitted successfully!'),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      //   // Optionally navigate back or clear the form
      //   Navigator.pop(context);
      //
      // } catch (e) {
      //   // Show error message
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Failed to submit request: ${e.toString()}'),
      //       backgroundColor: Theme.of(context).colorScheme.error,
      //     ),
      //   );
      // } finally {
      //   setState(() {
      //     _isSubmitting = false; // Reset loading state
      //   });
      // }

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Support request submitted successfully! (Placeholder)'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating, // Make it float
          margin: const EdgeInsets.all(16), // Add margin
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Rounded corners
        ),
      );
      // Clear the form after successful submission (optional)
      _formKey.currentState!.reset();
      _subjectController.clear();
      _messageController.clear();
       setState(() {
         _isSubmitting = false; // Reset loading state
       });
      // Optionally navigate back
      // Navigator.pop(context);
      // --- End of Placeholder ---
    } else {
      // Form is invalid, show error indication (validation messages appear automatically)
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Support',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Use padding for the overall content area
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the key to the Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Make button stretch
            children: <Widget>[
              // Introductory Text (Optional)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Please describe your issue below. Our support team will get back to you as soon as possible.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Subject Field
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  hintText: 'e.g., Issue with booking confirmation',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // Add prefix icon for visual cue
                  prefixIcon: Icon(Icons.label_outline, color: theme.colorScheme.primary),
                ),
                // Basic validation: ensure the subject is not empty
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 16),

              // Message Field
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  hintText: 'Please provide details about the problem you are facing...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignLabelWithHint: true, // Better alignment for multiline
                  // Add prefix icon for visual cue
                  prefixIcon: Padding(
                     padding: const EdgeInsets.only(bottom: 80), // Adjust padding to align icon top
                     child: Icon(Icons.message_outlined, color: theme.colorScheme.primary),
                  ),
                ),
                maxLines: 5, // Allow multiple lines for the message
                // Basic validation: ensure the message is not empty
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your message';
                  }
                  if (value.trim().length < 10) {
                    return 'Please provide a bit more detail (min 10 characters)';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 32), // Space before the submit button

              // Submit Button
              ElevatedButton.icon(
                // Disable button while submitting
                onPressed: _isSubmitting ? null : _submitSupportRequest,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // Show loading indicator when submitting
                  disabledBackgroundColor: theme.colorScheme.primary.withValues(alpha: 0.5),
                ),
                icon: _isSubmitting
                    ? Container( // Show progress indicator
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(right: 8),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : const Icon(Icons.send_outlined), // Show send icon otherwise
                label: Text(
                  _isSubmitting ? 'Submitting...' : 'Send Message',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Optional: Link to other support methods as secondary options
              // Center(
              //   child: Text(
              //     'Alternatively, visit our Help Center or call us.',
              //     style: theme.textTheme.bodySmall?.copyWith(
              //       color: theme.colorScheme.onSurfaceVariant,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
