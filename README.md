# WordPress (and more?) Editor App

A Editor like experience for mobile content and layout building.

## WordPress API

First iteration will work with the WordPress API and editor to give a better way to edit on mobile devices.

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

