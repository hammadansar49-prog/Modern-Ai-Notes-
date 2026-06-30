import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/model/tag.dart';

final tagsProvider = StreamProvider<List<Tag>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.getAllTags();
});

class ManageTagsScreen extends ConsumerWidget {
  const ManageTagsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagsProvider);
    final database = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Tags'),
      ),
      body: tagsAsync.when(
        data: (tags) {
          if (tags.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.label_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No tags yet', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: tags.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              final tag = tags[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(tag.color),
                    radius: 12,
                  ),
                  title: Text(tag.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _showTagDialog(context, database, tag: tag),
                        tooltip: 'Edit Tag',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Tag?'),
                              content: const Text('Notes will not be deleted but will be uncategorized.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                                TextButton(
                                  onPressed: () async {
                                    await database.deleteNoteTagsByTagId(tag.id);
                                    await database.deleteTag(tag.id);
                                    if (context.mounted) Navigator.pop(context);
                                  },
                                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                        tooltip: 'Delete Tag',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTagDialog(context, database),
        icon: const Icon(Icons.add),
        label: const Text('Add Tag'),
      ),
    );
  }

  void _showTagDialog(BuildContext context, dynamic database, {Tag? tag}) {
    final nameController = TextEditingController(text: tag?.name);
    int selectedColor = tag?.color ?? 0xFF1A73E8;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(tag == null ? 'New Tag' : 'Edit Tag'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Tag Name',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 24),
              const Text('Select Color:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  0xFF1A73E8, 0xFF34A853, 0xFFFBBC04, 0xFFEA4335, 0xFF9C27B0,
                  0xFF607D8B, 0xFF795548, 0xFFFF5722, 0xFF00BCD4, 0xFFE91E63,
                ].map((color) => GestureDetector(
                  onTap: () => setDialogState(() => selectedColor = color),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor == color ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: Color(color),
                      radius: 16,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isEmpty) return;
                
                final newTag = Tag(
                  id: tag?.id ?? 0,
                  name: nameController.text.trim(),
                  color: selectedColor,
                );

                if (tag == null) {
                  await database.insertTag(newTag);
                } else {
                  await database.updateTag(newTag);
                }
                
                if (context.mounted) Navigator.pop(context);
              },
              child: Text(tag == null ? 'Create' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
