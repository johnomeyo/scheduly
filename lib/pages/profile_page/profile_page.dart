import 'package:flutter/material.dart';
import 'package:scheduly/constants/data.dart' show userData;
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
              imageUrl: userData['imageUrl'],
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
            LogoutButtonWidget(onLogout: () {}),
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
  }

  void _navigateToPrivacySettings() {
    // Navigate to privacy settings page
  }

  void _changePassword() {
    // Show change password dialog or navigate to change password page
  }

  void _addPaymentMethod() {
    // Navigate to add payment method page
  }

  void _showPaymentMethodOptions(Map<String, dynamic> paymentMethod) {
    // Show bottom sheet with payment method options
    print(
      'Show options for payment method: ${paymentMethod['cardType']} ••••${paymentMethod['lastFour']}',
    );
  }

}
