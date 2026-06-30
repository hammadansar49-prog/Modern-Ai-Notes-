# Flutter and Android basics
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase basics
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Prevent shrinking for common plugins
-keep class com.dexteriv.flutter_local_notifications.** { *; }
-keep class be.tramckas.workmanager.** { *; }
