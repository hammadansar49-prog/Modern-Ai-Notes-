import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'dart:async';
import '../../data/model/note.dart';
import '../../core/providers.dart';

import '../../core/utils/ai_helper.dart';

class NoteEditorScreen extends ConsumerStatefulWidget {
  final String? noteId;
  const NoteEditorScreen({super.key, this.noteId});

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _contentFocusNode = FocusNode();
  
  // Note Properties
  int _selectedColor = 0;
  NoteType _noteType = NoteType.text;
  List<String> _imageUrls = [];
  bool _hasReminder = false;
  int? _createdAt;
  
  // Formatting States (Visual Toggles)
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  bool _isStrikethrough = false;
  TextAlign _textAlign = TextAlign.left;
  
  bool _isLoadingAi = false;
  
  // Voice Recording States
  bool _isRecording = false;
  int _recordingSeconds = 0;
  int _lastRecordingDuration = 0;
  Timer? _recordingTimer;
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _audioPath;
  
  // Audio Playback States
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      _loadNote();
    }
  }

  void _loadNote() async {
    final note = await ref.read(noteRepositoryProvider).getNoteById(widget.noteId!);
    if (note != null && mounted) {
      setState(() {
        _titleController.text = note.title;
        _contentController.text = note.content;
        _selectedColor = note.color;
        _imageUrls = List.from(note.imageUrls);
        _noteType = note.noteType;
        _hasReminder = note.hasReminder;
        _createdAt = note.createdAt;
        _isBold = note.isBold;
        _isItalic = note.isItalic;
        _isUnderline = note.isUnderline;
        _isStrikethrough = note.isStrikethrough;
        _textAlign = _parseTextAlign(note.textAlign);
        _audioPath = note.audioPath;
        _lastRecordingDuration = note.audioDuration ?? 0;
      });
    }
  }

  TextAlign _parseTextAlign(String value) {
    switch (value) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'justify':
        return TextAlign.justify;
      default:
        return TextAlign.left;
    }
  }

  void _triggerHaptic() => HapticFeedback.lightImpact();

  void _toggleBold() {
    _contentFocusNode.requestFocus();
    setState(() => _isBold = !_isBold);
  }

  void _toggleItalic() {
    _contentFocusNode.requestFocus();
    setState(() => _isItalic = !_isItalic);
  }

  void _toggleUnderline() {
    _contentFocusNode.requestFocus();
    setState(() => _isUnderline = !_isUnderline);
  }

  void _toggleStrikethrough() {
    _contentFocusNode.requestFocus();
    setState(() => _isStrikethrough = !_isStrikethrough);
  }

  void _setAlignment(TextAlign alignment) {
    _contentFocusNode.requestFocus();
    setState(() => _textAlign = alignment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.auto_awesome),
            onSelected: (value) {
              if (value == 'summarize') _callAiAction('summarize');
              if (value == 'grammar') _callAiAction('grammar');
              if (value == 'translate') _showTranslateMenu();
              if (value == 'chat') context.push('/chat');
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'summarize', child: Text('✨ Summarize')),
              const PopupMenuItem(value: 'grammar', child: Text('🔍 Grammar')),
              const PopupMenuItem(value: 'translate', child: Text('🌐 Translate')),
              const PopupMenuItem(value: 'chat', child: Text('💬 Ask Grok')),
            ],
            onCanceled: () {},
          ),
          IconButton(
            icon: const Icon(Icons.label_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(_hasReminder ? Icons.notifications_active : Icons.add_alarm),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              if (_isLoadingAi)
                const LinearProgressIndicator(minHeight: 2)
              else
                const SizedBox(height: 2),
              
              // New Formatting Toolbar at the Top
              _buildFormattingToolbar(),
              
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextField(
                      controller: _titleController,
                      enabled: !_isLoadingAi,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 8),
                TextField(
                  controller: _contentController,
                  focusNode: _contentFocusNode,
                  maxLines: null,
                  enabled: !_isLoadingAi,
                  textAlign: _textAlign,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                    fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                    decoration: _isUnderline
                        ? TextDecoration.underline
                        : _isStrikethrough
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Start typing...',
                    border: InputBorder.none,
                  ),
                ),
                if (_audioPath != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _togglePlayback,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Voice Note',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                _lastRecordingDuration > 0 
                                    ? 'Duration: ${_lastRecordingDuration}s' 
                                    : 'Tap to play',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                          onPressed: () {
                            setState(() => _audioPath = null);
                            _audioPlayer.stop();
                            _isPlaying = false;
                          },
                        ),
                      ],
                    ),
                  ),
                // Image Gallery moved below content
                if (_imageUrls.isNotEmpty) _buildImageGallery(),
                  ],
                ),
              ),
              // Bottom Toolbar for Media
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarTheme.color,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Row(
                  children: [
                    IconButton(icon: const Icon(Icons.add_box_outlined), onPressed: _pickImage),
                    IconButton(
                      icon: Icon(_isRecording ? Icons.mic : Icons.mic_none, color: _isRecording ? Colors.red : null),
                      onPressed: _isRecording ? _stopRecording : _startRecording,
                    ),
                    IconButton(icon: const Icon(Icons.palette_outlined), onPressed: _showColorPicker),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
          if (_isRecording) _buildRecordingOverlay(),
        ],
      ),
    );
  }

  Widget _buildFormattingToolbar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _ToolbarButton(
            icon: Icons.format_bold,
            isActive: _isBold,
            onTap: _toggleBold,
          ),
          _ToolbarButton(
            icon: Icons.format_italic,
            isActive: _isItalic,
            onTap: _toggleItalic,
          ),
          _ToolbarButton(
            icon: Icons.format_underline,
            isActive: _isUnderline,
            onTap: _toggleUnderline,
          ),
          _ToolbarButton(
            icon: Icons.strikethrough_s,
            isActive: _isStrikethrough,
            onTap: _toggleStrikethrough,
          ),
          const SizedBox(width: 8),
          _ToolbarButton(
            icon: Icons.format_align_left,
            isActive: _textAlign == TextAlign.left,
            onTap: () => _setAlignment(TextAlign.left),
          ),
          _ToolbarButton(
            icon: Icons.format_align_center,
            isActive: _textAlign == TextAlign.center,
            onTap: () => _setAlignment(TextAlign.center),
          ),
          _ToolbarButton(
            icon: Icons.format_align_right,
            isActive: _textAlign == TextAlign.right,
            onTap: () => _setAlignment(TextAlign.right),
          ),
          const SizedBox(width: 8),
          _ToolbarButton(
            icon: Icons.format_list_bulleted,
            onTap: () {}, // Placeholder for list logic if needed later
          ),
          _ToolbarButton(
            icon: Icons.format_list_numbered,
            onTap: () {}, // Placeholder
          ),
          _ToolbarButton(
            icon: Icons.title,
            onTap: () {}, // Placeholder
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = _imageUrls[index];
          final isNetworkImage = imageUrl.startsWith('http');

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => _viewImage(imageUrl),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: isNetworkImage
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 200,
                        width: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      )
                    : Image.file(
                        File(imageUrl),
                        height: 200,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _viewImage(String imageUrl) {
    final isNetworkImage = imageUrl.startsWith('http');
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: InteractiveViewer(
          child: isNetworkImage
              ? CachedNetworkImage(imageUrl: imageUrl)
              : Image.file(File(imageUrl)),
        ),
      ),
    );
  }

  void _startRecording() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      _triggerHaptic();
      
      // Get temp directory for audio file
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      
      try {
        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: filePath,
        );
        
        setState(() {
          _isRecording = true;
          _recordingSeconds = 0;
          _audioPath = filePath;
        });
        
        _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) {
            setState(() => _recordingSeconds++);
          } else {
            timer.cancel();
          }
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to start recording: $e')),
          );
        }
      }
    } else {
      _showPermissionDenied('Microphone');
    }
  }

  void _stopRecording() async {
    _triggerHaptic();
    _recordingTimer?.cancel();
    
    try {
      final path = await _audioRecorder.stop();
      if (mounted) {
        setState(() {
          _isRecording = false;
          _lastRecordingDuration = _recordingSeconds;
          _recordingSeconds = 0;
          _audioPath = path;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voice note saved!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to stop recording: $e')),
        );
      }
    }
  }

  void _togglePlayback() async {
    if (_audioPath == null) return;
    
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() => _isPlaying = false);
    } else {
      try {
        // Check if file exists
        if (await File(_audioPath!).exists()) {
          await _audioPlayer.play(DeviceFileSource(_audioPath!));
          setState(() => _isPlaying = true);
          
          // Listen for completion
          _audioPlayer.onPlayerComplete.listen((event) {
            if (mounted) setState(() => _isPlaying = false);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Audio file not found.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error playing audio: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _contentFocusNode.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pulsing Red Circle
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.8, end: 1.2),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
              onEnd: () {
                if (_isRecording && mounted) setState(() {});
              },
            ),
            const SizedBox(height: 20),
            // Timer
            Text(
              '00:${_recordingSeconds.toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // Stop Button
            GestureDetector(
              onTap: _stopRecording,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.stop, color: Colors.white, size: 30),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tap to stop recording',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final status = await Permission.camera.request();
                if (status.isGranted) {
                  final image = await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) _addImageToNote(image.path);
                } else {
                  _showPermissionDenied('Camera');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final status = await Permission.photos.request();
                if (status.isGranted) {
                  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (image != null) _addImageToNote(image.path);
                } else {
                  _showPermissionDenied('Gallery');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addImageToNote(String path) {
    setState(() {
      _imageUrls.add(path);
      _noteType = NoteType.image;
    });
  }

  void _showPermissionDenied(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature permission denied. Please enable it in Settings.')),
    );
  }

  void _showColorPicker() {
    final colors = [
      0xFFFFFFFF, 0xFFF28B82, 0xFFFBBC04, 0xFFFFF475, 
      0xFFCCFF90, 0xFFA7FFEB, 0xFFCBF0F8, 0xFFAFCBFA, 
      0xFFD7AEFB, 0xFFFDCFE8
    ];
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() => _selectedColor = colors[index]);
              Navigator.pop(context);
            },
            child: Container(
              width: 50,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(colors[index]),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _callAiAction(String action) async {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    _triggerHaptic();
    setState(() => _isLoadingAi = true);
    
    final aiHelper = ref.read(aiHelperProvider);
    String result = '';

    try {
      switch (action) {
        case 'summarize':
          result = await aiHelper.summarize(content);
          break;
        case 'grammar':
          result = await aiHelper.checkGrammar(content);
          break;
      }

      if (result.isNotEmpty && !result.startsWith('AI Error')) {
        if (action == 'grammar') {
          _contentController.text = result;
        } else {
          _contentController.text = '$content\n\n--- Summary ---\n$result';
        }
      } else if (result.startsWith('AI Error')) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
      }
    } finally {
      if (mounted) setState(() => _isLoadingAi = false);
    }
  }

  void _showTranslateMenu() {
    final languages = ['Spanish', 'French', 'German', 'Chinese', 'Japanese', 'Arabic'];
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(languages[index]),
          onTap: () async {
            Navigator.pop(context);
            final content = _contentController.text.trim();
            if (content.isEmpty) return;

            setState(() => _isLoadingAi = true);
            final result = await ref.read(aiHelperProvider).translate(content, languages[index]);
            
            if (mounted) {
              setState(() => _isLoadingAi = false);
              if (!result.startsWith('AI Error')) {
                _contentController.text = '$content\n\n--- ${languages[index]} ---\n$result';
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
              }
            }
          },
        ),
      ),
    );
  }

  void _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    
    if (title.isEmpty && content.isEmpty && _imageUrls.isEmpty) {
      context.pop();
      return;
    }

    setState(() => _isLoadingAi = true); // Use loading state for saving too
    
    try {
      final repository = ref.read(noteRepositoryProvider);
      final String noteId = widget.noteId ?? const Uuid().v4();
      
      // Upload local images to Firebase first
      List<String> finalImageUrls = [];
      for (String path in _imageUrls) {
        if (path.startsWith('http')) {
          finalImageUrls.add(path);
        } else {
          // It's a local file, upload it
          try {
            final downloadUrl = await repository.uploadImage(noteId, path);
            finalImageUrls.add(downloadUrl);
          } catch (e) {
            debugPrint('Image upload failed: $e');
            finalImageUrls.add(path); // Fallback to local path if upload fails
          }
        }
      }

      final note = Note(
        noteId: noteId,
        userId: '', // Set by repository
        title: title,
        content: content,
        imageUrls: finalImageUrls,
        color: _selectedColor,
        noteType: _noteType,
        createdAt: _createdAt ?? DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        isBold: _isBold,
        isItalic: _isItalic,
        isUnderline: _isUnderline,
        isStrikethrough: _isStrikethrough,
        textAlign: _textAlign.name,
        audioPath: _audioPath,
        hasAudio: _audioPath != null,
        audioDuration: _audioPath != null ? _lastRecordingDuration : null,
      );

      await repository.saveNote(note);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving note: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoadingAi = false);
    }
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  const _ToolbarButton({
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: Icon(icon, color: isActive ? Colors.blue : Colors.grey[700]),
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }
}

class _AiChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _AiChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ActionChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
