# 📝 Modern AI Notes

A modern, AI-powered note-taking app built with **Flutter**. Capture ideas as text, audio, sketches, or images — then let AI summarize, fix grammar, translate, and chat about your notes. Notes sync to the cloud, work offline, and stay protected behind biometric lock.

> The production app lives in the [`flutter_modern_notes/`](flutter_modern_notes) directory. An earlier native Android (Kotlin/Jetpack Compose) version is also kept in this repository for reference.

---

## ✨ Features

### 🤖 AI Powered (Groq · Llama 3.1)
- **Summarize** long notes into concise points
- **Grammar & spelling fix** with one tap
- **Translate** notes into any language
- **AI Chat** — ask questions and brainstorm with an in-app assistant

### 🗒️ Rich Note-Taking
- Multiple note types: **Text, Audio, Sketch, Image**
- Rich text formatting — **bold, italic, underline, strikethrough**, and text alignment
- Note colors and categories
- Attach images, record & play audio, draw sketches
- **Pin**, **Archive**, and **Trash** (with restore) support

### ⏰ Reminders & Notifications
- Set reminders with custom repeat schedules
- Local notifications powered by background tasks (WorkManager)

### 🏷️ Organization
- Custom **tags** and categories
- Manage, search, and filter notes quickly

### 👥 Real-Time Collaboration
- Shared notes with live **cursors**, **selections**, and **active sessions**
- Presence indicators (online / typing)

### 🔐 Security & Sync
- **Firebase Authentication** (Email/Password + Google Sign-In)
- **Biometric lock** (fingerprint / face)
- Cloud sync via **Cloud Firestore** + **Firebase Storage**
- **Offline-first** local database using Drift (SQLite)

### 🎨 Experience
- Beautiful **Light / Dark / System** themes
- Smooth haptic feedback
- Modern Material 3 design

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter (Dart, SDK ^3.3.0) |
| State Management | Riverpod |
| Navigation | go_router |
| Local Database | Drift + SQLite |
| Backend | Firebase (Auth, Firestore, Storage) |
| AI | Groq API (Llama 3.1) |
| Auth | Firebase Auth + Google Sign-In |
| Notifications | flutter_local_notifications + WorkManager |
| Security | local_auth (biometrics) |
| Media | image_picker, record, audioplayers |

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.3.0 or higher)
- A Firebase project (`google-services.json` for Android / `GoogleService-Info.plist` for iOS)
- A [Groq API key](https://console.groq.com/) for AI features

### Setup
```bash
# 1. Clone the repository
git clone https://github.com/hammadansar49-prog/Modern-Ai-Notes-.git
cd Modern-Ai-Notes-/flutter_modern_notes

# 2. Install dependencies
flutter pub get

# 3. Generate database / code files
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

> **Note:** Add your own Groq API key in `lib/core/utils/ai_helper.dart` and configure your Firebase project before running.

---

## 📂 Project Structure

```
flutter_modern_notes/
├── lib/
│   ├── core/           # Theme, providers, utils (AI, biometric, notifications, haptics)
│   ├── data/           # Models, local DB (Drift), repositories
│   ├── ui/             # Auth, notes, splash screens & widgets
│   ├── app.dart        # Routing & app shell
│   └── main.dart       # Entry point
├── android/ · ios/     # Platform projects
└── pubspec.yaml        # Dependencies
```

---

## 📬 Contact

For any questions, feedback, or collaboration:

- **📧 Email:** [hammadansar49@gmail.com](mailto:hammadansar49@gmail.com)
- **💬 WhatsApp:** [+92 334 1100761](https://wa.me/923341100761) — [Chat on WhatsApp 👉 click here](https://wa.me/923341100761)

---

## 📄 License

This project is provided for educational and portfolio purposes.

---

<p align="center">Made with ❤️ using Flutter</p>
