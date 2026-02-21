import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RecentDocument {
  final String name;
  final String time;
  final Color color;
  final IconData icon;
  final bool isPdf;

  const RecentDocument({
    required this.name,
    required this.time,
    required this.color,
    required this.icon,
    required this.isPdf,
  });
}

class DocumentAnalysisScreen extends StatefulWidget {
  const DocumentAnalysisScreen({super.key});

  @override
  State<DocumentAnalysisScreen> createState() => _DocumentAnalysisScreenState();
}

class _DocumentAnalysisScreenState extends State<DocumentAnalysisScreen> {
  bool _riskAssessment = true;
  bool _summarizeKeyPoints = true;
  bool _clauseExtraction = false;
  bool _isAnalyzing = false;
  String? _selectedFileName;

  final List<RecentDocument> _recentDocs = const [
    RecentDocument(
      name: 'Service_Agreeme...',
      time: '2 HOURS AGO',
      color: Color(0xFFC0392B),
      icon: Icons.picture_as_pdf,
      isPdf: true,
    ),
    RecentDocument(
      name: 'NDA_Template_v...',
      time: 'YESTERDAY',
      color: Color(0xFF2980B9),
      icon: Icons.description,
      isPdf: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Document Analysis',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload area
            GestureDetector(
              onTap: _pickDocument,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.divider,
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _selectedFileName != null ? Icons.check_circle_outline : Icons.upload_file,
                        color: _selectedFileName != null ? AppColors.primaryLight : AppColors.textSecondary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _selectedFileName ?? 'Upload Document',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: _selectedFileName != null ? 15 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'PDF, Word, or Images up to 25MB',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 13),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Browse Files',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            // Analysis Parameters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Analysis Parameters',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'AI CONFIG',
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildParameterToggle(
              icon: Icons.warning_amber_outlined,
              title: 'Risk Assessment',
              subtitle: 'Detect potential legal pitfalls',
              value: _riskAssessment,
              onChanged: (val) => setState(() => _riskAssessment = val),
            ),
            const SizedBox(height: 2),
            _buildParameterToggle(
              icon: Icons.menu_book_outlined,
              title: 'Summarize Key Points',
              subtitle: 'Extract executive summary',
              value: _summarizeKeyPoints,
              onChanged: (val) => setState(() => _summarizeKeyPoints = val),
            ),
            const SizedBox(height: 2),
            _buildParameterToggle(
              icon: Icons.view_list_outlined,
              title: 'Clause Extraction',
              subtitle: 'Identify specific legal clauses',
              value: _clauseExtraction,
              onChanged: (val) => setState(() => _clauseExtraction = val),
            ),
            const SizedBox(height: 28),
            // Recently Analyzed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recently Analyzed',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: _recentDocs.map((doc) {
                return Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: _buildRecentDocItem(doc),
                );
              }).toList(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        color: AppColors.background,
        child: ElevatedButton.icon(
          onPressed: _startAnalysis,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          icon: _isAnalyzing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : const Icon(Icons.bar_chart, color: Colors.white),
          label: Text(
            _isAnalyzing ? 'Analyzing...' : 'Start Analysis',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParameterToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withOpacity(0.3),
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.surfaceVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentDocItem(RecentDocument doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: doc.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(doc.icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 6),
        Text(
          doc.name,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          doc.time,
          style: const TextStyle(
            color: AppColors.textTertiary,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _pickDocument() {
    // Simulate file picking
    setState(() {
      _selectedFileName = 'contract_2024.pdf';
    });
  }

  void _startAnalysis() async {
    if (_isAnalyzing) return;
    setState(() => _isAnalyzing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isAnalyzing = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Analysis complete! Results ready.'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
