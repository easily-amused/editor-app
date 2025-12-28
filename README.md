# WordPress (and more?) Editor App

A Editor like experience for mobile content and layout building.

## WordPress API

First iteration will work with the WordPress API and editor to give a better way to edit on mobile devices.

## WIP

### Add Site
<img width="492" height="364" alt="editor-add-site" src="https://github.com/user-attachments/assets/58cd287e-a9c6-4089-af04-600ddd7f474f" />

### Content Select
<img width="462" height="762" alt="editor-content-select" src="https://github.com/user-attachments/assets/8bc1896e-e67b-410e-a666-fa449acdd2b9" />

### Editor Screen

<img width="200" alt="editor-screen" src="https://github.com/user-attachments/assets/bad9cec2-4b83-447e-9a77-62492752ca65" />

### Post Settings

<img width="200" alt="editor-post-settings" src="https://github.com/user-attachments/assets/2585c102-63e6-4a43-b811-73befb242579" />

### Block Settings

<img width="200" alt="editor-block-settings" src="https://github.com/user-attachments/assets/cf599a8d-9735-4fb8-b623-7eade6c49b97" />

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

After cloning the repo, install dependencies

```bash
flutter pub get
```

then start either  
`flutter pub run build_runner build --delete-conflicting-outputs`  
`flutter pub run build_runner watch`

Use `flutter run` to run the app, it will use the default device.

