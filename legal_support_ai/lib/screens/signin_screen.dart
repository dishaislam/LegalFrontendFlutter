import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'signup_screen.dart';
import 'main_navigation.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscurePassword = true;
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your credentials',
              style: GoogleFonts.outfit()),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (mounted && credential.user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigation()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Authentication failed',
                style: GoogleFonts.outfit()),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, -0.8),
            radius: 1.2,
            colors: [
              AppColors.primary.withOpacity(0.08),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border:
                          Border.all(color: AppColors.primary.withOpacity(0.2)),
                    ),
                    child: const Icon(
                      Icons.balance_rounded,
                      color: AppColors.primaryLight,
                      size: 40,
                    ),
                  ),
                ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'LegalSupportAI',
                    style: GoogleFonts.outfit(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 60),
                Text(
                  'Welcome Back',
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
                const SizedBox(height: 12),
                Text(
                  'Sign in to access your secure legal AI workplace and case history.',
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 48),
                _buildInputLabel('Email Address'),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _emailController,
                  hint: 'name@email.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 24),
                _buildInputLabel('Password'),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _passwordController,
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.outfit(
                      color: AppColors.primaryLight,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ).animate().fadeIn(delay: 700.ms),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5))
                        : Text(
                            'Sign In',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Expanded(
                        child:
                            Divider(color: AppColors.divider, thickness: 0.5)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Or continue with',
                        style: GoogleFonts.outfit(
                            color: AppColors.textTertiary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Expanded(
                        child:
                            Divider(color: AppColors.divider, thickness: 0.5)),
                  ],
                ).animate().fadeIn(delay: 900.ms),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                        child:
                            _buildSocialButton(Icons.g_mobiledata, 'Google')),
                    const SizedBox(width: 16),
                    Expanded(
                        child:
                            _buildSocialButton(Icons.apple_rounded, 'Apple')),
                  ],
                ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 40),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SignUpScreen())),
                    child: RichText(
                      text: TextSpan(
                        text: "New here? ",
                        style: GoogleFonts.outfit(
                            color: AppColors.textSecondary, fontSize: 15),
                        children: [
                          TextSpan(
                            text: 'Create Account',
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 1100.ms),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.outfit(
        color: AppColors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider.withOpacity(0.1)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: GoogleFonts.outfit(color: AppColors.textPrimary, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.outfit(color: AppColors.textTertiary),
          prefixIcon:
              Icon(prefixIcon, color: AppColors.textSecondary, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 24),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
