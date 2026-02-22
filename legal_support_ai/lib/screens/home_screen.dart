import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';
import 'document_analysis_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.8, -0.8),
            radius: 1.5,
            colors: [
              AppColors.primary.withOpacity(0.05),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 28),
                _buildMainBanner(context),
                const SizedBox(height: 32),
                _buildSectionHeader('Quick Actions'),
                const SizedBox(height: 16),
                _buildQuickActionGrid(context),
                const SizedBox(height: 32),
                _buildSectionHeader('Practice Areas'),
                const SizedBox(height: 16),
                _buildPracticeAreaGrid(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: GoogleFonts.outfit(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  'LegalSupportAI',
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.verified_rounded,
                    color: AppColors.primaryLight, size: 20),
              ],
            ),
          ],
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'JD',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildMainBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ChatScreen())),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage(
                'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.75),
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt_rounded, color: Colors.amber, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    'PRO VERSION ACTIVE',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Instant Legal\nConsultation',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Get expert AI advice on Bangladesh law in seconds.',
              style: GoogleFonts.outfit(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Consult AI Now',
                    style: GoogleFonts.outfit(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded,
                      color: AppColors.primaryDark, size: 18),
                ],
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 800.ms, delay: 200.ms)
          .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'See all',
          style: GoogleFonts.outfit(
            color: AppColors.primaryLight,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms);
  }

  Widget _buildQuickActionGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            context,
            icon: Icons.document_scanner_rounded,
            label: 'Analyze',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const DocumentAnalysisScreen())),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildActionCard(
            context,
            icon: Icons.history_edu_rounded,
            label: 'Review',
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ChatScreen())),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildActionCard(
            context,
            icon: Icons.shield_rounded,
            label: 'Rights',
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ChatScreen())),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 500.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildActionCard(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryLight, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeAreaGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildAreaCard(Icons.balance_rounded, 'Civil Law', '24 Cases'),
        _buildAreaCard(Icons.apartment_rounded, 'Property', '18 Cases'),
        _buildAreaCard(Icons.family_restroom_rounded, 'Family', '12 Cases'),
        _buildAreaCard(Icons.business_center_rounded, 'Corporate', '9 Cases'),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 600.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildAreaCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryLight.withOpacity(0.8), size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
