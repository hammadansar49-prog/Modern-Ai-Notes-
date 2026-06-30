import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/model/note.dart';
import '../../data/model/tag.dart';
import '../../core/providers.dart';
import '../auth/auth_provider.dart';

// Providers for filtering and UI state (Moved isGridViewProvider to core/providers.dart)
final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedTagIdProvider = StateProvider<int?>((ref) => null);

final notesStreamProvider = StreamProvider<List<Note>>((ref) {
  final database = ref.watch(databaseProvider);
  final selectedTagId = ref.watch(selectedTagIdProvider);
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) return Stream.value([]);
  if (selectedTagId != null) {
    return database.getNotesByTag(selectedTagId, userId);
  }
  return database.getAllNotes(userId);
});

final tagsStreamProvider = StreamProvider<List<Tag>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.getAllTags();
});

class NotesListScreen extends ConsumerStatefulWidget {
  const NotesListScreen({super.key});

  @override
  ConsumerState<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends ConsumerState<NotesListScreen> {
  final _searchController = TextEditingController();
  bool _isSelectionMode = false;
  final List<Note> _selectedNotes = [];
  bool _fabExpanded = false;

  void _triggerHaptic() {
    HapticFeedback.lightImpact();
  }

  void _toggleSelection(Note note) {
    _triggerHaptic();
    setState(() {
      if (_selectedNotes.any((n) => n.noteId == note.noteId)) {
        _selectedNotes.removeWhere((n) => n.noteId == note.noteId);
      } else {
        _selectedNotes.add(note);
      }
      _isSelectionMode = _selectedNotes.isNotEmpty;
    });
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout? Your data will be safely stored in Firebase.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showSwitchAccountBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Switch Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text('Use another account (Email)'),
              onTap: () async {
                Navigator.pop(context);
                // Just logout and go to login screen. User can sign in there.
                await ref.read(authProvider.notifier).logout();
                if (context.mounted) context.go('/login');
              },
            ),
            ListTile(
              leading: const Icon(Icons.g_mobiledata, color: Colors.red),
              title: const Text('Continue with Google'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  // Create a fresh instance with explicit scopes to ensure full auth flow
                  final googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
                  
                  // CRITICAL: Sign out to clear any cached tokens and FORCE the Account Picker window
                  await googleSignIn.signOut();
                  
                  // This call should now trigger the system account picker
                  final googleAccount = await googleSignIn.signIn();
                  
                  if (googleAccount != null) {
                    final googleAuth = await googleAccount.authentication;
                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    
                    // Logout old user and login new user
                    await ref.read(authProvider.notifier).logout();
                    ref.read(authProvider.notifier).loginWithGoogle(credential);
                  } else {
                    // User cancelled the picker
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account selection cancelled.')),
                      );
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Switch failed: $e')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notesAsync = ref.watch(notesStreamProvider);
    final tagsAsync = ref.watch(tagsStreamProvider);
    final isGridView = ref.watch(isGridViewProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedTagId = ref.watch(selectedTagIdProvider);
    final user = FirebaseAuth.instance.currentUser;
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: RefreshIndicator(
        onRefresh: () async {
          _triggerHaptic();
          try {
            await ref.read(noteRepositoryProvider).forceSyncFromFirestore();
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notes synced from Firebase'), duration: Duration(seconds: 2)),
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sync failed: $e'), backgroundColor: Colors.red),
              );
            }
          }
        },
        child: CustomScrollView(
        slivers: [
          _buildAppBar(user, isGridView),
          _buildSearchAndFilters(tagsAsync, selectedTagId, isGridView),
          ...notesAsync.when(
            data: (notes) {
              final filteredNotes = _filterNotes(notes, searchQuery, selectedTagId);
              if (filteredNotes.isEmpty) {
                return [
                  const SliverFillRemaining(
                    child: Center(child: Text('No notes found')),
                  )
                ];
              }

              final pinnedNotes = filteredNotes.where((n) => n.isPinned).toList();
              final otherNotes = filteredNotes.where((n) => !n.isPinned).toList();

              return [
                if (pinnedNotes.isNotEmpty) ...[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(child: _buildSectionHeader('SECURED THOUGHTS')),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: _buildNotesGridOrList(pinnedNotes, isGridView),
                  ),
                ],
                if (otherNotes.isNotEmpty) ...[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: _buildSectionHeader(pinnedNotes.isEmpty ? 'ALL CAPTURES' : 'OTHER CAPTURES'),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: _buildNotesGridOrList(otherNotes, isGridView),
                  ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 100)), // Bottom padding for FAB
              ];
            },
            loading: () => [
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            ],
            error: (err, stack) => [
              SliverFillRemaining(
                child: Center(child: Text('Error: $err')),
              )
            ],
          ),
        ],
      ),
      ),
      floatingActionButton: _buildFAB(),
      bottomNavigationBar: _isSelectionMode ? _buildSelectionBottomBar() : null,
      drawer: _buildDrawer(user, selectedTagId, themeMode),
    );
  }

  Widget _buildAppBar(User? user, bool isGridView) {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: _isSelectionMode 
          ? Text('${_selectedNotes.length} selected')
          : const Text('AI NOTES', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
      centerTitle: true,
      leading: _isSelectionMode
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() {
                _isSelectionMode = false;
                _selectedNotes.clear();
              }),
            )
          : null,
      actions: [
        if (!_isSelectionMode) ...[
          IconButton(
            icon: Icon(
              isGridView ? Icons.view_list : Icons.grid_view,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              _triggerHaptic();
              final newState = !ref.read(isGridViewProvider);
              ref.read(isGridViewProvider.notifier).state = newState;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(newState ? 'Grid View' : 'List View'),
                  duration: const Duration(milliseconds: 800),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null ? const Icon(Icons.person) : null,
            ),
          ),
        ] else ...[
          IconButton(
            icon: const Icon(Icons.select_all),
            onPressed: () {
              // Select all logic
            },
          ),
        ],
      ],
    );
  }

  Widget _buildSearchAndFilters(AsyncValue<List<Tag>> tagsAsync, int? selectedTagId, bool isGridView) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search your thoughts...',
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
                  ),
              ],
              elevation: WidgetStateProperty.all(2),
            ),
          ),
          SizedBox(
            height: 50,
            child: tagsAsync.when(
              data: (tags) => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: tags.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('All Notes'),
                        selected: selectedTagId == null,
                        onSelected: (_) => ref.read(selectedTagIdProvider.notifier).state = null,
                      ),
                    );
                  }
                  final tag = tags[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(tag.name),
                      selected: selectedTagId == tag.id,
                      avatar: CircleAvatar(backgroundColor: Color(tag.color), radius: 6),
                      onSelected: (_) => ref.read(selectedTagIdProvider.notifier).state = tag.id,
                    ),
                  );
                },
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12, letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildNotesGridOrList(List<Note> notes, bool isGridView) {
    if (isGridView) {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0, // Automatically adjusts columns based on width
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildNoteCard(notes[index]),
          childCount: notes.length,
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildNoteCard(notes[index], isList: true),
        ),
        childCount: notes.length,
      ),
    );
  }

  Widget _buildNoteCard(Note note, {bool isList = false}) {
    final isSelected = _selectedNotes.any((n) => n.noteId == note.noteId);
    return Card(
      key: ValueKey(note.noteId),
      elevation: isSelected ? 8 : 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (_isSelectionMode) {
            _toggleSelection(note);
          } else {
            context.push('/editor?noteId=${note.noteId}');
          }
        },
        onLongPress: () => _toggleSelection(note),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title.isEmpty ? 'Untitled' : note.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (note.isPinned) const Icon(Icons.push_pin, size: 16, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
                maxLines: isList ? 3 : 5,
                overflow: TextOverflow.ellipsis,
              ),
              if (note.hasReminder)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.alarm, size: 12, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text('Reminder', style: TextStyle(fontSize: 10, color: Colors.orange[800])),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_fabExpanded) ...[
          FloatingActionButton.extended(
            heroTag: 'gemini',
            onPressed: () {
              setState(() => _fabExpanded = false);
              context.push('/chat');
            },
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Ask Grok'),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            heroTag: 'new_note',
            onPressed: () {
              setState(() => _fabExpanded = false);
              context.push('/editor');
            },
            icon: const Icon(Icons.note_add),
            label: const Text('New Note'),
          ),
          const SizedBox(height: 16),
        ],
        FloatingActionButton(
          onPressed: () {
            _triggerHaptic();
            setState(() => _fabExpanded = !_fabExpanded);
          },
          child: Icon(_fabExpanded ? Icons.close : Icons.add),
        ),
      ],
    );
  }

  Widget _buildSelectionBottomBar() {
    final repository = ref.read(noteRepositoryProvider);
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.push_pin),
            onPressed: () async {
              for (final note in _selectedNotes) {
                await repository.saveNote(note.copyWith(isPinned: !note.isPinned));
              }
              setState(() {
                _isSelectionMode = false;
                _selectedNotes.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.archive),
            onPressed: () async {
              for (final note in _selectedNotes) {
                await repository.archiveNote(note);
              }
              setState(() {
                _isSelectionMode = false;
                _selectedNotes.clear();
              });
            },
          ),
          IconButton(icon: const Icon(Icons.label), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // 1. Instant UI Update: Clear selection immediately
              final notesToDelete = List.from(_selectedNotes);
              setState(() {
                _isSelectionMode = false;
                _selectedNotes.clear();
              });

              // 2. Fast Parallel Deletion: Delete all notes at once in background
              Future.wait(notesToDelete.map((note) => repository.deleteNote(note)))
                  .then((_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Notes moved to trash')),
                      );
                    }
                  })
                  .catchError((e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error deleting notes: $e')),
                      );
                    }
                  });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(User? user, int? selectedTagId, ThemeMode themeMode) {
    return Drawer(
      child: ListView(
        children: [
          // Custom Header with Switch Account
          Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                  child: user?.photoURL == null ? const Icon(Icons.person, size: 30, color: Colors.white) : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'Modern User',
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () => _showSwitchAccountBottomSheet(context, ref),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                user?.email ?? 'account@modernai.com',
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Central Hub'),
            selected: selectedTagId == null,
            onTap: () {
              ref.read(selectedTagIdProvider.notifier).state = null;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text('Archived Thoughts'),
            onTap: () => context.push('/archive'),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Trash Bin'),
            onTap: () => context.push('/trash'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('Label Manager'),
            onTap: () => context.push('/tags'),
          ),
          const Divider(),
          // Theme Toggle
          SwitchListTile(
            secondary: Icon(themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
            title: Text(themeMode == ThemeMode.dark ? 'Dark Mode' : 'Light Mode'),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showLogoutConfirmation(context, ref);
            },
          ),
        ],
      ),
    );
  }

  List<Note> _filterNotes(List<Note> notes, String query, int? tagId) {
    return notes.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
