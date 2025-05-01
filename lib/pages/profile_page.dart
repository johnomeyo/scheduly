import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Sarah Johnson',
    'email': 'sarah.johnson@example.com',
    'phone': '+1 (555) 123-4567',
    'profileImage': 'https://example.com/profile.jpg',
    'memberSince': 'May 2023',
    'notificationsEnabled': true,
    'darkModeEnabled': false,
    'address': '123 Main Street, Apt 4B, New York, NY 10001',
    'paymentMethods': [
      {
        'type': 'Credit Card',
        'cardType': 'Visa',
        'lastFour': '4242',
        'isDefault': true,
        'expiryDate': '05/26',
      },
      {
        'type': 'Credit Card',
        'cardType': 'Mastercard',
        'lastFour': '8765',
        'isDefault': false,
        'expiryDate': '10/25',
      },
    ],
  };

  // Settings state
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    // Initialize settings from user data
    _notificationsEnabled = _userData['notificationsEnabled'] ?? true;
    _darkModeEnabled = _userData['darkModeEnabled'] ?? false;
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
            _buildProfileHeader(theme),
            
            const SizedBox(height: 24),
            
            // Profile sections
            _buildSectionHeader(theme, 'Account Settings'),
            _buildSettingsSection(theme),
            
            const SizedBox(height: 16),
            
            _buildSectionHeader(theme, 'Payment Methods'),
            _buildPaymentMethodsSection(theme),
            
            const SizedBox(height: 16),
            
            _buildSectionHeader(theme, 'Address'),
            _buildAddressSection(theme),
            
            const SizedBox(height: 16),
            
            _buildSectionHeader(theme, 'Support'),
            _buildSupportSection(theme),
            
            const SizedBox(height: 24),
            
            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _logout(),
                  icon: Icon(
                    Icons.logout,
                    color: theme.colorScheme.error,
                  ),
                  label: Text(
                    'Log Out',
                    style: TextStyle(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.error),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary.withOpacity(0.1),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Center(
                child: Text(
                  _getInitials(_userData['name']),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // User name
          Text(
            _userData['name'],
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // User email
          Text(
            _userData['email'],
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          
          const SizedBox(height: 4),
          
          // User phone
          Text(
            _userData['phone'],
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Member since label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Member since ${_userData['memberSince']}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildSettingsSection(ThemeData theme) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            theme,
            title: 'Notifications',
            subtitle: 'Receive booking updates and reminders',
            icon: Icons.notifications_outlined,
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),
          _buildDivider(),
          _buildSettingsTile(
            theme,
            title: 'Dark Mode',
            subtitle: 'Switch between light and dark themes',
            icon: Icons.dark_mode_outlined,
            trailing: Switch(
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
          ),
          _buildDivider(),
          _buildSettingsTile(
            theme,
            title: 'Privacy Settings',
            subtitle: 'Manage your data and privacy preferences',
            icon: Icons.privacy_tip_outlined,
            onTap: () => _navigateToPrivacySettings(),
          ),
          _buildDivider(),
          _buildSettingsTile(
            theme,
            title: 'Change Password',
            subtitle: 'Update your account password',
            icon: Icons.lock_outline,
            onTap: () => _changePassword(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsSection(ThemeData theme) {
    final paymentMethods = _userData['paymentMethods'] as List;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < paymentMethods.length; i++) ...[
            _buildPaymentMethodTile(theme, paymentMethods[i]),
            if (i < paymentMethods.length - 1) _buildDivider(),
          ],
          _buildDivider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.add,
                color: theme.colorScheme.primary,
              ),
            ),
            title: Text(
              'Add Payment Method',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () => _addPaymentMethod(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(ThemeData theme) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Address',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _userData['address'],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _editAddress(),
                icon: Icon(
                  Icons.edit_location_alt_outlined,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                label: Text('Edit Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportSection(ThemeData theme) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            theme,
            title: 'Help Center',
            subtitle: 'Frequently asked questions and help guides',
            icon: Icons.help_outline,
            onTap: () => _navigateToHelpCenter(),
          ),
          _buildDivider(),
          _buildSettingsTile(
            theme,
            title: 'Contact Support',
            subtitle: 'Get in touch with our customer service team',
            icon: Icons.support_agent_outlined,
            onTap: () => _contactSupport(),
          ),
          _buildDivider(),
          _buildSettingsTile(
            theme,
            title: 'Terms of Service',
            subtitle: 'Read our terms and conditions',
            icon: Icons.description_outlined,
            onTap: () => _viewTermsOfService(),
          ),
          _buildDivider(),
          _buildSettingsTile(
            theme,
            title: 'Privacy Policy',
            subtitle: 'Learn how we handle your data',
            icon: Icons.policy_outlined,
            onTap: () => _viewPrivacyPolicy(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    ThemeData theme, {
    required String title,
    required String subtitle,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildPaymentMethodTile(ThemeData theme, Map<String, dynamic> paymentMethod) {
    final IconData cardIcon = paymentMethod['cardType'] == 'Visa' 
        ? Icons.credit_card 
        : Icons.credit_card;
    
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Icon(
          cardIcon,
          color: theme.colorScheme.primary,
          size: 20,
        ),
      ),
      title: Row(
        children: [
          Text(
            '${paymentMethod['cardType']} ••••${paymentMethod['lastFour']}',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          if (paymentMethod['isDefault'] == true)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Default',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      subtitle: Text(
        'Expires ${paymentMethod['expiryDate']}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => _showPaymentMethodOptions(paymentMethod),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
    );
  }

  // Action methods
  void _editProfile() {
    // Navigate to edit profile page
    print('Edit profile');
  }

  void _navigateToPrivacySettings() {
    // Navigate to privacy settings page
    print('Navigate to privacy settings');
  }

  void _changePassword() {
    // Show change password dialog or navigate to change password page
    print('Change password');
  }

  void _addPaymentMethod() {
    // Navigate to add payment method page
    print('Add payment method');
  }

  void _showPaymentMethodOptions(Map<String, dynamic> paymentMethod) {
    // Show bottom sheet with payment method options
    print('Show options for payment method: ${paymentMethod['cardType']} ••••${paymentMethod['lastFour']}');
  }

  void _editAddress() {
    // Navigate to edit address page
    print('Edit address');
  }

  void _navigateToHelpCenter() {
    // Navigate to help center page
    print('Navigate to help center');
  }

  void _contactSupport() {
    // Show contact support options
    print('Contact support');
  }

  void _viewTermsOfService() {
    // Show terms of service
    print('View terms of service');
  }

  void _viewPrivacyPolicy() {
    // Show privacy policy
    print('View privacy policy');
  }

  void _logout() {
    // Handle logout
    print('Logout');
  }

  // Helper methods
  String _getInitials(String name) {
    final nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    return 'U';
  }
}