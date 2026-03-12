# Nerd Quizz App
![Capa do Projeto](https://github.com/isaias0cardoso/piano-app-flutter/blob/main/Piano%20App.png)

A interactive trivia and quiz application built with **Flutter** and powered by **Firebase**. 
This app fetches dynamic quiz questions directly from Firestore, tracks user progress with localized timers, and calculates scores based on correct answers.

## 🚀 Features

- **User Authentication:** Secure user login and lifecycle management powered by Firebase Auth.
- **Dynamic Questions:** Quiz questions and answer options are fetched in real-time from Cloud Firestore.
- **Interactive UI:** Smooth transitions, dynamic states, and modern typographies using `google_fonts`.
- **Timed Quizzes:** Each question features a visual timer to add a challenge, automatically advancing when time runs out.
- **Score Tracking:** Comprehensive score summary screen showing the user's performance at the end of the quiz.
- **State Management & Caching:** Utilizes `provider` for state management and `shared_preferences` for local data persistence.

## 🛠 Tech Stack

- **Frontend:** Flutter & Dart
- **Backend/BaaS:** Firebase (Authentication, Cloud Firestore)
- **State Management:** Provider
- **Design/UI:** Google Fonts, Flutter SVG, Cupertino Icons

## 📁 Project Structure

```
lib/
├── components/          # Reusable UI elements (Buttons, QuizOptionCard, QuizTimerBar, etc.)
├── models/              # Data models (e.g., QuestionModel)
├── screens/             # Main application views (LoginScreen, QuizzScreen, ScoreScreen)
├── services/            # Business logic and external API integrations (FirestoreService)
├── shared/              # Common UI helpers and app-wide colors (AppColors, ui_helpers)
└── main.dart            # Application entry point
```

## ⚙️ Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.3.1 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- An active Firebase Project

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/isaiasmobdev/nerd-quizz-app.git
   cd nerd-quizz-app
   ```

2. **Fetch dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Enable **Firebase Authentication** and **Cloud Firestore**.
   - Add your Android/iOS apps within the Firebase console.
   - Run the FlutterFire CLI to configure your app:
     ```bash
     dart pub global activate flutterfire_cli
     flutterfire configure
     ```
   - *Note: Ensure that your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are properly added but **excluded** from version control (`.gitignore`).*

4. **Run the App:**
   ```bash
   flutter run
   ```

## 🗄 Firestore Data Structure

To populate your quiz, create a `questions` collection in your Firestore database. Example document structure:
```json
{
  "text": "What does HTTP stand for?",
  "options": [
    "HyperText Transfer Protocol",
    "HyperText Transmission Protocol",
    "Hyperlink Transfer Protocol",
    "HyperText Transfer Provider"
  ],
  "correctAnswerIndex": 0
}
```

## 🔒 Security Note
Ensure that your Firebase configuration files (`firebase_options.dart`, `google-services.json`, etc.) remain ignored in `.gitignore` to protect sensitive keys.

## 📄 License
This project is for educational purposes.
