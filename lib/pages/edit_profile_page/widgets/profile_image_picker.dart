import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final String currentImageUrl;
  final Function(String) onImageChanged;

  const ProfileImagePicker({
    super.key,
    required this.currentImageUrl,
    required this.onImageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            // Profile Image
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(currentImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Edit Icon Button
            InkWell(
              onTap: () => _showImagePickerOptions(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
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

  void _showImagePickerOptions(BuildContext context) {
    final theme = Theme.of(context);
    
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Profile Photo',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.photo_library, color: theme.colorScheme.primary),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    // In a real app, you would implement image picking functionality
                    // For now, we'll just use a sample image URL
                    onImageChanged('https://ui-avatars.com/api/?name=John+Doe&background=random');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt, color: theme.colorScheme.primary),
                  title: const Text('Take a Photo'),
                  onTap: () {
                    // In a real app, you would implement camera functionality
                    // For now, we'll just use a sample image URL
                    onImageChanged('https://ui-avatars.com/api/?name=Jane+Doe&background=random');
                    Navigator.pop(context);
                  },
                ),
                if (currentImageUrl.isNotEmpty)
                  ListTile(
                    leading: Icon(Icons.delete_outline, color: theme.colorScheme.error),
                    title: Text('Remove Photo', 
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                    onTap: () {
                      // Set to default avatar or placeholder
                      onImageChanged('https://ui-avatars.com/api/?name=User');
                      Navigator.pop(context);
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