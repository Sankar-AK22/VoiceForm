<div align="center">

# 🇮🇳 VoiceForm

**Multilingual AI-Powered Application for Digital Form Creation via Voice Input.**

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
</p>

[Features](#-key-features) •
[Tech Stack](#%EF%B8%8F-technology-stack) •
[App Design](#-national-flag-design-system) •
[Architecture](#-project-architecture) •
[Getting Started](#-getting-started)

</div>

---

## 📖 Overview

**VoiceForm** is a revolutionary Flutter application designed to eradicate the hassle of typing out physical forms. Utilizing an intuitive, gorgeous **Indian Flag** inspired UI, this app allows users to create surveys, fill responses via voice commands in multiple Indian languages, and instantly generate digital PDF reports complete with real-time AI sentiment analysis.

This project is fully scaffolded and architected for production stability with **13 beautifully designed screens**.

---

## ✨ Key Features

- 🎤 **Real Voice Recording**: Beautiful, animated pulse UI that actively captures microphone audio.
- 🎨 **Top-Notch Design**: Built using Glassmorphism effects with backdrop blur, rounded pill shapes, robust typography (Poppins/Inter), and modern gradient finishes.
- 📱 **Complete Survey Flow**: Form creation, response review, dashboard analytics, history logs, and final PDF generation.
- 🔐 **Firebase Ready**: Pre-integrated with Firebase Auth and Firestore, configured for both global state and Android platforms.
- 🌍 **Multilingual Ready**: Boilerplate setup to accept voice data in Hindi, Tamil, Telugu, Bengali, and English.
- 🧱 **State-of-the-Art Architecture**: Pure Feature-First Clean Architecture structure managed with Riverpod.

---

## 🎨 "National Flag" Design System

The app utilizes a strictly governed, globally injected `AppTheme` specifically formulated from the Indian National Flag:

- 🟠 **Deep Saffron** (`#FF9933`): Primary elements, dominant gradients, AppBars.
- ⚪ **Clean White** (`#FFFFFF`): Neutral space, glass card surfaces.
- 🟢 **India Green** (`#138808`): Success scenarios, active recording states, and secondary actions.
- 🔵 **Navy Blue** (`#000080`): High-contrast typography, interactive icons.

---

## 🛠️ Technology Stack

| Category | Package | Description |
|---|---|---|
| **Core Framework** | `flutter` | UI Toolkit |
| **State Management** | `flutter_riverpod` + `riverpod_annotation` | Code generation state handling |
| **Navigation** | `go_router` | Declarative deep linking routing |
| **Data Modeling** | `freezed` + `json_serializable` | Immutable classes & JSON parsing |
| **Backend Service** | `firebase_core`, `auth`, `cloud_firestore` | Pre-configured for data & users |
| **Audio Hardware** | `record`, `path_provider` | Native microphone audio capture |
| **Error Handling** | `dartz` | Functional `Either<Failure, Success>` programming |

---

## 🏗 Project Architecture

VoiceForm follows a highly scrupulous **Feature-First Clean Architecture**.

```text
lib/
├── core/                   # Global components shared across the app
│   ├── data/               # Base Firestore CRUD services
│   ├── errors/             # Custom Failure handling maps
│   ├── router/             # Centralized GoRouter routes
│   └── theme/              # Global "National Flag" Theme Injection
│
├── features/               # Isolated domain-driven modules
│   ├── auth/               # Splash -> Onboarding -> Login -> Signup
│   ├── home/               # Dashboard tracking
│   ├── profile/            # App Settings
│   ├── history/            # Past Generated Forms
│   └── survey/             # Core Engine 
│       ├── data/           # Repositories executing remote calls
│       ├── domain/         # Freezed Entities and interfaces
│       └── presentation/   # UI Screens & Riverpod Controllers
│
└── main.dart               # App Bootstrap, Firebase Init, & ProviderScope
```

---

## 🚀 Getting Started

1. **Clone & Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate Freezed & Riverpod Code**
   *(Required if you alter any models or providers)*
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Verify Firebase Options**
   Ensure your `google-services.json` is correctly placed in `android/app/` (which is already configured with the Google Services Gradle plugin & BoM).

4. **Run Application**
   ```bash
   flutter run
   ```

---

## 📌 Upcoming Enhancements

* **AI Transcription API**: Pipe the recorded M4A files to an engine (like Google Cloud Speech-to-Text or Bhashini) for dynamic live transcription.
* **LLM Sentiment Mapping**: Pass parsed speech text to Gemini/ChatGPT to validate the user’s tone (`Positive`, `Negative`, `Neutral`) over the course of the survey.
* **Firebase Realtime Sync**: Synchronize Riverpod states securely to Firestore Document structures.