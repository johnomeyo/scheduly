import 'package:flutter/material.dart';

class AuthFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final bool isLogin;
  final bool isLoading;
  final bool isPasswordVisible;
  final VoidCallback onSubmit;
  final VoidCallback onPasswordVisibilityToggle;
  final VoidCallback onForgotPassword; // Callback for navigation

  const AuthFormSection({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.usernameController,
    required this.isLogin,
    required this.isLoading,
    required this.isPasswordVisible,
    required this.onSubmit,
    required this.onPasswordVisibilityToggle,
    required this.onForgotPassword, // Pass callback
  });

  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
      child: Column(
        children: [
          // Username field (only in signup mode)
          if (!isLogin) ...[
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline),
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                } else if (value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],

          // Email field
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email address';
              } else if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password field
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: onPasswordVisibilityToggle, // Use callback
              ),
            ),
            obscureText: !isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              } else if (!isLogin && value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            textInputAction:
                isLogin
                    ? TextInputAction.done
                    : TextInputAction.next, // Adjust for next action
          ),

          // Forgot password (only in login mode)
          if (isLogin) ...[
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onForgotPassword, // Use callback
                child: const Text('Forgot Password?'),
              ),
            ),
          ],

          const SizedBox(height: 24),

          // Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              child:
                  isLoading
                      ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                        ),
                      )
                      : Text(
                        isLogin ? 'LOGIN' : 'SIGN UP',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
