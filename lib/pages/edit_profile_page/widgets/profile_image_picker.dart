import 'dart:io'; // Required for File operations
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// A constant for a default avatar URL, useful for removing/resetting the photo
const String _kDefaultAvatarUrl = 'https://png.pngtree.com/png-vector/20240910/ourmid/pngtree-business-women-avatar-png-image_13805764.png';

class ProfileImagePicker extends StatefulWidget {
  final String currentImageUrl; // URL of the current network image
  final Function(String) onImageChanged; // Callback with the new image path or a command/URL string

  const ProfileImagePicker({
    super.key,
    required this.currentImageUrl,
    required this.onImageChanged,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _pickedImageFile; // Holds the locally picked image file

  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  // --- Helper Methods ---

  /// Picks an image from the specified [source] (gallery or camera).
  /// Updates the UI with the picked image and calls [onImageChanged] with the file path.
  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    // Close the bottom sheet first.
    // It's important to pop before potentially awaiting a long operation
    // or navigating away, to avoid context issues.
    Navigator.pop(context);

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Optional: Compress image to save space
        maxWidth: 800,    // Optional: Resize image
      );

      if (pickedFile != null) {
        setState(() {
          _pickedImageFile = File(pickedFile.path);
        });
        // Notify parent widget with the path of the new local file.
        // The parent widget is responsible for handling this path,
        // e.g., uploading it to a server and then updating `currentImageUrl`.
        widget.onImageChanged(pickedFile.path);
      }
    } catch (e) {
      // Handle potential errors (e.g., permissions denied).
      // A real app should show user-friendly feedback.
      debugPrint('Error picking image: $e');
      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
        );
      }
    }
  }

  /// Removes the currently picked local image or signals to use a default image.
  /// Calls [onImageChanged] with a default avatar URL.
  void _removePhoto(BuildContext context) {
     // Close the bottom sheet
    Navigator.pop(context);
    setState(() {
      _pickedImageFile = null; // Clear the local image override
    });
    // Notify parent to set a default avatar.
    // The parent should update `currentImageUrl` to this URL.
    widget.onImageChanged(_kDefaultAvatarUrl);
  }

  /// Determines the appropriate [ImageProvider] based on whether a local image
  /// has been picked or if a [currentImageUrl] is available.
  ImageProvider _getImageProvider() {
    // If a local image file has been picked, use FileImage
    if (_pickedImageFile != null) {
      return FileImage(_pickedImageFile!);
    }
    // Otherwise, try to use the currentImageUrl (presumably a network URL)
    if (widget.currentImageUrl.isNotEmpty) {
      // Basic check if it's an absolute URL.
      // NetworkImage will throw an error if the URL is not valid.
      if (Uri.tryParse(widget.currentImageUrl)?.isAbsolute ?? false) {
        return NetworkImage(widget.currentImageUrl);
      }
    }
    // Fallback to a default avatar if no local file and no valid currentImageUrl
    return const NetworkImage(_kDefaultAvatarUrl);
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            // Profile Image Container
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface, // Background for transparency or load errors
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withValues(alpha:0.15), // Standard way to set opacity
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                  image: _getImageProvider(), // Dynamically get the image provider
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // Optional: Handle image loading errors, e.g., for NetworkImage
                    debugPrint('Image load error: $exception');
                    // You might want to setState to a fallback error image if needed,
                    // though _getImageProvider already provides a default.
                  },
                ),
              ),
            ),
            // Edit Icon Button
            InkWell(
              onTap: () => _showImagePickerOptions(context),
              borderRadius: BorderRadius.circular(24), // For nice ripple effect
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [ // Subtle shadow for the button
                     BoxShadow(
                       color: theme.shadowColor.withValues(alpha:0.2),
                       blurRadius: 4,
                       offset: const Offset(0,1),
                     )
                  ]
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: theme.colorScheme.onPrimary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Change Photo",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Shows a modal bottom sheet with options to pick an image or remove the current one.
  void _showImagePickerOptions(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface, // Use theme color
      shape: const RoundedRectangleBorder( // Add some rounded corners
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext modalContext) { // Use a different context name for clarity
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Add padding for the title
                  child: Text(
                    'Select Profile Photo',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Reduced space
                ListTile(
                  leading: Icon(Icons.photo_library_outlined, color: theme.colorScheme.primary),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    // Pass modalContext to _pickImage if needed for ScaffoldMessenger,
                    // or rely on the main widget's context.
                    _pickImage(ImageSource.gallery, modalContext);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined, color: theme.colorScheme.primary),
                  title: const Text('Take a Photo'),
                  onTap: () {
                    _pickImage(ImageSource.camera, modalContext);
                  },
                ),
                // Show "Remove Photo" if a local image is picked,
                // or if the currentImageUrl is not the default placeholder.
                if (_pickedImageFile != null ||
                    (widget.currentImageUrl.isNotEmpty && widget.currentImageUrl != _kDefaultAvatarUrl))
                  ListTile(
                    leading: Icon(Icons.delete_outline, color: theme.colorScheme.error),
                    title: Text(
                      'Remove Photo',
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                    onTap: () {
                      _removePhoto(modalContext);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}