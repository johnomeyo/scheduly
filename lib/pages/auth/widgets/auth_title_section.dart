import 'package:flutter/material.dart';

class AuthTitleSection extends StatelessWidget {
  final bool isLogin;

  const AuthTitleSection({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(
          Icons.lock_outline,
          size: 80,
          color: theme.primaryColor,
        ),
        const SizedBox(height: 16),
        Text(
          isLogin ? 'Welcome Back' : 'Create Account',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          isLogin
              ? 'Sign in to continue'
              : 'Sign up to get started',
          style: theme.textTheme.bodyLarge?.copyWith(
            // Corrected from withValues to withOpacity
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}