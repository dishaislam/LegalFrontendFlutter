import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'main_navigation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.8, -0.8),
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
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  padding: EdgeInsets.zero,
                ).animate().fadeIn(),
                const SizedBox(height: 20),
                Text(
                  'Join\nLegalSupportAI',
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),
                const SizedBox(height: 12),
                Text(
                  'Create an account to start managing your cases with award-winning AI intelligence.',
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 40),
                _buildInputLabel('Full Name'),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _nameController,
                  hint: 'John Doe',
                  prefixIcon: Icons.person_outline_rounded,
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 20),
                _buildInputLabel('Email Address'),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _emailController,
                  hint: 'name@email.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 20),
                _buildInputLabel('Password'),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Create a password',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: AppColors.textTertiary,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 20),
                _buildInputLabel('Confirm Password'),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _confirmPasswordController,
                  hint: 'Repeat password',
                  prefixIcon: Icons.lock_reset_rounded,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: AppColors.textTertiary,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreedToTerms,
                        onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        side: BorderSide(color: AppColors.divider.withOpacity(0.5)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'I agree to the ',
                          style: GoogleFonts.outfit(color: AppColors.textSecondary, fontSize: 13),
                          children: [
                            TextSpan(
                              text: 'Terms',
                              style: TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.w700),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 800.ms),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _agreedToTerms && !_isLoading ? _handleSignUp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading 
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : Text(
                      'Create Account',
                      style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 32),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.outfit(color: AppColors.textSecondary, fontSize: 15),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 1000.ms),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields', style: GoogleFonts.outfit()), backgroundColor: Colors.redAccent),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match', style: GoogleFonts.outfit()), backgroundColor: Colors.redAccent),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (mounted && credential.user != null) {
        await credential.user!.updateDisplayName(_nameController.text.trim());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigation()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Registration failed', style: GoogleFonts.outfit()), backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.outfit(
        color: AppColors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
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
          prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}

  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (mounted && credential.user != null) {
        // Here you would also update the user's display name if you wanted
        await credential.user!.updateDisplayName(_nameController.text.trim());
        
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigation()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Registration failed')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
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
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textTertiary),
          prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSocialButtonFull({required String label, required IconData icon}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 24),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
