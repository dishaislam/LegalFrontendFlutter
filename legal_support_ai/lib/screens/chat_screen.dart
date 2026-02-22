import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final List<String>? references;
  final String? status;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.references,
    this.status,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final ApiService _apiService = ApiService();

  String? _chatId;
  bool _isLoading = false;
  bool _isAITyping = false;

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    setState(() => _isLoading = true);
    final chatId = await _apiService.createChat();
    if (chatId != null) {
      if (mounted) {
        setState(() {
          _chatId = chatId;
          _isLoading = false;
          _messages.add(ChatMessage(
            text:
                "Hello! I am your **Bangladesh Legal Assistant**. How can I assist you with legal matters today?",
            isUser: false,
          ));
        });
      }
    } else {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Failed to initialize secure session. Please check your connection.',
              style: GoogleFonts.outfit(),
            ),
          ),
        );
      }
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _chatId == null || _isAITyping) return;

    final userMsg = ChatMessage(text: text, isUser: true, status: 'Sending...');
    setState(() {
      _messages.add(userMsg);
      _isAITyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    final answer = await _apiService.sendMessage(_chatId!, text);

    if (mounted) {
      setState(() {
        _isAITyping = false;
        // Update last message status
        final msgIndex = _messages.indexOf(userMsg);
        if (msgIndex != -1) {
          _messages[msgIndex] = ChatMessage(
            text: text,
            isUser: true,
            status: 'Delivered',
            timestamp: userMsg.timestamp,
          );
        }

        if (answer != null) {
          _messages.add(ChatMessage(text: answer, isUser: false));
        } else {
          _messages.add(ChatMessage(
              text:
                  "I apologies, but I encountered an error processing your request. Please try again.",
              isUser: false));
        }
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.background.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildSecurityBadge(),
            Expanded(
              child: _chatId == null && _isLoading
                  ? _buildInitialLoading()
                  : _buildMessageList(),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      leadingWidth: 54,
      leading: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Center(
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child:
                const Icon(Icons.gavel_rounded, color: Colors.white, size: 20),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LegalSupportAI',
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.greenOnline,
                  shape: BoxShape.circle,
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scale(
                      duration: 1000.ms,
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.2, 1.2))
                  .then()
                  .scale(
                      duration: 1000.ms,
                      begin: const Offset(1.2, 1.2),
                      end: const Offset(0.8, 0.8)),
              const SizedBox(width: 6),
              Text(
                'ENCRYPTED SESSION',
                style: GoogleFonts.outfit(
                  color: AppColors.greenOnline,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.history_rounded,
              color: AppColors.textSecondary, size: 22),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSecurityBadge() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_outline_rounded,
              color: AppColors.textTertiary, size: 12),
          const SizedBox(width: 6),
          Text(
            'AES-256 BANK-GRADE ENCRYPTION',
            style: GoogleFonts.outfit(
              color: AppColors.textTertiary,
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildInitialLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            strokeWidth: 3,
          ),
          const SizedBox(height: 20),
          Text(
            'Establishing Secure Connection...',
            style: GoogleFonts.outfit(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _messages.length + (_isAITyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length) {
          return _buildTypingIndicator();
        }
        final message = _messages[index];
        return message.isUser
            ? _buildUserBubble(message)
            : _buildAIBubble(message);
      },
    );
  }

  Widget _buildUserBubble(ChatMessage message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF4A68E1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.status ?? '',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0),
    );
  }

  Widget _buildAIBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.divider.withOpacity(0.1)),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: AppColors.primaryLight, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(22),
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                    border:
                        Border.all(color: AppColors.divider.withOpacity(0.1)),
                  ),
                  child: MarkdownBody(
                    data: message.text,
                    styleSheet: MarkdownStyleSheet(
                      p: GoogleFonts.outfit(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        height: 1.6,
                      ),
                      strong: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                      listBullet:
                          GoogleFonts.outfit(color: AppColors.primaryLight),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildActionRow(),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        _buildSmallAction(Icons.copy_rounded, 'Copy'),
        const SizedBox(width: 16),
        _buildSmallAction(Icons.thumb_up_alt_outlined, 'Helpful'),
        const SizedBox(width: 16),
        _buildSmallAction(Icons.refresh_rounded, 'Regenerate'),
      ],
    );
  }

  Widget _buildSmallAction(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textTertiary),
          const SizedBox(width: 4),
          Text(
            label,
            style:
                GoogleFonts.outfit(color: AppColors.textTertiary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: AppColors.primaryLight, size: 18),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: List.generate(
                  3,
                  (i) => Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: const BoxDecoration(
                            color: AppColors.textTertiary,
                            shape: BoxShape.circle),
                      )
                          .animate(onPlay: (c) => c.repeat())
                          .scale(
                              duration: 600.ms,
                              delay: (i * 200).ms,
                              begin: const Offset(1, 1),
                              end: const Offset(1.5, 1.5))
                          .then()
                          .scale(duration: 600.ms)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildQuickChip('Draft Contract'),
                _buildQuickChip('Tenant Rights'),
                _buildQuickChip('Business Law'),
                _buildQuickChip('Legal Fees'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.divider.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded,
                      color: AppColors.textSecondary),
                  onPressed: () {},
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextField(
                      controller: _messageController,
                      style: GoogleFonts.outfit(
                          color: AppColors.textPrimary, fontSize: 15),
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Ask a legal question...',
                        hintStyle:
                            GoogleFonts.outfit(color: AppColors.textTertiary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6, right: 6),
                  child: GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _isAITyping
                            ? AppColors.textTertiary
                            : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_upward_rounded,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'LegalSupportAI can make mistakes. Check important info.',
            style:
                GoogleFonts.outfit(color: AppColors.textTertiary, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(text,
            style: GoogleFonts.outfit(
                fontSize: 12, color: AppColors.textSecondary)),
        backgroundColor: AppColors.surfaceVariant.withOpacity(0.4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.divider.withOpacity(0.1))),
        onPressed: () {
          _messageController.text = text;
        },
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
