import 'package:flutter/material.dart';

class AuthModeToggleRow extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onToggleMode;

  const AuthModeToggleRow({
    super.key,
    required this.isLogin,
    required this.onToggleMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin
              ? 'Don\'t have an account?'
              : 'Already have an account?',
          style: TextStyle(
            // Corrected from withValues to withOpacity
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        TextButton(
          onPressed: onToggleMode, // Use callback
          child: Text(
            isLogin ? 'Sign Up' : 'Login',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}