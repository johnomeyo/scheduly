import 'package:flutter/material.dart';
import 'package:scheduly/constants/data.dart' show userData;
import 'package:scheduly/pages/auth/forgot_password_page.dart'
    show ForgotPasswordPage;
import 'package:scheduly/pages/edit_profile_page/edit_profile_page.dart';
import 'package:scheduly/pages/profile_page/nested_pages/privacy_settings_page.dart';
import 'package:scheduly/pages/profile_page/widgets/add_payment_method_bottom_sheet.dart';
import 'package:scheduly/pages/profile_page/widgets/profile_support_section.dart'
    show SupportSection;
import 'package:scheduly/pages/profile_page/widgets/logout_btn.dart';
import 'package:scheduly/pages/profile_page/widgets/payment_methods_section.dart';
import 'package:scheduly/pages/profile_page/widgets/profile_header.dart';
import 'package:scheduly/pages/profile_page/widgets/settings_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Settings state
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    // Initialize settings from user data
    _notificationsEnabled = userData['notificationsEnabled'] ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editProfile(),
            tooltip: 'Edit Profile',
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            ProfileHeaderWidget(
              imageUrl: userData['profileImage'],
              name: userData['name'],
              email: userData['email'],
              phone: userData['phone'],
              memberSince: userData['memberSince'],
            ),
            const SizedBox(height: 24),

            // Profile sections
            _buildSectionHeader(theme, 'Account Settings'),
            SettingsSectionWidget(
              notificationsEnabled: _notificationsEnabled,
              onNotificationsChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              onTapPrivacy: () => _navigateToPrivacySettings(),
              onTapChangePassword: () => _changePassword(),
            ),

            const SizedBox(height: 16),
            _buildSectionHeader(theme, 'Payment Methods'),
            PaymentMethodsSectionWidget(
              paymentMethods: userData['paymentMethods'],
              onAddPaymentMethod: () => _addPaymentMethod(),
              onShowPaymentOptions:
                  (paymentMethod) => _showPaymentMethodOptions(paymentMethod),
            ),

            const SizedBox(height: 16),

            _buildSectionHeader(theme, 'Support'),
            SupportSection(),
            const SizedBox(height: 24),
            // Logout button
            LogoutButtonWidget(onLogout: () => _logout(context)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  // Action methods
  void _editProfile() {
    // Navigate to edit profile page
    // Navigate to edit profile page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    ).then((_) {
      // Refresh the UI when returning from edit profile
      setState(() {});
    });
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // Cancel
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog

                  // Here you can also clear auth state or navigate to login

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logged out successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Log Out'),
              ),
            ],
          ),
    );
  }

  void _navigateToPrivacySettings() {
    // Navigate to privacy settings page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrivacySettingsPage()),
    );
  }

  void _changePassword() {
    // Show change password dialog or navigate to change password page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
    );
  }

  void _addPaymentMethod() {
    // Show bottom sheet to add payment method
    AddPaymentMethodBottomSheet.show(context, (newPaymentMethod) {
      setState(() {
        // If this is set as default, update existing payment methods
        if (newPaymentMethod['isDefault'] == true) {
          for (var method in userData['paymentMethods']) {
            method['isDefault'] = false;
          }
        }

        // Add the new payment method
        userData['paymentMethods'].add(newPaymentMethod);
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment method added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  void _showPaymentMethodOptions(Map<String, dynamic> paymentMethod) {
    // Show bottom sheet with payment method options
  }
}
