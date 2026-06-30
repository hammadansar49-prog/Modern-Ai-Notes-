import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import '../auth/auth_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _apiKeyController = TextEditingController();
  bool _hapticEnabled = true;
  bool _soundEnabled = true;

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

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isGridView = ref.watch(isGridViewProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // AI Settings Section
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('AI Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _apiKeyController,
                decoration: const InputDecoration(
                  labelText: 'Gemini API Key',
                  hintText: 'Enter your API key',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                // Open Google AI Studio
              },
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Get API Key from Google AI Studio'),
            ),
            const Divider(),

          // App Preferences
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('App Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            ListTile(
              title: const Text('Haptic Feedback'),
              trailing: Switch(
                value: _hapticEnabled,
                onChanged: (value) => setState(() => _hapticEnabled = value),
              ),
            ),
            ListTile(
              title: const Text('Sound Feedback'),
              trailing: Switch(
                value: _soundEnabled,
                onChanged: (value) => setState(() => _soundEnabled = value),
              ),
            ),
            ListTile(
              title: const Text('Default Grid View'),
              trailing: Switch(
                value: isGridView,
                onChanged: (value) => ref.read(isGridViewProvider.notifier).state = value,
              ),
            ),
            const Divider(),

          // Theme
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (value) => ref.read(themeModeProvider.notifier).setThemeMode(value!),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (value) => ref.read(themeModeProvider.notifier).setThemeMode(value!),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('System'),
              value: ThemeMode.system,
              groupValue: themeMode,
              onChanged: (value) => ref.read(themeModeProvider.notifier).setThemeMode(value!),
            ),
            const Divider(),

          // Save Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Save settings
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings saved')),
                  );
                },
                child: const Text('Save Settings'),
              ),
            ),

          // Logout
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutConfirmation(context, ref),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}