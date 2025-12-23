# WordPress (and more?) Editor App

A Editor like experience for mobile content and layout building.

## WordPress API

First iteration will work with the WordPress API and editor to give a better way to edit on mobile devices.

---
WIP

Screen 1
<img width="445" height="913" alt="editor-screen" src="https://github.com/user-attachments/assets/bad9cec2-4b83-447e-9a77-62492752ca65" />

Post Settings
<img width="446" height="907" alt="editor-post-settings" src="https://github.com/user-attachments/assets/2585c102-63e6-4a43-b811-73befb242579" />

Block Settings
<img width="450" height="902" alt="editor-block-settings" src="https://github.com/user-attachments/assets/cf599a8d-9735-4fb8-b623-7eade6c49b97" />

---

## 🚀 Tech Stack

- **Flutter / Dart**
- **Riverpod 2.x** (`flutter_riverpod`, `hooks_riverpod`)
- **Freezed + json_serializable**
- **go_router**
- **flutter_quill** (rich text MVP)
- **UUID**
- **WordPress REST API** (read now, write later)

---

## 🧱 Core Concepts

- Tree-first block model
- Gutenberg parity (`clientId`, `name`, `attributes`, `innerBlocks`)
- Edit Mode vs Layout Mode
- Columns / Groups supported from day one
- Inspector panel + breadcrumb navigation
- Native Flutter rendering (no WebView bullshit)

---

## 📦 Prerequisites

Make sure you have the following installed:

- **Flutter SDK** (stable)
- **Dart SDK** (bundled with Flutter)
- **Xcode** (for iOS simulator)
- **Android Studio** (for Android emulator)
- **Node.js** (optional, for tooling / future WP parsing)

Verify Flutter is ready:

```bash
flutter doctor
```

## Getting Started

Clone the repo and install dependencies

```bash
git clone <YOUR_REPO_URL>
cd <repo-name>
flutter pub get
```

then start either  
`flutter pub run build_runner build --delete-conflicting-outputs`  
`flutter pub run build_runner watch`

Use `flutter run` to run the app, it will use the default device.

