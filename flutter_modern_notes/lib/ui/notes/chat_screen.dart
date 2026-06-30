import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/model/note.dart';
import '../../core/providers.dart';

import '../../core/utils/ai_helper.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final bool isThinking;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    this.isThinking = false,
  });
}

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isStreaming = false;

  void _triggerHaptic() => HapticFeedback.lightImpact();

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _triggerHaptic();
    setState(() {
      _messages.add(ChatMessage(id: const Uuid().v4(), text: text, isUser: true));
      _messageController.clear();
      _isStreaming = true;
      _messages.add(ChatMessage(id: 'thinking', text: 'Grok is thinking...', isUser: false, isThinking: true));
    });

    _scrollToBottom();
    
    final response = await ref.read(aiHelperProvider).askGemini(text);

    if (mounted) {
      setState(() {
        _messages.removeWhere((m) => m.id == 'thinking');
        _messages.add(ChatMessage(
          id: const Uuid().v4(), 
          text: response, 
          isUser: false
        ));
        _isStreaming = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _saveChat() async {
    if (_messages.isEmpty) return;

    _triggerHaptic();
    final repository = ref.read(noteRepositoryProvider);
    
    // Format chat content
    final chatContent = _messages
        .where((m) => !m.isThinking && m.text.isNotEmpty)
        .map((m) => '${m.isUser ? "You" : "Grok"}: ${m.text}')
        .join('\n\n');

    final note = Note(
      noteId: const Uuid().v4(),
      userId: '', // Will be set by repository
      title: 'Grok Chat - ${DateTime.now().toString().split(' ')[0]}',
      content: chatContent,
      color: 0, // Default/White background
      noteType: NoteType.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      await repository.saveNote(note);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chat saved to notes successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving chat: $e')),
        );
      }
    }
  }

  Future<void> _saveMessageToNote(String messageText) async {
    _triggerHaptic();
    final repository = ref.read(noteRepositoryProvider);
    
    final note = Note(
      noteId: const Uuid().v4(),
      userId: '',
      title: 'Grok Response',
      content: messageText,
      color: 0, // Default/White background
      noteType: NoteType.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      await repository.saveNote(note);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message saved to notes!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving message: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bubbleMaxWidth = screenWidth * 0.75 > 500 ? 500.0 : screenWidth * 0.75;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Ask Grok', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          if (_messages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.save_alt),
              onPressed: _saveChat,
            ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'Start a conversation with Grok AI',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) => _ChatBubble(
                      message: _messages[index],
                      maxWidth: bubbleMaxWidth,
                      onSave: _messages[index].isUser || _messages[index].isThinking 
                          ? null 
                          : () => _saveMessageToNote(_messages[index].text),
                    ),
                  ),
          ),
          SafeArea(
            top: false,
            child: _buildInputArea(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).padding.bottom + 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              maxLines: 4,
              minLines: 1,
              decoration: InputDecoration(
                hintText: 'Ask anything...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: _isStreaming ? null : _sendMessage,
            icon: _isStreaming 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final double maxWidth;
  final VoidCallback? onSave;
  const _ChatBubble({required this.message, required this.maxWidth, this.onSave});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontStyle: message.isThinking ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ),
                if (!isUser && !message.isThinking && onSave != null)
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, size: 18, color: isUser ? Colors.white : Colors.black54),
                    onSelected: (value) {
                      if (value == 'save') onSave?.call();
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'save',
                        child: Row(
                          children: [
                            Icon(Icons.note_add, size: 18),
                            SizedBox(width: 8),
                            Text('Add to Note'),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
