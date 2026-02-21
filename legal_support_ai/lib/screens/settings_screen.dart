import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'signin_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _biometric = false;
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Settings',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  child: const Text(
                    'JD',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'John Doe',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'john.doe@lawfirm.com',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pro Plan',
                        style: TextStyle(color: AppColors.primaryLight, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.edit_outlined, color: AppColors.textSecondary),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Preferences'),
          const SizedBox(height: 10),
          _buildToggleTile(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            value: _notifications,
            onChanged: (val) => setState(() => _notifications = val),
          ),
          _buildToggleTile(
            icon: Icons.fingerprint,
            title: 'Biometric Login',
            value: _biometric,
            onChanged: (val) => setState(() => _biometric = val),
          ),
          _buildToggleTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            value: _darkMode,
            onChanged: (val) => setState(() => _darkMode = val),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Security & Privacy'),
          const SizedBox(height: 10),
          _buildNavTile(icon: Icons.lock_outline, title: 'Change Password'),
          _buildNavTile(icon: Icons.security, title: 'Two-Factor Authentication'),
          _buildNavTile(icon: Icons.privacy_tip_outlined, title: 'Privacy Policy'),
          const SizedBox(height: 24),
          _buildSectionHeader('Support'),
          const SizedBox(height: 10),
          _buildNavTile(icon: Icons.help_outline, title: 'Help & FAQ'),
          _buildNavTile(icon: Icons.chat_outlined, title: 'Contact Support'),
          _buildNavTile(icon: Icons.star_outline, title: 'Rate the App'),
          const SizedBox(height: 24),
          _buildSectionHeader('Account'),
          const SizedBox(height: 10),
          _buildNavTile(icon: Icons.info_outline, title: 'About LegalSupportAI'),
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent, size: 22),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                  (route) => false,
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Column(
              children: [
                Text(
                  'LegalSupportAI v1.0.0',
                  style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  'AES-256 Encrypted · ISO 27001 Certified',
                  style: TextStyle(color: AppColors.textTertiary, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary, size: 22),
        title: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
          activeTrackColor: AppColors.primary.withOpacity(0.3),
          inactiveThumbColor: AppColors.textTertiary,
          inactiveTrackColor: AppColors.surfaceVariant,
        ),
      ),
    );
  }

  Widget _buildNavTile({required IconData icon, required String title}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary, size: 22),
        title: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 20),
        onTap: () {},
      ),
    );
  }
}
