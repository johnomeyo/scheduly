
import 'package:flutter/material.dart';
import 'package:scheduly/mainscreen.dart'; 
import 'package:scheduly/pages/auth/forgot_password_page.dart'; 
import 'package:scheduly/pages/auth/widgets/social_signin_btn.dart'; 
import 'widgets/auth_title_section.dart';
import 'widgets/auth_form_section.dart';
import 'widgets/or_divider.dart';
import 'widgets/auth_mode_toggle_row.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
      // Clear controllers when switching modes
      _emailController.clear();
      _passwordController.clear();
      _usernameController.clear();
      _formKey.currentState?.reset(); // Reset form validation state
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _submitForm() async {
    // Added async here because authentication is typically an async operation
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Simulate authentication process
        await Future.delayed(const Duration(seconds: 2)); // Use await

        // --- Replace with your actual authentication logic ---
        // If login: await AuthService().login(_emailController.text, _passwordController.text);
        // If signup: await AuthService().signup(_emailController.text, _passwordController.text, _usernameController.text);
        // Handle success and errors from your auth service

        // On success:
        if (!mounted) return; // Check if widget is still mounted before showing SnackBar/navigating

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isLogin ? 'Login successful!' : 'Signup successful!',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2), // Shorter duration
          ),
        );

        // Navigate after successful authentication
        // Using pushReplacement to prevent going back to auth page
        Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => const MainScreen()),
        );

      } catch (e) {
        // Handle authentication errors
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        // Ensure loading state is reset even if an error occurs
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  // Callback for Forgot Password navigation - keeps navigation logic higher up
  void _navigateToForgotPassword() {
     Navigator.push(
        context,
        MaterialPageRoute(
         builder: (context) => const ForgotPasswordPage(),
        ),
      );
  }


  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Theme can be accessed in individual widgets if needed

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Extracted Title and subtitle section
                  AuthTitleSection(isLogin: _isLogin),

                  const SizedBox(height: 32),

                  // Extracted Form section
                  AuthFormSection(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    usernameController: _usernameController,
                    isLogin: _isLogin,
                    isLoading: _isLoading,
                    isPasswordVisible: _isPasswordVisible,
                    onSubmit: _submitForm,
                    onPasswordVisibilityToggle: _togglePasswordVisibility,
                    onForgotPassword: _navigateToForgotPassword, // Pass callback
                  ),

                  const SizedBox(height: 24),

                  const OrDivider(),

                  const SizedBox(height: 24),

                  // Social sign-in buttons 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Google
                      SocialSignInButton(
                        onPressed: () {
                           if (!mounted) return;
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(
                               content: Text(
                                 'Google Sign-In would be implemented here',
                               ),
                             ),
                           );
                        },
                        backgroundColor: Colors.white,
                        textColor: Colors.black87,
                        iconWidget: Image.network(
                          'https://img.icons8.com/?size=100&id=17949&format=png&color=000000', // Consider caching this image or using an asset
                          height: 24,
                          width: 24,
                        ),
                        label: 'Google',
                      ),

                      // Apple
                      SocialSignInButton(
                        onPressed: () {
                           if (!mounted) return;
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Apple Sign-In would be implemented here',
                              ),
                            ),
                          );
                        },
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        iconWidget: const Icon(
                          Icons.apple,
                          color: Colors.white,
                          size: 24,
                        ),
                        label: 'Apple',
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Extracted Toggle between login and signup
                  AuthModeToggleRow(
                    isLogin: _isLogin,
                    onToggleMode: _toggleAuthMode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}