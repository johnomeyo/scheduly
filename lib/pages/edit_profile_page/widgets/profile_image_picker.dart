import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const String _kDefaultAvatarUrl = 'https://png.pngtree.com/png-vector/20240910/ourmid/pngtree-business-women-avatar-png-image_13805764.png';

class ProfileImagePicker extends StatefulWidget {
  final String currentImageUrl; 
  final Function(String) onImageChanged;
  const ProfileImagePicker({
    super.key,
    required this.currentImageUrl,
    required this.onImageChanged,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _pickedImageFile; 

  final ImagePicker _picker = ImagePicker(); 
  Future<void> pickImage(ImageSource source, BuildContext context) async {
    Navigator.pop(context);

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, 
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _pickedImageFile = File(pickedFile.path);
        });
        widget.onImageChanged(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
        );
      }
    }
  }

  void _removePhoto(BuildContext context) {
    Navigator.pop(context);
    setState(() {
      _pickedImageFile = null; 
    });
    widget.onImageChanged(_kDefaultAvatarUrl);
  }
  ImageProvider _getImageProvider() {
    if (_pickedImageFile != null) {
      return FileImage(_pickedImageFile!);
    }
    if (widget.currentImageUrl.isNotEmpty) {
      if (Uri.tryParse(widget.currentImageUrl)?.isAbsolute ?? false) {
        return NetworkImage(widget.currentImageUrl);
      }
    }
    return const NetworkImage(_kDefaultAvatarUrl);
  }

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
                color: theme.colorScheme.surface, 
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withValues(alpha:0.15), 
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                  image: _getImageProvider(), 
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    debugPrint('Image load error: $exception');
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () => showImagePickerOptions(context),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [ 
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

  void showImagePickerOptions(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface, 
      shape: const RoundedRectangleBorder( 
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext modalContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), 
                  child: Text(
                    'Select Profile Photo',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Icon(Icons.photo_library_outlined, color: theme.colorScheme.primary),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    pickImage(ImageSource.gallery, modalContext);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined, color: theme.colorScheme.primary),
                  title: const Text('Take a Photo'),
                  onTap: () {
                    pickImage(ImageSource.camera, modalContext);
                  },
                ),
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